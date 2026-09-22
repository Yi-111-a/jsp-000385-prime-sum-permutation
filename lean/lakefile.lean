import Lake
open System Lake DSL

package jsp385 where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`relaxedAutoImplicit, false⟩,
    ⟨`weak.linter.mathlibStandardSet, true⟩,
    ⟨`maxSynthPendingDepth, 3⟩
  ]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.33.0"

require BoundedGaps from git "https://github.com/frenzymath/FormalPantheon.git" @
  "ffbb65c21afc8a36ace67720f1b0df1c63d26bd1" / "BoundedGaps"

-- Pin shared transitive deps to mathlib v4.33.0's own pins.  Without these,
-- resolution inherits BoundedGaps' older (v4.32-era) revs, which do not
-- compile under the v4.33.0 toolchain and are incompatible with mathlib's
-- prebuilt cache.
require batteries from git "https://github.com/leanprover-community/batteries" @
  "4488d40d070b9700d4d5a6aa342f0d40c31b2a2d"
require Qq from git "https://github.com/leanprover-community/quote4" @
  "92c15be17b7caf78c2ad767ec40f89052d908d81"
require aesop from git "https://github.com/leanprover-community/aesop" @
  "3448c0bcc5ce01b2d1546e483ec3620e32df3d0e"
require plausible from git "https://github.com/leanprover-community/plausible" @
  "b7eb3304aeae834b12dda98993a37f6a41f6f0bb"
require LeanSearchClient from git
  "https://github.com/leanprover-community/LeanSearchClient" @
  "5f4d51b81cbd3f6b32b156bfad9056621a040404"
require importGraph from git "https://github.com/leanprover-community/import-graph" @
  "16f02aa7642864af59f1ff0e384a015994db9118"
require proofwidgets from git "https://github.com/leanprover-community/ProofWidgets4" @
  "4be2e3d5087eeb272cf5a8853b8f9dd025ef5957"
require Cli from git "https://github.com/leanprover/lean4-cli" @
  "6130a47896ce867c6a4a55373441e59e565bad0f"

@[default_target]
lean_lib JSP385 where
  globs := #[.andSubmodules `JSP385]

lean_lib ErdosProblems where
  globs := #[.andSubmodules `ErdosProblems.Erdos473,
    .andSubmodules `ErdosProblems.Erdos387]

lean_lib PrimeNumberTheoremAnd where
  globs := #[.andSubmodules `PrimeNumberTheoremAnd]

private def runGitApply
    (directory patch : FilePath) (arguments : Array String) : IO IO.Process.Output :=
  IO.Process.output {
    cmd := "git"
    args := #["-C", directory.toString, "apply"] ++ arguments ++ #[patch.toString]
  }

post_update pkg do
  for (name, patchName) in #[
      ("BoundedGaps", "formalpantheon-v4.33.0.patch"),
      ("BoundedGaps", "formalpantheon-v4.33.0-s2.patch"),
      ("BoundedGaps", "boundedgaps-linter-v4.33.0.patch")] do
    let dependency := pkg.dir / ".lake" / "packages" / name
    let patch := pkg.dir / "patches" / patchName
    if !(← dependency.pathExists) then
      error s!"{name} package directory does not exist: {dependency}"
    if !(← patch.pathExists) then
      error s!"{name} compatibility patch does not exist: {patch}"
    let forwardCheck ← runGitApply dependency patch #["--check"]
    if forwardCheck.exitCode = 0 then
      let result ← runGitApply dependency patch #[]
      if result.exitCode != 0 then
        error s!"failed to apply {name} compatibility patch {patchName}:\n{result.stderr}"
      IO.println s!"Applied {name} compatibility patch {patchName}."
    else
      let reverseCheck ← runGitApply dependency patch #["--reverse", "--check"]
      if reverseCheck.exitCode = 0 then
        IO.println s!"{name} compatibility patch {patchName} is already applied."
      else
        error s!"{name} checkout is incompatible with compatibility patch {patch}.\n\
          Forward check:\n{forwardCheck.stderr}\nReverse check:\n{reverseCheck.stderr}"
