--  Disable checks and assertions as the contracts are not safe for concurrent
--  execution. They are only here for SPARK proof.
pragma Suppress (All_Checks);
pragma Assertion_Policy (Ignore);

private with Interfaces;

package Atomic.Critical_Section
with
  Preelaborate
is

   type Interrupt_State is private;

   procedure Enter (State : out Interrupt_State)
     with Inline_Always;

   procedure Leave (State : Interrupt_State)
     with Inline_Always;

private

   type Interrupt_State is new Interfaces.Unsigned_32;

end Atomic.Critical_Section;
