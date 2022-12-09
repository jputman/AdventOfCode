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
    $seen.Add(1) | Out-Null
  }
  $forest.Add($line) | Out-Null
  $forestSeen.Add($seen) | Out-Null
}
for($r = 0; $r -lt $forest.Count; $r++){
  for($c = 0; $c -lt $forest[$r].Count; $c++){
    $view = @(0,0,0,0)
    $tree = $forest[$r][$c]
    # UP
    for($up = ($r - 1); $up -ge 0; $up--){
      if($forest[$up][$c] -lt $tree){$view[0]++}
      elseif($forest[$up][$c] -ge $tree){
        $view[0]++
        break;
      } 
    }
    # Left
    for($left = ($c - 1); $left -ge 0;$left--){
      if($forest[$r][$left] -lt $tree){$view[1]++}
      elseif($forest[$r][$left] -ge $tree){
        $view[1]++
        break
      }
    }
    # Right
    for($right = ($c+1);$right -lt $forest[$r].Count; $right++){
      if($forest[$r][$right] -lt $tree){$view[2]++}
      elseif($forest[$r][$right] -ge $tree){
        $view[2]++
        break;
      }
    }
    for($down = ($r+1); $down -lt $forest.Count; $down++){
      if($forest[$down][$c] -lt $tree){$view[3]++}
      elseif($forest[$down][$c] -ge $tree){
        $view[3]++
        break;
      }
    }
    foreach($v in ($view | Where-Object {$_ -gt 0})){
      $forestSeen[$r][$c] *= $v
    }
  }
}
$highest = 0
for($r = 1; $r -lt $forest.Count - 1; $r++){
  for($c = 1; $c -lt $forest[$r].Count - 1; $c++){
    if($forestSeen[$r][$c] -gt $highest){$highest = $forestSeen[$r][$c]}
  }
}
$highest
#$EndMS = (Get-Date)
#$EndMS - $StartMS