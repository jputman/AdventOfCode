Clear-Host
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day3\testpart1.txt"
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day3\input.txt"

function lookup{
  param(
    $indexOf,
    $checkLine
  )
  $sum = 0
  foreach($item in $checkLine){
    $covers = @($item.index..$($item.index + $item.length - 1))
    if($indexOf -in $covers -or ($indexOf - 1) -in $covers -or ($indexOf + 1) -in $covers){
      $sum = $sum + $item.Value
    }
  }
  return $sum
}

$totalCount = 0
for($i = 0; $i -le $data.Length; $i++){
  if($i -eq 0){$previousLine = $null}
  else{$previousLine = [regex]::Matches($data[$i - 1],"\d{0,2}[^\.]")}
  if($i -eq $data.Length){$nextLine = $null}
  else{$nextLine = [regex]::Matches($data[$i + 1],"\d{0,2}[^\.]")}
  $line = [regex]::Matches($data[$i],"\d{0,2}[^\.]")
  $symbols = $line | Where-Object {$_.Value -notmatch "[0-9]"}
  $prev = $previousLine | Where-Object {$_.Value -match "[0-9]"}
  $cur = $line | Where-Object {$_.Value -match "[0-9]"}
  $next = $nextLine | Where-Object {$_.Value -match "[0-9]"}
  foreach($symbol in $symbols){
    $totalCount = $totalCount + (lookup -indexOf $symbol.Index -checkLine $prev)
    $totalCount = $totalCount + (lookup -indexOf $symbol.Index -checkLine $cur)
    $totalCount = $totalCount + (lookup -indexOf $symbol.Index -checkLine $next)
  }
}
$totalCount