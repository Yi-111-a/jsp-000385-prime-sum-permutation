import Mathlib
import JSP385.Defs

/-!
# JSP-000385 — Adjacent prime-sum permutation of the positive integers (ErGr80)
-/

namespace JSP385

/-- Positive naturals. -/
abbrev PosNat := {n : ℕ // 0 < n}

/-- Shift successor on positive naturals. -/
def posSucc (n : PosNat) : PosNat :=
  ⟨n.1 + 1, Nat.succ_pos _⟩

/-- ErGr80: there is a permutation of positive integers with adjacent sums prime. -/
theorem adjacent_prime_sum_permutation :
    ∃ f : PosNat ≃ PosNat,
      ∀ n : PosNat, Nat.Prime ((f n).1 + (f (posSucc n)).1) := by
  sorry

end JSP385
