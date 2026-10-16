<#
.SYNOPSIS
  Check every skill in a skills repo before it's committed: shape, privacy marking, and leaks.

.DESCRIPTION
  For each skills/<name>/SKILL.md:
    - frontmatter has name (= folder name), description starting "Use when",
      visibility (must equal -Expect), scope (project|personal), layer (engineering|platform|msp:
      which layer of the operating rules it belongs to), last-verified (YYYY-MM-DD);
    - the body has "## gotchas" and "## never" sections.
  Then scans every file under skills/ for secrets (keys, tokens, passwords, private-key blocks).
  With -Expect public it also refuses IP addresses, email addresses, machine paths, and any
  word listed in your private denylist (one per line; client names, hostnames, domains), kept
  outside the repo at ~/.config/skills-denylist.txt so the list itself is never published.
  Exits 1 on any problem, so a git pre-commit hook can block the commit.

.EXAMPLE
  .\tools\check-skills.ps1 -Root . -Expect public
#>
param(
  [string]$Root = '.',
  [Parameter(Mandatory)][ValidateSet('public', 'private')][string]$Expect,
  [string]$Denylist = (Join-Path $HOME '.config\skills-denylist.txt')
)
$ErrorActionPreference = 'Stop'
$problems = [Collections.Generic.List[string]]::new()
$skillsDir = Join-Path $Root 'skills'

foreach ($dir in Get-ChildItem -LiteralPath $skillsDir -Directory) {
  $file = Join-Path $dir.FullName 'SKILL.md'
  $rel = "skills/$($dir.Name)/SKILL.md"
  if (-not (Test-Path $file)) { $problems.Add("skills/$($dir.Name): no SKILL.md"); continue }
  $text = (Get-Content -Raw $file) -replace "`r`n", "`n"
  if ($text -notmatch '(?s)^---\n(.*?)\n---\n(.*)$') { $problems.Add("${rel}: no frontmatter block"); continue }
  $front = $Matches[1]; $body = $Matches[2]
  $field = { param($k) if ($front -match "(?m)^$($k):\s*(.+?)\s*$") { $Matches[1] } else { $null } }
  $name = & $field 'name'
  if ($name -ne $dir.Name) { $problems.Add("${rel}: name '$name' must match the folder '$($dir.Name)'") }
  if ((& $field 'description') -notmatch '^Use when ') { $problems.Add("${rel}: description must start with 'Use when'") }
  $vis = & $field 'visibility'
  if ($vis -ne $Expect) { $problems.Add("${rel}: visibility is '$vis' but this repo is $Expect") }
  if ((& $field 'scope') -notin 'project', 'personal') { $problems.Add("${rel}: scope must be project or personal") }
  if ((& $field 'layer') -notin 'engineering', 'platform', 'msp') { $problems.Add("${rel}: layer must be engineering, platform or msp (see the operating-rules layers)") }
  if ((& $field 'last-verified') -notmatch '^\d{4}-\d{2}-\d{2}$') { $problems.Add("${rel}: last-verified must be a date (YYYY-MM-DD)") }
  foreach ($h in '## gotchas', '## never') { if ($body -notmatch "(?m)^$([regex]::Escape($h))\s*$") { $problems.Add("${rel}: missing '$h' section") } }
}

$secret = @(
  '-----BEGIN [A-Z ]*PRIVATE KEY-----',
  '(?i)\b(api[_-]?key|secret|token|passw(or)?d|community)\b\s*[:=]\s*["'']?[A-Za-z0-9_\-+/=]{12,}',
  '\b(sk|pk|opk|ghp|gho|xox[bp])_[A-Za-z0-9]{16,}',
  '\bAKIA[0-9A-Z]{16}\b'
)
$public = @(
  '\b(?!127\.0\.0\.1\b)(?!0\.0\.0\.0\b)(\d{1,3}\.){3}\d{1,3}\b',
  '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
  '(?i)\b[A-Z]:\\(Users|MCP|src|Projects)\\',
  '(?i)/(home|Users)/[a-z]'
)
$deny = if ($Expect -eq 'public' -and (Test-Path $Denylist)) { Get-Content $Denylist | Where-Object { $_.Trim() -and -not $_.StartsWith('#') } } else { @() }
foreach ($f in Get-ChildItem -LiteralPath $skillsDir -Recurse -File) {
  $rel = $f.FullName.Substring((Resolve-Path $Root).Path.Length + 1) -replace '\\', '/'
  $n = 0
  foreach ($line in Get-Content -LiteralPath $f.FullName) {
    $n++
    foreach ($p in $secret) { if ($line -match $p) { $problems.Add("${rel}:${n}: looks like a secret") } }
    if ($Expect -eq 'public') {
      foreach ($p in $public) { if ($line -match $p) { $problems.Add("${rel}:${n}: '$($Matches[0])' (IP, email or machine path) in a public skill") } }
      foreach ($w in $deny) { if ($line -match [regex]::Escape($w.Trim())) { $problems.Add("${rel}:${n}: denylisted word in a public skill") } }
    }
  }
}

# Public repos: the commit's author name and email are published too. Refuse denylisted ones.
if ($Expect -eq 'public' -and $deny) {
  $author = git -C $Root var GIT_AUTHOR_IDENT 2>$null
  foreach ($w in $deny) { if ($author -and $author -match [regex]::Escape($w.Trim())) { $problems.Add("commit author '$($author -replace '\s+\d+\s+[+-]\d{4}$', '')' contains a denylisted name or email. Set this repo's git user.name/user.email to a public identity.") ; break } }
}

if ($problems.Count) {
  $problems | ForEach-Object { Write-Host "  x $_" -ForegroundColor Red }
  Write-Host "$($problems.Count) problem(s). Fix them, or see the skill-authoring skill." -ForegroundColor Red
  exit 1
}
Write-Host "skills ok ($Expect)" -ForegroundColor Green
