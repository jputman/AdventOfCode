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
    $tree = $forest[$r][$c]
    $seenUP = $true
    $seenDown = $true
    $seenLeft = $true
    $seenRight = $true
    #Write-Host "Looking at $r x $c value of $tree" -ForegroundColor Blue
    for($up = ($r - 1); $up -ge 0; $up--){
      if($forest[$up][$c] -ge $tree){
        $seenUP = $false
        break
      }
    }
    for($down = ($r+1); $down -lt $forest.Count; $down++){
      if($forest[$down][$c] -ge $tree){
        $seenDown = $false
        break
      }      
    }
    for($left = ($c - 1); $left -ge 0;$left--){
      if($forest[$r][$left] -ge $tree){
        $seenLeft = $false
        break        
      }
    }
    for($right = ($c+1);$right -lt $forest[$r].Count; $right++){
      if($forest[$r][$right] -ge $tree){
        $seenRight = $false
        break        
      }      
    }
    if($seenUP -or $seenDown -or $seenLeft -or $seenRight){
      $forestSeen[$r][$c] = $true
    }
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