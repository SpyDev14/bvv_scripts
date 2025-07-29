<#
.SYNOPSIS
	Enhanced directory tree visualization with visual markers
.DESCRIPTION
	Displays directory structure with markers for directories and files
.EXAMPLE
	truetree.ps1 -Path "C:\Projects" -Depth 2
#>

param (
	[string]$Path = ".",
	[int]$Depth = [int]::MaxValue
)

function Get-TreeStructure {
	param (
		[string]$currentPath,
		[string]$indent = "",
		[int]$currentDepth = 0,
		[int]$maxDepth = [int]::MaxValue,
		[bool]$isRoot = $false
	)

	if ($currentDepth -ge $maxDepth) { return }

	$items = Get-ChildItem -Path $currentPath | Sort-Object Name
	
	for ($i = 0; $i -lt $items.Count; $i++) {
		$item = $items[$i]
		$isLast = ($i -eq $items.Count - 1)
		$prefix = if ($isRoot -and $items.Count -eq 1) { "└──" } 
				elseif ($isLast) { "└──" } 
				else { "├──" }
		
		if ($item.PSIsContainer) {
			Write-Host ("$indent$prefix" + "📁 ") -NoNewline
			Write-Host $item.Name -ForegroundColor Cyan
			$newIndent = if ($isRoot -and $items.Count -eq 1) { $indent + "   " } 
						else { $indent + ("│  " * !$isLast + "    " * $isLast) }
			Get-TreeStructure -currentPath $item.FullName -indent $newIndent -currentDepth ($currentDepth + 1) -maxDepth $maxDepth
			
			if ($isLast) { Write-Host ("$indent") }
		}
		else {
			Write-Host ("$indent$prefix" + "📄 " + $item.Name)
			if ($isLast) { Write-Host ("$indent") }
		}
	}
}

Write-Host "🌳 " -NoNewline
Write-Host (Resolve-Path $Path).Path -ForegroundColor Green
Get-TreeStructure -currentPath $Path -isRoot $true -maxDepth $Depth
