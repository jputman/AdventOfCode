Clear-Host
function DisplayStack($stack){
  $count = 0
  do{
    $isEmpty = $true
    $message = $null
    for($i = 0; $i -lt $stack.Count; $i++){
      if($stack[$i][$count]){
        $message += "$mesage $($stack[$i][$count]) "
        $isEmpty = $false
      }
      else{
        $message += "      "
      }
    }
    $message
    $count++
  }while($isEmpty -ne $true)
}


$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 5\input.txt' -Delimiter "`n`r"
$stack = [System.Collections.ArrayList]::new()
$lines = $dataInput[0] -split "`n"
for($i = ($lines.length) - 2; $i -ge 0; $i--){
  if($stack.count -eq 0){
    $line = $lines[$i].TrimStart().TrimEnd() -split "   "
    foreach($num in $line){
      $stack.Add([System.Collections.ArrayList]::new()) | Out-Null
    }
  }
  else{
    for($j = 0; $j -lt $stack.Count; $j++){
      if($lines[$i].Substring(($j*4),4).trim() -ne ''){
        $stack[$j].Add($lines[$i].Substring(($j*4),4)) | Out-Null
      }
    }
  }
}
#DisplayStack $stack
$instructions = $dataInput[1].Trim() -split "`n"
foreach($instruction in $instructions){
  $line = $instruction -split " "
  $count = $line[1]
  $from = $line[3] - 1
  $to = $line[5] - 1
  for($i = 0; $i -lt $count; $i++){
    $item = $stack[$from][-1]
    $stack[$from].RemoveAt($stack[$from].count - 1)
    $stack[$to].Add($item) | Out-Null
  }
  #"move $($count) from $($from) to $($to)"
  #DisplayStack $stack
}
$answer = ""
for($i = 0; $i -lt $stack.Count; $i++){
  $answer += $stack[$i][-1]
}

"Answer: " + ((($answer -replace "\[","") -replace "]","") -replace " ","").trim()