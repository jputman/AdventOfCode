Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 2\input.txt'
$map = @{
  "X" = @{
    "beats" = "C"
    "ties"  = "A"
    "points" = 1
  }
  "Y" = @{
    "beats" = "A"
    "ties" = "B"
    "points" = 2
  }
  "Z" = @{
    "beats" = "B"
    "ties" = "C"
    "points" = 3
  }    
}
$score = 0
foreach($input in $dataInput){
  $game = $input -split " "
  $me = $map.($game[1])
  if($game[0] -eq $me.beats){$score += 6}
  elseif($game[0] -eq $me.ties){$score += 3}
  $score += $me.points
}
$score
