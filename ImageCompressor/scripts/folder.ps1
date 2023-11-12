if ($args.Count -gt 1) {
    Break
}

$path = $args[0]

if (Test-Path $path/compressed) {
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $path/compressed
}

New-Item $path/compressed -Type Directory

Get-ChildItem -Path $path/* -Include *.jpg,*.png -Recurse | Copy-Item -Destination $path/compressed

.\pngquant.exe $path/compressed/*.png

foreach ($file in Get-ChildItem -Path $path/compressed -File | Where-Object {$_.BaseName -notmatch '-fs8'}) {
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue $path/compressed/$file
    }

get-childitem $path/compressed/*.png | foreach { rename-item $_ $_.Name.Replace('-fs8', '') }
