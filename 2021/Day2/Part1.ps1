Clear-Host
$data = get-content '.\Data.txt'
$depth = 0;
$pos = 0;
foreach($content in $data){
  switch -WIldCard ($content){
    'forward*'{
      $pos += [int]($content.substring($content.length -1))
    }
    'down*'{
      $depth += [int]($content.substring($content.length -1))
    }
    'up*'{
      $depth -= [int]($content.substring($content.length -1))
    }
  }
}
Write-Host 'Position - ' $pos
Write-Host 'Depth' - $depth