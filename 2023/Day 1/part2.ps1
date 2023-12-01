Clear-Host
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day 1\input.txt"
$numbers = @{
  one = "1"
  two = "2"
  three = "3"
  four = "4"
  five = "5"
  six = "6"
  seven = "7"
  eight = "8"
  nine = "9"
}
$sum = 0
foreach($line in $data){
  $values[0] = ([Regex]::Match($line,"(one|two|three|four|five|six|seven|eight|nine|[0-9])")).Value
  $values[1] = ([Regex]::Match($line,"(one|two|three|four|five|six|seven|eight|nine|[0-9])",'RightToLeft')).Value
  $number = $null
  foreach($num in $values){
    if($null -eq $numbers.$num){
      $number = "$($number)$($num)"
    }
    else{
      $number = "$($number)$($numbers.$num)"
    }
  }
  $sum = $sum + [int]$number
}
$sum