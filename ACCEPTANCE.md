# ACCEPTANCE — JSP-000385 (prize-ready gate)

## Catalog

- Anchor: https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000385
- Awards CONTRIBUTING: https://github.com/TheJustinSunPrize/awards/blob/main/CONTRIBUTING.md

## Exact original question (English)

> Can all natural numbers be permuted so that every adjacent pair has prime sum?

The accepted resolution: Yes. There exists a permutation of the positive integers in which every pair of adjacent terms sums to a prime (ErGr80).

## Required Lean theorem name(s) (FULL statement)

| Lean name | Intended statement |
|---|---|
| `adjacent_prime_sum_permutation` | There exists a bijection f : ℕ₊ → ℕ₊ (positive naturals) such that f(n)+f(n+1) is prime for every n≥1. |

**Not sufficient for prize_ready:** weaker special cases, finite truncations, or intermediate lemmas alone.

## Checklist (all must pass)

- [ ] `lake build` succeeds in `lean/`
- [ ] Zero `sorry` / `admit` in all `*.lean` (excluding `.lake`)
- [ ] `#print axioms` on headline theorem(s) shows only standard axioms
- [ ] Public repo HEAD is a full 40-character commit SHA
- [ ] README documents build instructions
- [ ] `formalization.yaml` and/or `ATTRIBUTION.md` name `Yi-111-a` / operators
- [ ] Named headline theorem(s) above exist and are proved

## Harness rule

`prize_ready=true` **only** when every checklist item passes **and** the named headline theorem(s) exist and are proved.
