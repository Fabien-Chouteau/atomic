#!python3

import os

def generate_atomic_bindings_spec(filename, package, bytes):
    args = {'package': package,
            'bytes': bytes}
    with open(filename, "w") as f:
        f.write("""
generic
   type T is mod <>;
package Atomic.{package}
with Preelaborate, Spark_Mode => On
is
   --  Based on GCC atomic built-ins. See:
   --  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
   --
   --  The specification is exactly the same for all sizes of data (8, 16, 32,
   --  64).

   type Instance is limited private;
   --  This type is limited and private, it can only be manipulated using the
   --  primitives below.

   function Init (Val : T) return Instance
     with Post => Value (Init'Result) = Val;
   --  Can be used to initialize an atomic instance:
   --
   --  A : Atomic.Unsigned_8.Instance := Atomic.Unsigned_8.Init (0);

   function Value (This : Instance) return T
     with Ghost;
   --  Ghost function to get the value of an instance without needing it
   --  aliased. This function can be used in contracts for instance.
   --  This doesn't use the atomic built-ins.

   function Load (This  : aliased Instance;
                  Order : Mem_Order := Seq_Cst)
                  return T
     with Pre  => Order in Relaxed | Consume | Acquire | Seq_Cst,
          Post => Load'Result = Value (This);

   procedure Store (This  : aliased in out Instance;
                    Val   : T;
                    Order : Mem_Order := Seq_Cst)
     with Pre  => Order in Relaxed | Release | Seq_Cst,
          Post => Value (This) = Val;

   procedure Exchange (This  : aliased in out Instance;
                       Val   : T;
                       Old   : out T;
                       Order : Mem_Order := Seq_Cst)
     with Pre  => Order in Relaxed | Acquire | Release | Acq_Rel | Seq_Cst,
          Post => Old = Value (This)'Old and then Value (This) = Val;

   procedure Compare_Exchange (This          : aliased in out Instance;
                               Expected      : T;
                               Desired       : T;
                               Weak          : Boolean;
                               Success       : out Boolean;
                               Success_Order : Mem_Order := Seq_Cst;
                               Failure_Order : Mem_Order := Seq_Cst)
     with Pre  => Failure_Order in Relaxed | Consume | Acquire | Seq_Cst
                  and then
                  not Stronger (Failure_Order, Success_Order),
          Post => Success = (Value (This)'Old = Expected)
                  and then
                  (if Success then Value (This) = Desired);

   procedure Add (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = Value (This)'Old + Val;

   procedure Sub (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = Value (This)'Old - Val;

   procedure Op_And (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = (Value (This)'Old and Val);

   procedure Op_XOR (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = (Value (This)'Old xor Val);

   procedure Op_OR (This  : aliased in out Instance;
                    Val   : T;
                    Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = (Value (This)'Old or Val);

   procedure NAND (This  : aliased in out Instance;
                   Val   : T;
                   Order : Mem_Order := Seq_Cst)
     with Post => Value (This) = not (Value (This)'Old and Val);

   procedure Add_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = (Value (This)'Old + Val)
     and then Value (This) = Result;

   procedure Sub_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = (Value (This)'Old - Val)
     and then Value (This) = Result;

   procedure And_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = (Value (This)'Old and Val)
     and then Value (This) = Result;

   procedure XOR_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = (Value (This)'Old xor Val)
     and then Value (This) = Result;

   procedure OR_Fetch (This  : aliased in out Instance;
                      Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = (Value (This)'Old or Val)
     and then Value (This) = Result;

   procedure NAND_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = not (Value (This)'Old and Val)
     and then Value (This) = Result;

   procedure Fetch_Add (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = (Value (This)'Old + Val);

   procedure Fetch_Sub (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = (Value (This)'Old - Val);

   procedure Fetch_And (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = (Value (This)'Old and Val);

   procedure Fetch_XOR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = (Value (This)'Old xor Val);

   procedure Fetch_OR (This  : aliased in out Instance;
                      Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = (Value (This)'Old or Val);

   procedure Fetch_NAND (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
     with Post => Result = Value (This)'Old
     and Value (This) = not (Value (This)'Old and Val);

   -- NOT SPARK compatible --

   function Exchange (This  : aliased in out Instance;
                      Val   : T;
                      Order : Mem_Order := Seq_Cst)
                      return T
     with SPARK_Mode => Off,
          Post => Exchange'Result = Value (This)'Old
     and then Value (This) = Val;

   function Compare_Exchange (This          : aliased in out Instance;
                              Expected      : T;
                              Desired       : T;
                              Weak          : Boolean;
                              Success_Order : Mem_Order := Seq_Cst;
                              Failure_Order : Mem_Order := Seq_Cst)
                              return Boolean
     with SPARK_Mode => Off,
          Post =>
       Compare_Exchange'Result = (Value (This)'Old = Expected)
     and then
       (if Compare_Exchange'Result then Value (This) = Desired);

   function Add_Fetch (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off,
          Post => Add_Fetch'Result = (Value (This)'Old + Val)
     and then Value (This) = Add_Fetch'Result;

   function Sub_Fetch (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off,
          Post => Sub_Fetch'Result = (Value (This)'Old - Val)
     and then Value (This) = Sub_Fetch'Result;

   function And_Fetch (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off,
          Post => And_Fetch'Result = (Value (This)'Old and Val)
     and then Value (This) = And_Fetch'Result;

   function XOR_Fetch (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off,
          Post => XOR_Fetch'Result = (Value (This)'Old xor Val)
     and then Value (This) = XOR_Fetch'Result;

   function OR_Fetch (This  : aliased in out Instance;
                      Val   : T;
                      Order : Mem_Order := Seq_Cst)
                      return T
     with SPARK_Mode => Off,
          Post => OR_Fetch'Result = (Value (This)'Old or Val)
     and then Value (This) = OR_Fetch'Result;

   function NAND_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Order : Mem_Order := Seq_Cst)
                        return T
     with SPARK_Mode => Off,
          Post => NAND_Fetch'Result = not (Value (This)'Old and Val)
     and then Value (This) = NAND_Fetch'Result;

   function Fetch_Add (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off;

   function Fetch_Sub (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off;

   function Fetch_And (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off;

   function Fetch_XOR (This  : aliased in out Instance;
                       Val   : T;
                       Order : Mem_Order := Seq_Cst)
                       return T
     with SPARK_Mode => Off;

   function Fetch_OR (This  : aliased in out Instance;
                      Val   : T;
                      Order : Mem_Order := Seq_Cst)
                      return T
     with SPARK_Mode => Off;

   function Fetch_NAND (This  : aliased in out Instance;
                        Val   : T;
                        Order : Mem_Order := Seq_Cst)
                        return T
     with SPARK_Mode => Off;

private

   type Instance is new T;

   ----------
   -- Init --
   ----------

   function Init (Val : T) return Instance
   is (Instance (Val));

   -----------
   -- Value --
   -----------

   function Value (This : Instance) return T
   is (T (This));

   pragma Inline (Init);
   pragma Inline (Load);
   pragma Inline (Store);
   pragma Inline (Exchange);
   pragma Inline (Compare_Exchange);
   pragma Inline (Add);
   pragma Inline (Sub);
   pragma Inline (Op_And);
   pragma Inline (Op_XOR);
   pragma Inline (Op_OR);
   pragma Inline (NAND);
   pragma Inline (Add_Fetch);
   pragma Inline (Sub_Fetch);
   pragma Inline (And_Fetch);
   pragma Inline (XOR_Fetch);
   pragma Inline (OR_Fetch);
   pragma Inline (NAND_Fetch);
   pragma Inline (Fetch_Add);
   pragma Inline (Fetch_Sub);
   pragma Inline (Fetch_And);
   pragma Inline (Fetch_XOR);
   pragma Inline (Fetch_OR);
   pragma Inline (Fetch_NAND);

end Atomic.{package};
""".format(**args))


