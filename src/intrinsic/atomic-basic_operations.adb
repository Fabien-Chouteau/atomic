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
      pragma Warnings (Off);

      function Intrinsic8
        (Ptr : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_load_1");

      function Intrinsic16
        (Ptr : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_load_2");

      function Intrinsic32
        (Ptr : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_load_4");

      function Intrinsic64
        (Ptr : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_load_8");

      pragma Warnings (On);
   begin
      case T'Object_Size is
         when 8      =>
            return Intrinsic8 (This'Address, Order'Enum_Rep);

         when 16     =>
            return Intrinsic16 (This'Address, Order'Enum_Rep);

         when 32     =>
            return Intrinsic32 (This'Address, Order'Enum_Rep);

         when 64     =>
            return Intrinsic64 (This'Address, Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
   end Load;

   -----------
   -- Store --
   -----------

   procedure Store
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);

      procedure Intrinsic8
        (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic8, "__atomic_store_1");

      procedure Intrinsic16
        (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic16, "__atomic_store_2");

      procedure Intrinsic32
        (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic32, "__atomic_store_4");

      procedure Intrinsic64
        (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic64, "__atomic_store_8");

      pragma Warnings (On);
   begin
      case T'Object_Size is
         when 8      =>
            Intrinsic8 (This'Address, Val, Order'Enum_Rep);

         when 16     =>
            Intrinsic16 (This'Address, Val, Order'Enum_Rep);

         when 32     =>
            Intrinsic32 (This'Address, Val, Order'Enum_Rep);

         when 64     =>
            Intrinsic64 (This'Address, Val, Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
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
      pragma Warnings (Off);

      function Intrinsic8
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_exchange_1");

      function Intrinsic16
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_exchange_2");

      function Intrinsic32
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_exchange_4");

      function Intrinsic64
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_exchange_8");

      pragma Warnings (On);
   begin
      case T'Object_Size is
         when 8      =>
            Old := Intrinsic8 (This'Address, Val, Order'Enum_Rep);

         when 16     =>
            Old := Intrinsic16 (This'Address, Val, Order'Enum_Rep);

         when 32     =>
            Old := Intrinsic32 (This'Address, Val, Order'Enum_Rep);

         when 64     =>
            Old := Intrinsic64 (This'Address, Val, Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
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
      pragma Warnings (Off);

      function Intrinsic8
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_compare_exchange_1");

      function Intrinsic16
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_compare_exchange_2");

      function Intrinsic32
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_compare_exchange_4");

      function Intrinsic64
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_compare_exchange_8");

      pragma Warnings (On);

      Exp : T := Expected;
   begin
      case T'Object_Size is
         when 8      =>
            Success :=
              Intrinsic8
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 16     =>
            Success :=
              Intrinsic16
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 32     =>
            Success :=
              Intrinsic32
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 64     =>
            Success :=
              Intrinsic64
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
   end Compare_Exchange;

   --------------
   -- Exchange --
   --------------

   function Exchange
     (This  : aliased in out Instance;
      Val   : T;
      Order : Mem_Order := Seq_Cst) return T
   is
      pragma Warnings (Off);

      function Intrinsic8
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_exchange_1");

      function Intrinsic16
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_exchange_2");

      function Intrinsic32
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_exchange_4");

      function Intrinsic64
        (Ptr : System.Address; Val : T; Model : Integer)
         return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_exchange_8");

      pragma Warnings (On);
   begin
      case T'Object_Size is
         when 8      =>
            return Intrinsic8 (This'Address, Val, Order'Enum_Rep);

         when 16     =>
            return Intrinsic16 (This'Address, Val, Order'Enum_Rep);

         when 32     =>
            return Intrinsic32 (This'Address, Val, Order'Enum_Rep);

         when 64     =>
            return Intrinsic64 (This'Address, Val, Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
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
      pragma Warnings (Off);

      function Intrinsic8
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_compare_exchange_1");

      function Intrinsic16
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_compare_exchange_2");

      function Intrinsic32
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_compare_exchange_4");

      function Intrinsic64
        (Ptr, Expected                : System.Address;
         Desired                      : T;
         Weak                         : Boolean;
         Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_compare_exchange_8");

      pragma Warnings (On);

      Exp : T := Expected;
   begin
      case T'Object_Size is
         when 8      =>
            return
              Intrinsic8
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 16     =>
            return
              Intrinsic16
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 32     =>
            return
              Intrinsic32
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when 64     =>
            return
              Intrinsic64
                (This'Address,
                 Exp'Address,
                 Desired,
                 Weak,
                 Success_Order'Enum_Rep,
                 Failure_Order'Enum_Rep);

         when others =>
            raise Program_Error;
      end case;
   end Compare_Exchange;

end Atomic.Basic_Operations;
