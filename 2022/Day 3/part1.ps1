Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 3\input.txt' -Delimiter "`n"
$sum = 0
foreach($line in $dataInput){
  $pocket1 = $line.Substring(0,($line.Length/2 -1)).trim().tochararray() | SOrt-object -Unique
  $pocket2 = $line.Substring(($line.Length/2) - 1).trim().tochararray() | SOrt-object -Unique
  $compare = Compare-Object -ReferenceObject  $pocket1 -DifferenceObject $pocket2 -IncludeEqual
  $match = $compare | Where-Object {$_.SideIndicator -eq "=="}
  if($match.InputObject -cmatch "[A-Z]"){
    $sum += [byte][char]($match.InputObject)-38
  }
  else{
    $sum += [byte][char]($match.InputObject)-96
  }
}
$sum