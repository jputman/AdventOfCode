Clear-Host
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day 1\input.txt"
$sum = 0
foreach($line in $data){
  $numbers = $line -replace "[^0-9]" , ''
  if($numbers.length -ge 2){
    $number = [int]"$($numbers[0])$($numbers[$numbers.length-1])"
  }
  else{
    $number = [int]"$($numbers[0])$($numbers[0])"
  }
  $sum = $sum + $number
}
$sum