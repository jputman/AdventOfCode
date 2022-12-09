$StartMS = (Get-Date)
Clear-Host
function DrawGrid($x,$y,$hx, $hy, $tx, $ty){
  for($r = ($y - 1); $r -ge 0; $r--){
    $line = ""
    for($c = 0; $c -lt $x; $c++){
      $display = " . "
      if($r -eq $hy -and $c -eq $hx){
        $display = " H "
      }
      elseif($r -eq $ty -and $c -eq $tx){
        $display = " T "
      }
      $line += $display
    }
    $line
  }
}
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 9\input.txt'
$head = @(0,0)
$tail = @(0,0)
$tailHistory = @{0 = {0}}
$tailHistory = [System.Collections.ArrayList]::new()
$tailHistory.Add(@(0,0)) | Out-Null
# First Grid Example
#DrawGrid 10 10 $head[0] $head[1] $tail[0] $tail[1]
#Write-Host "--------- Code Starts Here ----------" -ForegroundColor Blue
foreach($line in $dataInput){
  $commands = $line.split(" ")
  $xm = 0
  $ym = 0
  if($commands[0] -eq "R"){$xm = 1}
  if($commands[0] -eq "L"){$xm = -1}
  if($commands[0] -eq "U"){$ym = 1}
  if($commands[0] -eq "D"){$ym = -1}
  for($i = 0; $i -lt $commands[1]; $i++){
    $head[0] += $xm
    $head[1] += $ym
    $tailXDistance = [Math]::Abs($head[0] - $tail[0])
    $tailYDistance = [Math]::Abs($head[1] - $tail[1])
    if($tailXDistance -gt 1 -and $tailYDistance -eq 0){
      $tail[0] += $xm
    }
    elseif($tailXDistance -gt 1 -and $tailYDistance -ne 0){
      $tail[0] += $xm
      $tail[1] = $head[1]
    }
    elseif($tailYDistance -gt 1 -and $tailXDistance -eq 0){
      $tail[1] += $ym
    }
    elseif($tailYDistance -gt 1 -and $tailXDistance -ne 0){
      $tail[1] += $ym
      $tail[0] = $head[0]
    }    
    $tailHistory.Add(@($tail[0],$tail[1])) | Out-Null
#    Write-Host "Draw New Grid - $($line)" -ForegroundColor Yellow
#    DrawGrid 10 10 $head[0] $head[1] $tail[0] $tail[1]
  }
}
"Total Spaces Tail Moved Through: " + ($tailHistory | Sort-Object -Unique | Measure-Object).Count
$EndMS = (Get-Date)
$EndMS - $StartMS