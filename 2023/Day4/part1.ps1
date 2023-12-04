Clear-Host
#$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day4\testpart1.txt"
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day4\input.txt"


$totalSum = 0
foreach($line in $data){
  $sections = ($line -split ":")[1] -split "\|"
  $cards = [REGEX]::Matches($sections[0],"\d+")
  $winners = [REGEX]::Matches($sections[1],"\d+")
  $cardCount = 0
  $sum = 0
  foreach($card in $cards){
    if($card.value -in $winners.value){
      $cardCount++
    }
  }
  if($cardCount -gt 0){
    $sum = 1
    for($i = 1; $i -lt $cardCount; $i++){
      $sum *= 2 
    }
  }
  $totalSum += $sum
}
$totalSum