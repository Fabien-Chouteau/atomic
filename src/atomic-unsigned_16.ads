--  Disable checks and assertions as the contracts are not safe for concurrent
--  execution. They are only here for SPARK proof.
pragma Suppress (All_Checks);
pragma Assertion_Policy (Ignore);

with Interfaces;
with Atomic.Unsigned;

package Atomic.Unsigned_16 is new Atomic.Unsigned (Interfaces.Unsigned_16);
