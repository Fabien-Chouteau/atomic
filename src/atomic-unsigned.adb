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
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_load_1");
      function Intrinsic16 (Ptr   : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_load_2");
      function Intrinsic32 (Ptr   : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_load_4");
      function Intrinsic64 (Ptr   : System.Address; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_load_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Order'Enum_Rep);
         when others => raise Program_Error;
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
      procedure Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic8, "__atomic_store_1");
      procedure Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic16, "__atomic_store_2");
      procedure Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic32, "__atomic_store_4");
      procedure Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer);
      pragma Import (Intrinsic, Intrinsic64, "__atomic_store_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Store;

   ---------
   -- Add --
   ---------

   procedure Add (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_add_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_add_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_add_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_add_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Add;

   ---------
   -- Sub --
   ---------

   procedure Sub (This  : aliased in out Instance;
                  Val   : T;
                  Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_sub_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_sub_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_sub_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_sub_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Sub;

   ------------
   -- Op_And --
   ------------

   procedure Op_And (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_and_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_and_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_and_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_and_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Op_And;

   ------------
   -- Op_XOR --
   ------------

   procedure Op_XOR (This  : aliased in out Instance;
                     Val   : T;
                     Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_xor_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_xor_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_xor_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_xor_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Op_XOR;

   -----------
   -- Op_OR --
   -----------

   procedure Op_OR (This  : aliased in out Instance;
                    Val   : T;
                    Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_or_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_or_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_or_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_or_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Op_OR;

   ----------
   -- NAND --
   ----------

   procedure NAND (This  : aliased in out Instance;
                   Val   : T;
                   Order : Mem_Order := Seq_Cst)
   is
      Unused : T;
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_nand_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_nand_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_nand_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_nand_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Unused := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Unused := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Unused := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Unused := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
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
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_exchange_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_exchange_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_exchange_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_exchange_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Old := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Old := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Old := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Old := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
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
      pragma Warnings (Off);
      function Intrinsic8 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_compare_exchange_1");
      function Intrinsic16 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_compare_exchange_2");
      function Intrinsic32 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_compare_exchange_4");
      function Intrinsic64 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_compare_exchange_8");
      pragma Warnings (On);

      Exp : T := Expected;
   begin
      case T'Object_Size is
         when  8 => Success := Intrinsic8 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 16 => Success := Intrinsic16 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 32 => Success := Intrinsic32 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 64 => Success := Intrinsic64 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Compare_Exchange;

   ---------------
   -- Add_Fetch --
   ---------------

   procedure Add_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_add_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_add_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_add_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_add_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   procedure Sub_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_sub_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_sub_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_sub_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_sub_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   procedure And_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_and_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_and_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_and_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_and_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   procedure XOR_Fetch (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_xor_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_xor_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_xor_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_xor_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   procedure OR_Fetch (This  : aliased in out Instance;
                      Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_or_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_or_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_or_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_or_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   procedure NAND_Fetch (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_nand_fetch_1");
      function Intrinsic16 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_nand_fetch_2");
      function Intrinsic32 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_nand_fetch_4");
      function Intrinsic64 (Ptr   : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_nand_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   procedure Fetch_Add (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_add_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_add_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_add_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_add_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   procedure Fetch_Sub (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_sub_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_sub_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_sub_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_sub_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   procedure Fetch_And (This  : aliased in out Instance;
                        Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_and_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_and_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_and_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_and_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   procedure Fetch_XOR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_xor_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_xor_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_xor_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_xor_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   procedure Fetch_OR (This  : aliased in out Instance;
                       Val   : T;
                        Result : out T;
                        Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_or_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_or_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_or_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_or_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   procedure Fetch_NAND (This  : aliased in out Instance;
                         Val   : T;
                         Result : out T;
                         Order : Mem_Order := Seq_Cst)
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_nand_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_nand_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_nand_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_nand_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => Result := Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => Result := Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => Result := Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => Result := Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
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
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_exchange_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_exchange_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_exchange_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_exchange_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
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
      Failure_Order : Mem_Order := Seq_Cst)
      return Boolean
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_compare_exchange_1");
      function Intrinsic16 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_compare_exchange_2");
      function Intrinsic32 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_compare_exchange_4");
      function Intrinsic64 (Ptr, Expected : System.Address; Desired : T; Weak : Boolean; Success_Order, Failure_Order : Integer) return Boolean;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_compare_exchange_8");
      pragma Warnings (On);

      Exp : T := Expected;
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Exp'Address, Desired, Weak, Success_Order'Enum_Rep, Failure_Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Compare_Exchange;

   ---------------
   -- Add_Fetch --
   ---------------

   function Add_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_add_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_add_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_add_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_add_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Add_Fetch;

   ---------------
   -- Sub_Fetch --
   ---------------

   function Sub_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_sub_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_sub_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_sub_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_sub_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Sub_Fetch;

   ---------------
   -- And_Fetch --
   ---------------

   function And_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_and_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_and_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_and_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_and_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end And_Fetch;

   ---------------
   -- XOR_Fetch --
   ---------------

   function XOR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_xor_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_xor_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_xor_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_xor_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end XOR_Fetch;

   --------------
   -- OR_Fetch --
   --------------

   function OR_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_or_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_or_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_or_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_or_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end OR_Fetch;

   ----------------
   -- NAND_Fetch --
   ----------------

   function NAND_Fetch
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_nand_fetch_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_nand_fetch_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_nand_fetch_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_nand_fetch_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end NAND_Fetch;

   ---------------
   -- Fetch_Add --
   ---------------

   function Fetch_Add
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_add_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_add_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_add_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_add_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_Add;

   ---------------
   -- Fetch_Sub --
   ---------------

   function Fetch_Sub
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_sub_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_sub_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_sub_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_sub_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_Sub;

   ---------------
   -- Fetch_And --
   ---------------

   function Fetch_And
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_and_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_and_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_and_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_and_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_And;

   ---------------
   -- Fetch_XOR --
   ---------------

   function Fetch_XOR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_xor_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_xor_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_xor_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_xor_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_XOR;

   --------------
   -- Fetch_OR --
   --------------

   function Fetch_OR
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_or_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_or_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_or_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_or_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_OR;

   ----------------
   -- Fetch_NAND --
   ----------------

   function Fetch_NAND
     (This : aliased in out Instance; Val : T; Order : Mem_Order := Seq_Cst)
      return T
   is
      pragma Warnings (Off);
      function Intrinsic8 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic8, "__atomic_fetch_nand_1");
      function Intrinsic16 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic16, "__atomic_fetch_nand_2");
      function Intrinsic32 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic32, "__atomic_fetch_nand_4");
      function Intrinsic64 (Ptr : System.Address; Val : T; Model : Integer) return T;
      pragma Import (Intrinsic, Intrinsic64, "__atomic_fetch_nand_8");
      pragma Warnings (On);
   begin
      case T'Object_Size is
         when  8 => return Intrinsic8 (This'Address, Val, Order'Enum_Rep);
         when 16 => return Intrinsic16 (This'Address, Val, Order'Enum_Rep);
         when 32 => return Intrinsic32 (This'Address, Val, Order'Enum_Rep);
         when 64 => return Intrinsic64 (This'Address, Val, Order'Enum_Rep);
         when others => raise Program_Error;
      end case;
   end Fetch_NAND;

end Atomic.Unsigned;
