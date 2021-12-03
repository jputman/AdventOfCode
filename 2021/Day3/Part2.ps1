Clear-Host
$data = Get-Content '.\Data.txt'
[System.Collections.ArrayList]$o2 = $data
[System.Collections.ArrayList]$co2 = $data


function getBitCount($array, $position){
  $bits = @(0,0)
  foreach($item in $array){
    $bits[[int]$item[$position] - 48]++
  }
  return $bits
}

function removeItems($array, $items){
  foreach($item in $items){
    $array.Remove($item)
  }
  return $array
}


for($pos = 0; $pos -lt $data[0].length; $pos++){
  $getBits = getBitCount $o2 $pos
  if($o2.Count -gt 1){
    if($getBits[1] -ge $getBits[0]){
      $match = 1
    }
    else{
      $match = 0
    }
    [System.Collections.ArrayList]$items = @()
    foreach($obj in $o2){
      $check = [int]$obj[$pos] - 48
      if($check -ne $match){
        $items +=$obj
      }
    }
    if($o2.Count -gt 2){
      $o2 = removeItems $o2 $items
    }
    else{
      removeItems $o2 $items | Out-Null
    }
  }
}


for($pos = 0; $pos -lt $data[0].length; $pos++){
  $getBits = getBitCount $co2 $pos
  if($co2.Count -gt 1){
    if($getBits[0] -le $getBits[1]){
      $match = 0
    }
    else{
      $match = 1
    }
    [System.Collections.ArrayList]$items = @()
    foreach($obj in $co2){
      $check = [int]$obj[$pos] - 48
      if($check -ne $match){
        $items +=$obj
      }
    }
    if($co2.Count -gt 2){
      $co2 = removeItems $co2 $items
    }
    else{
      removeItems $co2 $items | Out-Null
    }
  }
}




$o2total = [convert]::ToInt32($o2,2)
$co2total = [convert]::ToInt32($co2,2)
Write-Host 'o2total: ' $o2total
Write-Host 'co2total: ' $co2total 
Write-Host 'Answer: ' ($o2total * $co2total )