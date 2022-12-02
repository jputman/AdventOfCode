Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 2\input.txt'
$map = @{
  "A" = @{
    "beats" = "C"
    "lose" = "B"
    "points" = 1
  }
  "B" = @{
    "beats" = "A"
    "lose" = "C"
    "points" = 2
  }
  "C" = @{
    "beats" = "B"
    "lose" = "A"
    "points" = 3
  }    
}
$score = 0
foreach($input in $dataInput){
  $game = $input -split " "
  $elf = $map.($game[0])
  if($game[1] -eq "X"){$score += $map.($elf.beats).points}
  elseif($game[1] -eq "Y"){$score += 3 + $elf.points}
  else{$score += 6 + $map.($elf.lose).points}
}
$score


