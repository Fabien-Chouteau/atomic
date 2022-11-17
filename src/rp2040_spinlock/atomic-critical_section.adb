with Atomic_Config;
with System.Machine_Code; use System.Machine_Code;

package body Atomic.Critical_Section is

   SPINLOCK_BASE    : constant := 16#D000_0100#;

   SPINLOCK_ADDRESS : constant :=
     SPINLOCK_BASE + 4 * Atomic_Config.RP2040_Spinlock_ID;

   SPINLOCK : Interfaces.Unsigned_32 with
     Volatile,
     Import,
     Address => System'To_Address (SPINLOCK_ADDRESS);

   -----------------------------------
   -- Local Subprogram Declarations --
   -----------------------------------

   procedure Spinlock_Lock
     with Inline_Always;

   procedure Spinlock_Unlock
     with Inline_Always;

   -------------------
   -- Spinlock_Lock --
   -------------------

   procedure Spinlock_Lock is
      use type Interfaces.Unsigned_32;

   begin
      --  Reads attempt to claim the lock.
      --  Read value is nonzero if the lock was successfully claimed,
      --  or zero if the lock had already been claimed by a previous read.
      loop
         exit when SPINLOCK /= 0;
      end loop;
   end Spinlock_Lock;

   ---------------------
   -- Spinlock_Unlock --
   ---------------------

   procedure Spinlock_Unlock is
      use type Interfaces.Unsigned_32;

   begin
      --  Write any value to release the lock
      SPINLOCK := 0;
   end Spinlock_Unlock;

   -----------
   -- Enter --
   -----------

   procedure Enter (State : out Interrupt_State) is
      NL : constant String := ASCII.CR & ASCII.LF;
   begin
      System.Machine_Code.Asm
        (Template =>
           "dsb" & NL &             -- Ensure completion of memory accesses
           "mrs %0, PRIMASK" & NL & -- Save PRIMASK State
           "cpsid i",               -- Clear PRIMASK
         Outputs  => Interrupt_State'Asm_Output ("=r", State),
         Inputs   => No_Input_Operands,
         Clobber  => "",
         Volatile => True);

      Spinlock_Lock;
   end Enter;

   -----------
   -- Leave --
   -----------

   procedure Leave (State : Interrupt_State) is
      NL : constant String := ASCII.CR & ASCII.LF;
   begin
      Spinlock_Unlock;

      System.Machine_Code.Asm
        (Template =>
           "dsb" & NL &       -- Ensure completion of memory accesses
           "msr PRIMASK, %0", -- restore PRIMASK
         Outputs  => No_Output_Operands,
         Inputs   => Interrupt_State'Asm_Input ("r", State),
         Clobber  => "",
         Volatile => True);
   end Leave;

end Atomic.Critical_Section;
