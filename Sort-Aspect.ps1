Param
(
	[string]$path
)

Import-Module PSCoreWindowsCompat
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$dir = get-childitem -path $path\* -include ('*.png', '*.jpg', '*.jpeg', '*.avif', '*.heic', '*.webp')

if ( -not (Test-path '43' 			-PathType Container)) {mkdir '43'}
if ( -not (Test-path '1609' 		-PathType Container)) {mkdir '1609'}
if ( -not (Test-path '1610' 		-PathType Container)) {mkdir '1610'}
if ( -not (Test-path 'portrait' 	-PathType Container)) {mkdir 'portrait'}
if ( -not (Test-path 'square' 		-PathType Container)) {mkdir 'square'}
if ( -not (Test-path 'alien' 		-PathType Container)) {mkdir 'alien'}

foreach ($imageFile in $dir)
{
	
	$image 			= [System.Drawing.Image]::FromFile($imageFile)
	$imageWidth 	= $image.Width
	$imageHeight 	= $image.Height
	$aspectRatio 	= $imageWidth / $imageHeight;
	$image.Dispose()

	switch($aspectRatio)
	{
		{$aspectRatio -gt 1.7  -And $aspectRatio -lt 2.5}	{move $imageFile '1609'}
		{$aspectRatio -ge 1.55 -And $aspectRatio -le 1.7}	{move $imageFile '1610'}
		{$aspectRatio -ge 1.3  -And $aspectRatio -le 1.54}	{move $imageFile './43'}
		{$aspectRatio -ge 1.0  -And $aspectRatio -le 1.25}	{move $imageFile './square'}
		{$aspectRatio -lt 1.0}								{move $imageFile './portrait'}
		default 											{move $imageFile './alien'}
	}

}
