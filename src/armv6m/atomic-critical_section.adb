with System.Machine_Code; use System.Machine_Code;

package body Atomic.Critical_Section is

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
   end Enter;

   -----------
   -- Leave --
   -----------

   procedure Leave (State : Interrupt_State) is
      NL : constant String := ASCII.CR & ASCII.LF;
   begin
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
