with Atomic.Critical_Section; use Atomic.Critical_Section;
with System;

package body Atomic.Unsigned
with SPARK_Mode => Off
is

   ----------
   -- Load --
   ----------

   function Load
     (This : aliased Instance;
      Order : Mem_Order := Seq_Cst)
      return T
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
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
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Val;
      Critical_Section.Leave (State);
   end Store;

   ---------
   -- Add --
   ---------

   procedure Add (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Vola + Val;
      Critical_Section.Leave (State);
   end Add;

   ---------
   -- Sub --
   ---------

   procedure Sub (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Vola - Val;
      Critical_Section.Leave (State);
   end Sub;

   ------------
   -- Op_And --
   ------------

   procedure Op_And (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Vola and Val;
      Critical_Section.Leave (State);
   end Op_And;

   ------------
   -- Op_XOR --
   ------------

   procedure Op_XOR (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Vola xor Val;
      Critical_Section.Leave (State);
   end Op_XOR;

   -----------
   -- Op_OR --
   -----------

   procedure Op_OR (This  : aliased in out Instance;
                    Val   : T;
                    Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := Vola or Val;
      Critical_Section.Leave (State);
   end Op_OR;

   ----------
   -- NAND --
   ----------

   procedure NAND (This  : aliased in out Instance;
                   Val   : T;
                   Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Vola := not (Vola and Val);
      Critical_Section.Leave (State);
   end NAND;

   -- SPARK compatible --

   --------------
   -- Exchange --
   --------------

   procedure Exchange (This  : aliased in out Instance;
                       Val   : T;
                       Old   : out T;
                       Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
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

   procedure Compare_Exchange (This          : aliased in out Instance;
                               Expected      : T;
                               Desired       : T;
                               Weak          : Boolean;
                               Success       : out Boolean;
                               Success_Order : Mem_Order := Seq_Cst;
                               Failure_Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
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

   ---------------
   -- Add_Fetch --
   ---------------

   procedure Add_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola + Val;
      Vola := Result;
      Critical_Section.Leave (State);
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   procedure Sub_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola - Val;
      Vola := Result;
      Critical_Section.Leave (State);
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   procedure And_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola and Val;
      Vola := Result;
      Critical_Section.Leave (State);
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   procedure XOR_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola xor Val;
      Vola := Result;
      Critical_Section.Leave (State);
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   procedure OR_Fetch (This  : aliased in out Instance;
                      Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola or Val;
      Vola := Result;
      Critical_Section.Leave (State);
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   procedure NAND_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := not (Vola and Val);
      Vola := Result;
      Critical_Section.Leave (State);
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   procedure Fetch_Add (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := Vola + Val;
      Critical_Section.Leave (State);
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   procedure Fetch_Sub (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := Vola - Val;
      Critical_Section.Leave (State);
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   procedure Fetch_And (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := Vola and Val;
      Critical_Section.Leave (State);
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   procedure Fetch_XOR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := Vola xor Val;
      Critical_Section.Leave (State);
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   procedure Fetch_OR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := Vola or Val;
      Critical_Section.Leave (State);
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   procedure Fetch_NAND (This  : aliased in out Instance;
                         Val   : T;
                         Result : out T;
                         Order : Mem_Order := Seq_Cst)
   is
      Vola  : T with Volatile, Address => This'Address;
      State : Interrupt_State;
   begin
      Critical_Section.Enter (State);
      Result := Vola;
      Vola := not (Vola and Val);
      Critical_Section.Leave (State);
   end Fetch_NAND;

   -- NOT SPARK Compatible --

   --------------
   -- Exchange --
   --------------

   function Exchange
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst)
      return T
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
      Failure_Order : Mem_Order := Seq_Cst)
      return Boolean
   is
      Result : Boolean;
   begin
      Compare_Exchange (This, Expected, Desired, Weak, Result, Success_Order,
                        Failure_Order);
      return Result;
   end Compare_Exchange;

   ---------------
   -- Add_Fetch --
   ---------------

   function Add_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Add_Fetch (This, Val, Result, Order);
      return Result;
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   function Sub_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Sub_Fetch (This, Val, Result, Order);
      return Result;
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   function And_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      And_Fetch (This, Val, Result, Order);
      return Result;
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   function XOR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      XOR_Fetch (This, Val, Result, Order);
      return Result;
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   function OR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      OR_Fetch (This, Val, Result, Order);
      return Result;
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   function NAND_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      NAND_Fetch (This, Val, Result, Order);
      return Result;
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   function Fetch_Add
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_Add (This, Val, Result, Order);
      return Result;
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   function Fetch_Sub
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_Sub (This, Val, Result, Order);
      return Result;
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   function Fetch_And
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_And (This, Val, Result, Order);
      return Result;
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   function Fetch_XOR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_XOR (This, Val, Result, Order);
      return Result;
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   function Fetch_OR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_OR (This, Val, Result, Order);
      return Result;
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   function Fetch_NAND
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      Result : T;
   begin
      Fetch_NAND (This, Val, Result, Order);
      return Result;
   end Fetch_NAND;

end Atomic.Unsigned;
