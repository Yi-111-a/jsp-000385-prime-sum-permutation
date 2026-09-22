# Attribution — JSP-000385

- **Problem**: Can all natural numbers be permuted so that every adjacent pair has prime sum? (Erdős–Graham, ErGr80; Erdős Problem 473)
- **Mathematical resolution**: Yes — A. M. Odlyzko.
- **Vendored Lean proof**: `ErdosProblems.Erdos473` (and supporting `ErdosProblems.Erdos387`, `BoundedGaps` Bombieri–Vinogradov cone, `PrimeNumberTheoremAnd`), originally by OpenAI Codex / GPT-5.6 Sol, Apache-2.0 — see <https://github.com/plby/lean-proofs/blob/main/ErdosProblems/Erdos473.md> and <https://github.com/frenzymath/FormalPantheon>.
- **Operators**: Yi-111-a and the JSP formalization harness operators.
- **Headline theorem**: `JSP385.adjacent_prime_sum_permutation` in `JSP385/Main.lean`.
