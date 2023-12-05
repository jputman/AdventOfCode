Clear-Host
#$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day4\testpart1.txt"
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day4\input.txt"


function Get-Matches{
  param(
    $cards,
    $winners
  )
  $count = 0
  foreach($card in $cards){
    if($card.value -in $winners.value){
      $count++
    }
  }
  return $count
}

$cardCount = @{}
for($i = 1; $i -le $data.Count; $i++){
  if(!$cardCount.ContainsKey($i)){$cardCount.$i = 1}
  else{$cardCount.$i += 1}  
  $sections = ($data[$i - 1] -split ":")[1] -split "\|"
  $cards = [REGEX]::Matches($sections[0],"\d+")
  $winners = [REGEX]::Matches($sections[1],"\d+") 
  #"Card $($i): $($cardCount.$i)"
  $win = Get-Matches -cards $cards -winners $winners
  for($x = 1; $x -le $win; $x++){
    $card = $i + $x
    if($card -gt $data.count){break}
    if(!$cardCount.ContainsKey($card)){$cardCount.$card = $cardCount.$i}
    else{$cardCount.$card += $cardCount.$i}
  }
}
$cardCount.Values | Measure-Object -Sum
<#
$cardCount = @{}
for($i = 1; $i -le $data.Count; $i++){
  if(!$cardCount.ContainsKey($i)){
    $cardCount.$i = 1
  }
  else{
    $cardCount.$i += 1
  }
  $sections = ($data[$i - 1] -split ":")[1] -split "\|"
  $cards = [REGEX]::Matches($sections[0],"\d+")
  $winners = [REGEX]::Matches($sections[1],"\d+")  
  "Card $($i): $($cardCount.$i)"
  for($x = 0; $x -lt $cardCount.$i; $x++){
    $win = Get-Matches -cards $cards -winners $winners
    for($y = $i + 1; $y -lt ($i + $win + 1); $y++){
      if($y -gt $data.count){break}
      if(!$cardCount.ContainsKey($y)){
        $cardCount.$y = 1
      }
      else{
        $cardCount.$y += 1
      }
    }
  }
  
}
$cardCount.Values | Measure-Object -Sum
#>