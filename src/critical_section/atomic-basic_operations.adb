with Atomic.Critical_Section; use Atomic.Critical_Section;

with System;

package body Atomic.Basic_Operations
  with SPARK_Mode => Off
is

   ----------
   -- Load --
   ----------

   function Load
     (This : aliased Instance; Order : Mem_Order := Seq_Cst) return T
   is
      Vola   : T with Volatile, Import, Address => This'Address;
      State  : Interrupt_State;
      Result : T;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Critical_Section.Leave (State);
      return Result;
   end Load;

   -----------
   -- Store --
   -----------

   procedure Store
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Import, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Val;
      Critical_Section.Leave (State);
   end Store;

   --------------
   -- Exchange --
   --------------

   procedure Exchange
     (This  : aliased in out Instance;
      Val   : T;
      Old   : out T;
      Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Import, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Old := Vola;
      Vola := Val;
      Critical_Section.Leave (State);
   end Exchange;

   ----------------------
   -- Compare_Exchange --
   ----------------------

   procedure Compare_Exchange
     (This          : aliased in out Instance;
      Expected      : T;
      Desired       : T;
      Weak          : Boolean;
      Success       : out Boolean;
      Success_Order : Mem_Order := Seq_Cst;
      Failure_Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Import, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      if Vola = Expected then
         Vola := Desired;
         Success := True;
      else
         Success := False;
      end if;
      Critical_Section.Leave (State);
   end Compare_Exchange;

   --------------
   -- Exchange --
   --------------

   function Exchange
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst) return T
   is
      Result : T;
   begin
      Exchange (This, Val, Result, Order);
      return Result;
   end Exchange;

   ----------------------
   -- Compare_Exchange --
   ----------------------

   function Compare_Exchange
     (This          : aliased in out Instance;
      Expected      : T;
      Desired       : T;
      Weak          : Boolean;
      Success_Order : Mem_Order := Seq_Cst;
      Failure_Order : Mem_Order := Seq_Cst) return Boolean
   is
      Result : Boolean;
   begin
      Compare_Exchange (This, Expected, Desired, Weak, Result, Success_Order,
                        Failure_Order);
      return Result;
   end Compare_Exchange;

end Atomic.Basic_Operations;
