Clear-Host
$data = Get-Content '.\Data.txt'
$pos = 0;
$depth = 0;
$aim = 0;
foreach($content in $data){
  switch -WIldCard ($content){
    'forward*'{
      $movement = [int]($content.substring($content.length -1))
      $pos += $movement
      $depth += $movement * $aim
    }
    'down*'{
      $aim += [int]($content.substring($content.length -1))
    }
    'up*'{
      $aim -= [int]($content.substring($content.length -1))
    }
  }
}
Write-Host 'Position - ' $pos
Write-Host 'Depth' - $depth
Write-Host 'Aim' - $aim