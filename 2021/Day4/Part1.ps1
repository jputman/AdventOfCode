Clear-Host
$data = Get-Content '.\Data.txt'
$numbers = $data[0].split(',')
$boards =  [System.Collections.ArrayList]@()

function makeBoards($startLine){
  $board = (0..4),(0..4),(0..4),(0..4),(0..4)
  for($x = 0; $x -lt 5; $x++){
    $lineNumber = $startLine + $x
    $lineData = $data[$lineNumber].Replace('  ',' ').Trim().Split(' ')
    for($y = 0; $y -lt 5; $y++){
      $board[$x][$y] = @($lineData[$y], 0)
    }
  }
  return $board
}

function markNumber($boards, $number){
  foreach($board in $boards){
    for($x = 0; $x -lt 5; $x++){
      for($y = 0; $y -lt 5; $y++){
        if($board[$x][$y][0] -eq $number){
          $board[$x][$y][1] = 1
        }
      }
    }
  }
}

function checkWinner($boards){
  for($boardNumber = 0; $boardNumber -lt $boards.Count; $boardNumber++){
    $xwin = 0
    for($x = 0; $x -lt 5; $x++){
      $hwin = 0
      $xwin += $boards[$boardNumber][$x][0][1]
      for($y = 0; $y -lt 5; $y++){
        $hwin += $boards[$boardNumber][$x][$y][1]
      }
      if($hwin -eq 5 -or $xwin -eq 5){
        return $boardNumber
      }
    }
  }
}

function calculateSum($board){
  $sum = 0
  for($x = 0; $x -lt 5; $x++){
    for($y = 0; $y -lt 5; $y++){
      if($board[$x][$y][1] -eq 0){
        $sum += $board[$x][$y][0]
      }
    }
  }
  return $sum
}

for($line = 2; $line -lt ($data.Count - 4); $line+=6){
  $result = makeBoards -startLine $line
  $boards.Add($result) | Out-Null
}

foreach($number in $numbers){
  markNumber -boards $boards -number $number
  $winner = checkWinner -boards $boards
  if($winner){
    $sum = calculateSum -board $boards[$winner]
    Write-Host 'The sum of the uncalled numbers for winning board is ' $sum
    Write-Host 'The sum * the called number is equal to ' ($sum * $number)
    break
  }
}