Clear-Host
Write-Host '----------------------------------------- Start Script -----------------------------------------' -ForegroundColor Blue
$data = Get-Content '.\Data.txt'
$illegalChars = @()
$brackets = @()
$brackets += [pscustomobject]@{open = '('; closed = ')'}
$brackets += [pscustomobject]@{open = '['; closed = ']'}
$brackets += [pscustomobject]@{open = '{'; closed = '}'}
$brackets += [pscustomobject]@{open = '<'; closed = '>'}
$charValues = @{
  ')' = 3
  ']' = 57
  '}' = 1197
  '>' = 25137
}
#$lines += [pscustomobject]@{x1 = $x1; x2 = $x2; y1 = $y1; y2 = $y2; Points = $pointsForLine}


$line = '{([(<{}[<>[]}>{[]{[(<()>'


foreach($line in $data){
  [System.Collections.ArrayList]$openBrackets = @()
  for($x = 0; $x -lt $line.Length; $x++){
    $isOpen = $brackets | where-object {$_.open -eq $line[$x]}
    #Write-Host 'Current Brackets' $openBrackets 
    if($isOpen){
      $openBrackets += $line[$x]
    }
    else{
      $match = ($brackets | where-object {$_.open -eq $openBrackets.Item($openBrackets.count - 1)}).Closed
      #Write-Host 'Closed Bracket' $line[$x] ' but looking for ' $match
      if($line[$x] -ne $match){
        #Write-Host 'Illegal Line'
        $illegalChars += $line[$x]
        break
      }
      $openBrackets.removeAt($openBrackets.count - 1)
    }
  }
}

$sum = 0
$objects = $illegalChars | Group-Object
foreach($obj in $objects){
  $sum +=$obj.Count *  $charValues[$obj.Name]
}

Write-Host 'The total of illegal chars is ' $sum

Write-Host '------------------------------------------ End Script ------------------------------------------' -ForegroundColor Blue