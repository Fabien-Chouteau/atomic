--  Disable checks and assertions as the contracts are not safe for concurrent
--  execution. They are only here for SPARK proof.
pragma Suppress (All_Checks);
pragma Assertion_Policy (Ignore);

with Atomic.Critical_Section; use Atomic.Critical_Section;

with System;

package body Atomic is

   ----------
   -- Init --
   ----------

   function Init (Val : Boolean) return Flag is
      Ret : aliased Flag := 0;
      Unused : Boolean;
   begin
      if Val then
         Test_And_Set (Ret, Unused);
      else
         Clear (Ret);
      end if;
      return Ret;
   end Init;

   ---------
   -- Set --
   ---------

   function Set (This  : aliased Flag;
                 Order : Mem_Order := Seq_Cst)
                 return Boolean
   is
      State : Interrupt_State;
      Result : Boolean;
   begin

      Critical_Section.Enter (State);
      Result := This /= 0;
      Critical_Section.Leave (State);
      return Result;
   end Set;

   ------------------
   -- Test_And_Set --
   ------------------

   procedure Test_And_Set (This   : aliased in out Flag;
                           Result : out Boolean;
                           Order  : Mem_Order := Seq_Cst)
   is
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := This /= 0;
      This := 1;
      Critical_Section.Leave (State);
   end Test_And_Set;

   -----------
   -- Clear --
   -----------

   procedure Clear (This : aliased in out Flag;
                    Order : Mem_Order := Seq_Cst)
   is
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      This := 0;
      Critical_Section.Leave (State);
   end Clear;

end Atomic;
