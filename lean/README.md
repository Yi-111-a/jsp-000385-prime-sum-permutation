# JSP-000385 Lean project

Formalization target: there exists a permutation `f : ℕ₊ → ℕ₊` of the positive
integers such that `f(n) + f(n+1)` is prime for every `n ≥ 1` (ErGr80 / Erdős
Problem 473, resolved by A. M. Odlyzko).

## Build

```sh
export PATH="$HOME/.elan/bin:$PATH"
lake build
```

Toolchain: `leanprover/lean4:v4.33.0`, mathlib `v4.33.0`. The build vendors
`ErdosProblems.Erdos473` plus its `BoundedGaps` (Bombieri–Vinogradov) and
`PrimeNumberTheoremAnd` dependency cone; dependency checkouts are patched by
`lakefile.lean`'s `post_update` hook using the diffs in `patches/`.

## Headline theorem

`JSP385.adjacent_prime_sum_permutation` — see `JSP385/Main.lean`, which repackages
`Erdos473.erdos_473` over the `PosNat` subtype.
