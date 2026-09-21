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
