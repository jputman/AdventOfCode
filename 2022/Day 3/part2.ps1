Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 3\input.txt' -Delimiter "`n"
$sum = 0
for($i = 0; $i -lt $dataInput.Length; $i+=3){
  $elf1 = $dataInput[$i].trim().tochararray() | SOrt-object -Unique
  $elf2 = $dataInput[$i+1].trim().tochararray() | SOrt-object -Unique
  $elf3 = $dataInput[$i+2].trim().tochararray() | SOrt-object -Unique
  $first = Compare-Object -ReferenceObject  $elf1 -DifferenceObject $elf2 -IncludeEqual | Where-Object {$_.SideIndicator -eq "=="}
  $second = Compare-Object -ReferenceObject  $first.InputObject -DifferenceObject $elf3 -IncludeEqual | Where-Object {$_.SideIndicator -eq "=="}
  if($second.InputObject -cmatch "[A-Z]"){
    $sum += [byte][char]($second.InputObject)-38
  }
  else{
    $sum += [byte][char]($second.InputObject)-96
  }  
}
$sum