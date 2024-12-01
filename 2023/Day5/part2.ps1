Clear-Host
#$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day5\testpart1.txt"
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day5\input.txt"

$seeds = [regex]::Matches($data[0],"\d+")


$map = [System.Collections.Generic.List[object]]::new()
for($i = 1; $i -lt $data.count; $i++){
  $digits = [regex]::Matches($data[$i],"\d+")
  if($digits.success -eq $true){
    $obj = [PSCustomObject]@{
      "source_start" = [double]$digits.Value[1]
      "source_end" = [double]$digits.Value[1]+[double]$digits.Value[2]
      "destination" = [double]$digits.Value[0]
      "range" = [double]$digits.Value[2]
    }
    $map.Add($obj) | Out-Null
  }
}


for($i = 0; $i -lt $seeds.Count; $i += 2){
  $seedStart = [double]$seeds[$i + 1].Value
  $seedEnd = [double]$seeds[$i + 1].Value + [double]$seeds[$i + 2].Value
  for($x = $seedStart; $y -le $seedEnd; $y++){
    $y
  }
  break
}

<#

Clear-Host
#$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day5\testpart1.txt"
$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day5\input.txt"

$seeds = [regex]::Matches($data[0],"\d+")

$sts = $data.indexOf("seed-to-soil map:")
$stf = $data.indexOf("soil-to-fertilizer map:")
$ftw = $data.indexOf("fertilizer-to-water map:")
$wtl = $data.indexOf("water-to-light map:")
$ltt = $data.indexOf("light-to-temperature map:")
$tth = $data.indexOf("temperature-to-humidity map:")
$htl = $data.indexOf("humidity-to-location map:")

$stsmap = New-Object System.Collections.ArrayList
$stfmap = New-Object System.Collections.ArrayList
$ftwmap = New-Object System.Collections.ArrayList
$wtlmap = New-Object System.Collections.ArrayList
$lttmap = New-Object System.Collections.ArrayList
$tthmap = New-Object System.Collections.ArrayList
$htlmap = New-Object System.Collections.ArrayList

function MakeMap{
  param(
    $digits
  )
  $data = @{
    'source_start' = [double]$digits[1]
    'source_end' = [double]$digits[1]+[double]$digits[2]-1
    'destination' = [double]$digits[0]
  }
  return $data
}

function CheckMatch{
  param(
    $map,
    $value
  )
  for($i = 0; $i -lt $map.count; $i++){
    if([double]$value -ge [double]$map[$i].source_start -and [double]$value -le [double]$map[$i].source_end){
      $v = $value - $map[$i].source_start
      return [double]($map[$i].destination + $v)
    }
  }
  return [double]$value
}


foreach($item in $data[$($sts+1)..$($stf-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $stsmap.add($(MakeMap -digits $digits)) | Out-Null
}

foreach($item in $data[$($stf+1)..$($ftw-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $stfmap.add($(MakeMap -digits $digits)) | Out-Null
}


foreach($item in $data[$($ftw+1)..$($wtl-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $ftwmap.add($(MakeMap -digits $digits)) | Out-Null
}


foreach($item in $data[$($wtl+1)..$($ltt-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $wtlmap.add($(MakeMap -digits $digits)) | Out-Null
}


foreach($item in $data[$($ltt+1)..$($tth-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $lttmap.add($(MakeMap -digits $digits)) | Out-Null
}


foreach($item in $data[$($tth+1)..$($htl-2)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $tthmap.add($(MakeMap -digits $digits)) | Out-Null
}


foreach($item in $data[$($htl+1)..$($data.count-1)]){
  $digits = ([regex]::Matches($item,"\d+")).Value
  $htlmap.add($(MakeMap -digits $digits)) | Out-Null
}


$locations = New-Object System.Collections.ArrayList
foreach($seed in $seeds.Value){
  $soil = CheckMatch $stsmap $seed
  $fert = CheckMatch $stfmap $soil
  $wate = CheckMatch $ftwmap $fert
  $lite = CheckMatch $wtlmap $wate
  $temp = CheckMatch $lttmap $lite
  $temp = CheckMatch $lttmap $lite
  $humi = CheckMatch $tthmap $temp
  $loca = CheckMatch $htlmap $humi  
  $locations.Add($loca) | Out-Null
  "Seed: $($seed), soil: $($soil), fertilizer $($fert), water $($wate), light $($lite), temperature $($temp), humidity $($humi), location $($loca)"
}
$locations | Measure-Object -Minimum
#$stsmap
#>