def generate_atomic_bindings_body(filename, package, bytes):
    args = {'package': package,
            'bytes': bytes}
    with open(filename, "w") as f:
        f.write("""with System;

package body Atomic.{package}
with SPARK_Mode => Off
is

   Size_Suffix : constant String := "{bytes}";
   --  The value of this constant is the only difference between the package
   --  bodies for the different data sizes (8, 16, 32, 64).

   ----------
   -- Load --
   ----------

   function Load
     (This : aliased Instance;
      Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_load_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Order'Enum_Rep);
   end Load;

   -----------
   -- Store --
   -----------

   procedure Store
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst)
   is
      procedure Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer);
      pragma Import (Intrinsic, Intrinsic, "__atomic_store_" & Size_Suffix);
   begin
      Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Store;

   ---------
   -- Add --
   ---------

   procedure Add (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_add_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Add;

   ---------
   -- Sub --
   ---------

   procedure Sub (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_sub_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Sub;

   ------------
   -- Op_And --
   ------------

   procedure Op_And (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_and_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Op_And;

   ------------
   -- Op_XOR --
   ------------

   procedure Op_XOR (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_xor_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Op_XOR;

   -----------
   -- Op_OR --
   -----------

   procedure Op_OR (This  : aliased in out Instance;
                    Val   : T;
                    Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_or_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Op_OR;

   ----------
   -- NAND --
   ----------

   procedure NAND (This  : aliased in out Instance;
                   Val   : T;
                   Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_nand_fetch_" & Size_Suffix);
   begin
      Unused := Intrinsic (This'Address, Val, Order'Enum_Rep);
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
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_exchange_" & Size_Suffix);
   begin
      Old := Intrinsic (This'Address, Val, Order'Enum_Rep);
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
      function Intrinsic
        (Ptr      : System.Address;
         Expected : System.Address;
         Desired  : T;
         Weak     : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_compare_exchange_" & Size_Suffix);

      Exp : T := Expected;
   begin
      Success := Intrinsic (This'Address, Exp'Address,
                            Desired,
                            Weak,
                            Success_Order'Enum_Rep,
                            Failure_Order'Enum_Rep);
   end Compare_Exchange;

   ---------------
   -- Add_Fetch --
   ---------------

   procedure Add_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_add_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   procedure Sub_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_sub_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   procedure And_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_and_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   procedure XOR_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_xor_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   procedure OR_Fetch (This  : aliased in out Instance;
                      Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_or_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   procedure NAND_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_and_fetch_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   procedure Fetch_Add (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_add_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   procedure Fetch_Sub (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_sub_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   procedure Fetch_And (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_and_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   procedure Fetch_XOR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_xor_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   procedure Fetch_OR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_or_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   procedure Fetch_NAND (This  : aliased in out Instance;
                         Val   : T;
                         Result : out T;
                         Order : Mem_Order := Seq_Cst)
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_fetch_nand_" & Size_Suffix);
   begin
      Result := Intrinsic (This'Address, Val, Order'Enum_Rep);
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
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_exchange_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
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
      function Intrinsic
        (Ptr      : System.Address;
         Expected : System.Address;
         Desired  : T;
         Weak     : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_compare_exchange_" & Size_Suffix);

      Exp : T := Expected;
   begin
      return Intrinsic (This'Address, Exp'Address,
                        Desired,
                        Weak,
                        Success_Order'Enum_Rep,
                        Failure_Order'Enum_Rep);
   end Compare_Exchange;

   ---------------
   -- Add_Fetch --
   ---------------

   function Add_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_add_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   function Sub_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_sub_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   function And_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_and_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   function XOR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_xor_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   function OR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_or_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   function NAND_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_nand_fetch_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   function Fetch_Add
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_add_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   function Fetch_Sub
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_sub_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   function Fetch_And
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_and_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   function Fetch_XOR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_xor_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   function Fetch_OR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic, "__atomic_fetch_or_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   function Fetch_NAND
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      function Intrinsic
        (Ptr   : System.Address;
         Val   : T;
         Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic,
                     "__atomic_fetch_nand_" & Size_Suffix);
   begin
      return Intrinsic (This'Address, Val, Order'Enum_Rep);
   end Fetch_NAND;

end Atomic.{package};
""".format(**args))


src_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'src')

generate_atomic_bindings_spec(os.path.join(src_dir, 'atomic-generic8.ads'), 'Generic8', '1')
generate_atomic_bindings_body(os.path.join(src_dir, 'atomic-generic8.adb'), 'Generic8', '1')
generate_atomic_bindings_spec(os.path.join(src_dir, 'atomic-generic16.ads'), 'Generic16', '2')
generate_atomic_bindings_body(os.path.join(src_dir, 'atomic-generic16.adb'), 'Generic16', '2')
generate_atomic_bindings_spec(os.path.join(src_dir, 'atomic-generic32.ads'), 'Generic32', '4')
generate_atomic_bindings_body(os.path.join(src_dir, 'atomic-generic32.adb'), 'Generic32', '4')
generate_atomic_bindings_spec(os.path.join(src_dir, 'atomic-generic64.ads'), 'Generic64', '8')
generate_atomic_bindings_body(os.path.join(src_dir, 'atomic-generic64.adb'), 'Generic64', '8')
