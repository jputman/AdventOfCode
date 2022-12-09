$StartMS = (Get-Date)
Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 8\input.txt'
$forest = [System.Collections.ArrayList]::new()
$forestSeen = [System.Collections.ArrayList]::new()
for($r = 0; $r -lt $dataInput.Count; $r++){
  $line = [System.Collections.ArrayList]::new()
  $seen = [System.Collections.ArrayList]::new()
  for($c = 0; $c -lt $dataInput[$r].Length; $c++){
    $line.Add(([int]$dataInput[$r][$c] - 48)) | Out-Null
    if(($r -ne 0 -and $r -ne $dataInput.Count - 1) -and ($c -ne 0 -and $c -ne ($dataInput[$r].Length -1))){
      $seen.Add($false) | Out-Null
    }
    else{
      $seen.Add($true) | Out-Null
    }
    
  }
  $forest.Add($line) | Out-Null
  $forestSeen.Add($seen) | Out-Null
}
for($r = 1; $r -lt $forest.Count - 1; $r++){
  for($c = 1; $c -lt $forest[$r].Count -1; $c++){
    $left = $forest[$r][0..($c - 1)]
    $right = $forest[$r][($c + 1)..$forest[$r].Count]
    $up = [System.Collections.ArrayList]::new()
    $down = [System.Collections.ArrayList]::new()
    for($i = 0; $i -lt $r; $i++){
      $up.Add($forest[$i][$c]) | Out-Null
    }
    for($i = ($r + 1); $i -lt $forest.Count; $i++){
      $down.Add($forest[$i][$c]) | Out-Null
    }    
    $checkLeft = $left | where-object {$_ -lt $forest[$r][$c]}
    $checkRight = $right | where-object {$_ -lt $forest[$r][$c]}
    $checkUp = $up | where-object {$_ -lt $forest[$r][$c]}
    $checkDown = $down | where-object {$_ -lt $forest[$r][$c]}
    $seen = $false
    if($checkLeft.Count -eq $left.Count){$seen = $true}
    if($checkRight.Count -eq $right.Count){$seen = $true}
    if($checkUp.Count -eq $up.Count){$seen = $true}
    if($checkDown.Count -eq $down.Count){$seen = $true}
    $forestSeen[$r][$c] = $seen
  }
}

$count = 0
for($r = 0; $r -lt $forest.Count; $r++){
  for($c = 0; $c -lt $forest[$r].Count; $c++){
    if($forestSeen[$r][$c] -eq $true){
      $count++
    }
  }
}
$count
$EndMS = (Get-Date)
$EndMS - $StartMS