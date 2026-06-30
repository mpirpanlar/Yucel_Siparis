# Markdown -> HTML (docs/help/crm/*.md -> help/html/crm/*.html)
param(
    [string]$Root = (Split-Path $PSScriptRoot -Parent)
)

$ErrorActionPreference = 'Stop'
if (-not $Root) { $Root = Split-Path $PSScriptRoot -Parent }
$SrcDir = Join-Path $Root 'docs\help\crm'
$OutDir = Join-Path $Root 'help\html\crm'
$CssName = 'help.css'

if (-not (Test-Path $SrcDir)) {
    Write-Error "Kaynak klasor yok: $SrcDir"
}
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

function Escape-Html([string]$s) {
    if ($null -eq $s) { return '' }
    return ($s -replace '&', '&amp;' -replace '<', '&lt;' -replace '>', '&gt;')
}

function Convert-MdLine([string]$line) {
    $t = $line.TrimEnd()
    if ($t -match '^\*\*(.+?)\*\*$') { return "<p><strong>$($Matches[1])</strong></p>" }
    if ($t -match '^\*\*S:\*\*\s*(.*)$') { return "<p><strong>S:</strong> $(Escape-Html $Matches[1])</p>" }
    if ($t -match '^\*\*C:\*\*\s*(.*)$') { return "<p><strong>C:</strong> $(Escape-Html $Matches[1])</p>" }
    if ($t -match '^-\s+(.+)$') { return "<li>$(Escape-Html $Matches[1])</li>" }
    if ($t -eq '') { return '' }
    return "<p>$(Escape-Html $t)</p>"
}

function Convert-MdTable($rows) {
    if ($rows.Count -lt 2) { return '' }
    $sb = New-Object System.Text.StringBuilder
    [void]$sb.AppendLine('<table>')
    [void]$sb.AppendLine('<thead><tr>')
    foreach ($c in ($rows[0] -split '\|' | Where-Object { $_ -ne '' })) {
        [void]$sb.AppendLine("<th>$(Escape-Html $c.Trim())</th>")
    }
    [void]$sb.AppendLine('</tr></thead><tbody>')
    for ($i = 2; $i -lt $rows.Count; $i++) {
        $cells = $rows[$i] -split '\|' | Where-Object { $_ -ne '' }
        if ($cells.Count -eq 0) { continue }
        [void]$sb.AppendLine('<tr>')
        foreach ($c in $cells) {
            [void]$sb.AppendLine("<td>$(Escape-Html $c.Trim())</td>")
        }
        [void]$sb.AppendLine('</tr>')
    }
    [void]$sb.AppendLine('</tbody></table>')
    return $sb.ToString()
}

function Convert-MdToHtml([string]$md, [string]$title) {
    $lines = $md -split "`r?`n"
    $html = New-Object System.Collections.Generic.List[string]
    $inList = $false
    $tableRows = @()

    foreach ($line in $lines) {
        if ($line -match '^\|') {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
            $tableRows += $line
            continue
        }
        if ($tableRows.Count -gt 0) {
            $html.Add((Convert-MdTable $tableRows))
            $tableRows = @()
        }

        if ($line -match '^#\s+(.+)$') {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
            $html.Add("<h1>$(Escape-Html $Matches[1])</h1>")
        }
        elseif ($line -match '^##\s+(.+)$') {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
            $html.Add("<h2>$(Escape-Html $Matches[1])</h2>")
        }
        elseif ($line -match '^###\s+(.+)$') {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
            $html.Add("<h3>$(Escape-Html $Matches[1])</h3>")
        }
        elseif ($line -match '^-\s+(.+)$') {
            if (-not $inList) { $html.Add('<ul>'); $inList = $true }
            $html.Add("<li>$(Escape-Html $Matches[1])</li>")
        }
        elseif ($line.Trim() -eq '') {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
        }
        else {
            if ($inList) { $html.Add('</ul>'); $inList = $false }
            $conv = Convert-MdLine $line
            if ($conv) { $html.Add($conv) }
        }
    }
    if ($inList) { $html.Add('</ul>') }
    if ($tableRows.Count -gt 0) { $html.Add((Convert-MdTable $tableRows)) }

    $body = ($html -join "`n")
    @"
<!DOCTYPE html>
<html lang="tr">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>$(Escape-Html $title)</title>
<link rel="stylesheet" href="$CssName"/>
</head>
<body>
$body
</body>
</html>
"@ | Out-String
}

$count = 0
Get-ChildItem $SrcDir -Filter '*.md' | ForEach-Object {
    $md = Get-Content $_.FullName -Raw -Encoding UTF8
    $title = $_.BaseName
    if ($md -match '^#\s+(.+)') { $title = $Matches[1].Trim() }
    $html = Convert-MdToHtml $md $title
    $outFile = Join-Path $OutDir ($_.BaseName + '.html')
    [System.IO.File]::WriteAllText($outFile, $html, [System.Text.UTF8Encoding]::new($false))
    $count++
    Write-Host "OK: $($_.Name) -> $($_.BaseName).html"
}

$cssSrc = Join-Path $Root "help\html\crm\help.css"
$cssDst = Join-Path $OutDir $CssName
if ((Test-Path $cssSrc) -and ($cssSrc -ne $cssDst)) {
  Copy-Item $cssSrc $cssDst -Force
}
Write-Host "Tamamlandi: $count dosya -> $OutDir" -ForegroundColor Green
