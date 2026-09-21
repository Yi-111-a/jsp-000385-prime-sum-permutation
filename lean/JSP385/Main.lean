import Mathlib
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
abbrev PosNat := {n : ℕ // 0 < n}

/-- Shift successor on positive naturals. -/
def posSucc (n : PosNat) : PosNat :=
  ⟨n.1 + 1, Nat.succ_pos _⟩

/-- ErGr80: there is a permutation of positive integers with adjacent sums
prime. -/
theorem adjacent_prime_sum_permutation :
    ∃ f : PosNat ≃ PosNat,
      ∀ n : PosNat, Nat.Prime ((f n).1 + (f (posSucc n)).1) := by
  obtain ⟨a, ha⟩ := Erdos473.erdos_473
  refine ⟨(Equiv.pnatEquivNat.trans a : PosNat ≃ PosNat), fun n => ?_⟩
  have hn : 1 ≤ (n : ℕ) := n.prop
  have hcoerce_succ : ((posSucc n : PosNat) : ℕ) = (n : ℕ) + 1 := rfl
  have hsum : (((Equiv.pnatEquivNat.trans a : PosNat ≃ PosNat) n : PosNat) : ℕ) +
        (((Equiv.pnatEquivNat.trans a : PosNat ≃ PosNat) (posSucc n) : PosNat) : ℕ) =
          (a ((n : ℕ) - 1) : ℕ) + (a ((n : ℕ) - 1 + 1) : ℕ) := by
    have hpred : Equiv.pnatEquivNat n = (n : ℕ) - 1 := by
      simp [Equiv.pnatEquivNat, PNat.natPred]
    have hpred_succ : Equiv.pnatEquivNat (posSucc n) = (n : ℕ) := by
      simp [Equiv.pnatEquivNat, PNat.natPred, posSucc]
    simp only [Equiv.trans_apply, hpred, hpred_succ]
    congr 1
    congr 1
    omega
  rw [hsum]
  exact ha ((n : ℕ) - 1)

end JSP385
