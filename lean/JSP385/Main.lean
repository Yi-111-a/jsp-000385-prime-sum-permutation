import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.PNat.Equiv
import Mathlib.Tactic.Common
import JSP385.Defs
import ErdosProblems.Erdos473

/-!
# JSP-000385 — Adjacent prime-sum permutation of the positive integers (ErGr80)

The existence of such a permutation is Erdős Problem 473 (answered
affirmatively by A. M. Odlyzko).  The heavy lifting is done in the vendored
`ErdosProblems.Erdos473` module; here we only repackage the statement over the
subtype `PosNat` with the `posSucc` indexing convention.
-/

namespace JSP385

/-- Positive naturals. -/
abbrev PosNat := ℕ+

/-- Shift successor on positive naturals. -/
def posSucc (n : PosNat) : PosNat :=
  ⟨n.1 + 1, Nat.succ_pos _⟩

/-- ErGr80: there is a permutation of positive integers with adjacent sums
prime. -/
theorem adjacent_prime_sum_permutation :
    ∃ f : PosNat ≃ PosNat,
      ∀ n : PosNat, Nat.Prime ((f n).1 + (f (posSucc n)).1) := by
  obtain ⟨a, ha⟩ := Erdos473.erdos_473
  refine ⟨Equiv.pnatEquivNat.trans a, fun n => ?_⟩
  have hn : 0 < (n : ℕ) := n.prop
  have h := ha ((n : ℕ) - 1)
  have e : (n : ℕ) - 1 + 1 = (n : ℕ) := by omega
  rw [e] at h
  exact h

#print axioms JSP385.adjacent_prime_sum_permutation

end JSP385
