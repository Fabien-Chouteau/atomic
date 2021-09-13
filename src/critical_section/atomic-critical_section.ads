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
