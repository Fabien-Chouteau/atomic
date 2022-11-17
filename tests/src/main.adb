pragma Assertion_Policy (Check);

with Atomic;
with Atomic.Unsigned;
with Atomic.Signed;
with Ada.Text_IO;
with Interfaces;

procedure Main is

   generic
      type T is mod <>;
   procedure Test_Unsigned;

   generic
      type T is range <>;
   procedure Test_Signed;

   -------------------
   -- Test_Unsigned --
   -------------------

   procedure Test_Unsigned is
      package UAtomic is new Atomic.Unsigned (T);
      use UAtomic;

      V : aliased Instance := Init (T'Last);
      Old : T := T'Last;
      Result : T;
      Success : Boolean;
   begin

      pragma Assert (Load (V) = T'Last);
      Store (V, T'First);
      pragma Assert (Load (V) = T'First);

      Exchange (V, T'Last, Old);
      pragma Assert (Load (V) = T'Last);
      pragma Assert (Old = T'First);

      Compare_Exchange (V,
                        Expected      => T'First,
                        Desired       => T'Last / 2,
                        Weak          => True,
                        Success       => Success);
      pragma Assert (not Success);

      Compare_Exchange (V,
                        Expected      => T'Last,
                        Desired       => T'Last / 2,
                        Weak          => True,
                        Success       => Success);
      pragma Assert (Success);
      pragma Assert (Load (V) = T'Last / 2);

      --  <OP>

      Store (V, T'First);
      Add (V, 1);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      Sub (V, 1);
      pragma Assert (Load (V) = T'Last - 1);

      Store (V, T'First);
      Op_And (V, 2#1010#);
      pragma Assert (Load (V) = (T'First and 2#1010#));

      Store (V, T'First);
      Op_XOR (V, 2#1010#);
      pragma Assert (Load (V) = (T'First xor 2#1010#));

      Store (V, T'First);
      Op_OR (V, 2#1010#);
      pragma Assert (Load (V) = (T'First or 2#1010#));

      Store (V, T'First);
      NAND (V, 2#1010#);
      pragma Assert (Load (V) = (not (T'First and 2#1010#)));

      --  <OP>_Fetch

      Store (V, T'First);
      Add_Fetch (V, 1, Result);
      pragma Assert (Load (V) = T'First + 1);
      pragma Assert (Result = T'First + 1);

      Store (V, T'Last);
      Sub_Fetch (V, 1, Result);
      pragma Assert (Load (V) = T'Last - 1);
      pragma Assert (Result = T'Last - 1);

      Store (V, T'First);
      And_Fetch (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First and 2#1010#));
      pragma Assert (Result = (T'First and 2#1010#));

      Store (V, T'First);
      XOR_Fetch (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First xor 2#1010#));
      pragma Assert (Result = (T'First xor 2#1010#));

      Store (V, T'First);
      OR_Fetch (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First or 2#1010#));
      pragma Assert (Result = (T'First or 2#1010#));

      Store (V, T'First);
      NAND_Fetch (V, 2#1010#, Result);
      pragma Assert (Load (V) = (not (T'First and 2#1010#)));
      pragma Assert (Result = (not (T'First and 2#1010#)));

      --  Fetch_<OP>

      Store (V, T'First);
      Fetch_Add (V, 1, Result);
      pragma Assert (Load (V) = T'First + 1);
      pragma Assert (Result = T'First);

      Store (V, T'Last);
      Fetch_Sub (V, 1, Result);
      pragma Assert (Load (V) = T'Last - 1);
      pragma Assert (Result = T'Last);

      Store (V, T'First);
      Fetch_And (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First and 2#1010#));
      pragma Assert (Result = T'First);

      Store (V, T'First);
      Fetch_XOR (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First xor 2#1010#));
      pragma Assert (Result = T'First);

      Store (V, T'First);
      Fetch_OR (V, 2#1010#, Result);
      pragma Assert (Load (V) = (T'First or 2#1010#));
      pragma Assert (Result = T'First);

      Store (V, T'First);
      Fetch_NAND (V, 2#1010#, Result);
      pragma Assert (Load (V) = (not (T'First and 2#1010#)));
      pragma Assert (Result = T'First);

      --  Exchange

      Store (V, T'First);
      pragma Assert (Exchange (V, T'First + 1) = T'First);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'First);
      pragma Assert (not Compare_Exchange (V, T'First + 1, T'First + 1,
                                           Weak => True));
      pragma Assert (Compare_Exchange (V, T'First, T'First + 1, Weak => True));
      pragma Assert (Load (V) = T'First + 1);

      --  func <OP>_Fetch

      Store (V, T'First);
      pragma Assert (Add_Fetch (V, 1) = T'First + 1);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      pragma Assert (Sub_Fetch (V, 1) = T'Last - 1);
      pragma Assert (Load (V) = T'Last - 1);

      Store (V, T'First);
      pragma Assert (And_Fetch (V, 2#1010#) = (T'First and 2#1010#));
      pragma Assert (Load (V) = (T'First and 2#1010#));

      Store (V, T'First);
      pragma Assert (XOR_Fetch (V, 2#1010#) = (T'First xor 2#1010#));
      pragma Assert (Load (V) = (T'First xor 2#1010#));

      Store (V, T'First);
      pragma Assert (OR_Fetch (V, 2#1010#) = (T'First or 2#1010#));
      pragma Assert (Load (V) = (T'First or 2#1010#));

      Store (V, T'First);
      pragma Assert (NAND_Fetch (V, 2#1010#) = (not (T'First and 2#1010#)));
      pragma Assert (Load (V) = (not (T'First and 2#1010#)));

      --  func Fetch_<OP>

      Store (V, T'First);
      pragma Assert (Fetch_Add (V, 1) = T'First);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      pragma Assert (Fetch_Sub (V, 1) = T'Last);
      pragma Assert (Load (V) = T'Last - 1);

      Store (V, T'First);
      pragma Assert (Fetch_And (V, 2#1010#) = T'First);
      pragma Assert (Load (V) = (T'First and 2#1010#));

      Store (V, T'First);
      pragma Assert (Fetch_XOR (V, 2#1010#) = T'First);
      pragma Assert (Load (V) = (T'First xor 2#1010#));

      Store (V, T'First);
      pragma Assert (Fetch_OR (V, 2#1010#) = T'First);
      pragma Assert (Load (V) = (T'First or 2#1010#));

      Store (V, T'First);
      pragma Assert (Fetch_NAND (V, 2#1010#) = T'First);
      pragma Assert (Load (V) = (not (T'First and 2#1010#)));

      Ada.Text_IO.Put_Line ("SUCCESS Unsigned" & T'Object_Size'Img);
   end Test_Unsigned;

   -----------------
   -- Test_Signed --
   -----------------

   procedure Test_Signed is
      package UAtomic is new Atomic.Signed (T);
      use UAtomic;

      V : aliased Instance := Init (T'Last);
      Old : T := T'Last;
      Result : T;
      Success : Boolean;
   begin

      pragma Assert (Load (V) = T'Last);
      Store (V, T'First);
      pragma Assert (Load (V) = T'First);

      Exchange (V, T'Last, Old);
      pragma Assert (Load (V) = T'Last);
      pragma Assert (Old = T'First);

      Compare_Exchange (V,
                        Expected      => T'First,
                        Desired       => T'Last / 2,
                        Weak          => True,
                        Success       => Success);
      pragma Assert (not Success);

      Compare_Exchange (V,
                        Expected      => T'Last,
                        Desired       => T'Last / 2,
                        Weak          => True,
                        Success       => Success);
      pragma Assert (Success);
      pragma Assert (Load (V) = T'Last / 2);

      --  <OP>

      Store (V, T'First);
      Add (V, 1);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      Sub (V, 1);
      pragma Assert (Load (V) = T'Last - 1);

      --  <OP>_Fetch

      Store (V, T'First);
      Add_Fetch (V, 1, Result);
      pragma Assert (Load (V) = T'First + 1);
      pragma Assert (Result = T'First + 1);

      Store (V, T'Last);
      Sub_Fetch (V, 1, Result);
      pragma Assert (Load (V) = T'Last - 1);
      pragma Assert (Result = T'Last - 1);

      --  Fetch_<OP>

      Store (V, T'First);
      Fetch_Add (V, 1, Result);
      pragma Assert (Load (V) = T'First + 1);
      pragma Assert (Result = T'First);

      Store (V, T'Last);
      Fetch_Sub (V, 1, Result);
      pragma Assert (Load (V) = T'Last - 1);
      pragma Assert (Result = T'Last);

      --  Exchange

      Store (V, T'First);
      pragma Assert (Exchange (V, T'First + 1) = T'First);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'First);
      pragma Assert (not Compare_Exchange (V, T'First + 1, T'First + 1,
                                           Weak => True));
      pragma Assert (Compare_Exchange (V, T'First, T'First + 1, Weak => True));
      pragma Assert (Load (V) = T'First + 1);

      --  func <OP>_Fetch

      Store (V, T'First);
      pragma Assert (Add_Fetch (V, 1) = T'First + 1);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      pragma Assert (Sub_Fetch (V, 1) = T'Last - 1);
      pragma Assert (Load (V) = T'Last - 1);

      --  func Fetch_<OP>

      Store (V, T'First);
      pragma Assert (Fetch_Add (V, 1) = T'First);
      pragma Assert (Load (V) = T'First + 1);

      Store (V, T'Last);
      pragma Assert (Fetch_Sub (V, 1) = T'Last);
      pragma Assert (Load (V) = T'Last - 1);

      Ada.Text_IO.Put_Line ("SUCCESS Signed" & T'Object_Size'Img);
   end Test_Signed;

   procedure Test_U8 is new Test_Unsigned (Interfaces.Unsigned_8);
   procedure Test_U16 is new Test_Unsigned (Interfaces.Unsigned_16);
   procedure Test_U32 is new Test_Unsigned (Interfaces.Unsigned_32);
   procedure Test_U64 is new Test_Unsigned (Interfaces.Unsigned_64);

   procedure Test_S8 is new Test_Signed (Interfaces.Integer_8);
   procedure Test_S16 is new Test_Signed (Interfaces.Integer_16);
   procedure Test_S32 is new Test_Signed (Interfaces.Integer_32);
   procedure Test_S64 is new Test_Signed (Interfaces.Integer_64);

begin

   Test_U8;
   Test_U16;
   Test_U32;
   Test_U64;

   Test_S8;
   Test_S16;
   Test_S32;
   Test_S64;

end Main;
