Clear-Host
Write-Host '----------------------------------------- Start Script -----------------------------------------' -ForegroundColor Blue
$data = Get-Content '.\Data.txt'
$grid = @{}
$riskValues = @()
$foundRisks = @()


function lookForDanger($grid, $value){
  $risks = @()
  for($x = 0; $x -lt $grid.Count; $x++){
    for($y = 0; $y -lt $grid[$x].Count; $y++){
      $v = [int]$grid[$x][$y] - 48
      if($v -eq $value){
        $danger = checkAround -x $x -y $y -val $grid[$x][$y]
        if($danger){
          $risks += [pscustomobject]@{x = $x; y = $y; value = $value}
        }
      }
    }
  } 
  return $risks
}

function checkAround($x, $y, $val){
  
  [System.Collections.ArrayList]$xpos = -1,1
  [System.Collections.ArrayList]$ypos = -1,1
  if($x -eq 0){
    $xpos.Remove(-1)
  }
  elseif($x -eq $grid.Count - 1){
    $xpos.Remove(1)    
  }
  if($y -eq 0){
    $ypos.Remove(-1)
  }
  elseif($y -eq $grid[$x].Count - 1){
    $ypos.Remove(1)
  }
  
  foreach($x1 in $xpos){
    if($val -ge $grid[($x + $x1)][$y]){
      return $false
    }
  }
  
  foreach($y1 in $ypos){
    if($val -ge $grid[$x][($y + $y1)]){
      return $false
    }    
  }  
  return $true;
}


foreach($line in $data){
  $grid[$grid.count] = $line.ToCharArray()
}




for($x = 0; $x -lt $grid.Count; $x++){
  for($y = 0; $y -lt $grid[$x].Count; $y++){
    if($grid[$x][$y] -eq '0'){
      $foundRisks += [pscustomobject]@{x = $x; y = $y; value = 0}
    }
  }
}

for($x = 1; $x -le 9; $x++){
  $foundRisks += lookForDanger -grid $grid -value $x
  
}

$sum = 0
foreach($spot in $foundRisks){
  $sum += ($spot.value + 1)
}

Write-Host 'The total risk is ' $sum


Write-Host '------------------------------------------ End Script ------------------------------------------' -ForegroundColor Blue
