if ($args.Count -gt 1) {
    Break
}

$path = $args[0]
$file = (Get-ChildItem $path).Name
$pathWithoutFile = Split-Path $path

if (-not (Test-Path $pathWithoutFile/compressed)) {
    New-Item $pathWithoutFile/compressed -Type Directory
}

if ((Test-Path -Path $pathWithoutFile/compressed/$file)) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $pathWithoutFile/compressed/$file
} 

Get-ChildItem $pathWithoutFile/$file -Recurse | Copy-Item -Destination $pathWithoutFile/compressed

.\pngquant.exe $pathWithoutFile/compressed/$file

Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $pathWithoutFile/compressed/$file

get-childitem $pathWithoutFile/compressed/*.png | foreach { rename-item $_ $_.Name.Replace('-fs8', '') }

