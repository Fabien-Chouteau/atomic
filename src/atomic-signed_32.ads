--  Disable checks and assertions as the contracts are not safe for concurrent
--  execution. They are only here for SPARK proof.
pragma Suppress (All_Checks);
pragma Assertion_Policy (Ignore);

with Interfaces;
with Atomic.Signed;

package Atomic.Signed_32 is new Atomic.Signed (Interfaces.Integer_32);
