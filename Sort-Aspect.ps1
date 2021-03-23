Param
(
	[string]$path
)

Import-Module PSCoreWindowsCompat
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
if (!$path){$path = Get-Location}
$dir = get-childitem -path $path\* -include ('*.png', '*.jpg', '*.jpeg', '*.avif', '*.heic', '*.webp')

if ( -not (Test-path '0403'			-PathType Container)) {mkdir '0403'}
if ( -not (Test-path '0504'			-PathType Container)) {mkdir '0504'}
if ( -not (Test-path '1043'			-PathType Container)) {mkdir '1043'}
if ( -not (Test-path '1409'			-PathType Container)) {mkdir '1409'}
if ( -not (Test-path '1609'			-PathType Container)) {mkdir '1609'}
if ( -not (Test-path '1610'			-PathType Container)) {mkdir '1610'}
if ( -not (Test-path 'portrait'		-PathType Container)) {mkdir 'portrait'}
if ( -not (Test-path 'square'		-PathType Container)) {mkdir 'square'}
if ( -not (Test-path 'univisium'	-PathType Container)) {mkdir 'univisium'}
if ( -not (Test-path 'widescreen'	-PathType Container)) {mkdir 'widescreen'}
if ( -not (Test-path 'anamorphic'	-PathType Container)) {mkdir 'anamorphic'}
if ( -not (Test-path 'alien'		-PathType Container)) {mkdir 'alien'}

foreach ($imageFile in $dir)
{
	
	$image			= [System.Drawing.Image]::FromFile($imageFile)
	$imageWidth		= $image.Width
	$imageHeight	= $image.Height
	$aspectRatio	= $imageWidth / $imageHeight;
	$image.Dispose()

	switch($aspectRatio)
	{
		{$aspectRatio -ge 1.0  -And $aspectRatio -lt 1.1}	{move $imageFile 'square'}
		{$aspectRatio -ge 1.9  -And $aspectRatio -lt 1.3}	{move $imageFile '0504'}
		{$aspectRatio -ge 1.3  -And $aspectRatio -lt 1.4}	{move $imageFile '0403'}
		{$aspectRatio -ge 1.4  -And $aspectRatio -lt 1.5}	{move $imageFile '1043'}
		{$aspectRatio -ge 1.5  -And $aspectRatio -lt 1.6}	{move $imageFile '1409'}
		{$aspectRatio -ge 1.6  -And $aspectRatio -lt 1.7}	{move $imageFile '1610'}
		{$aspectRatio -ge 1.7  -And $aspectRatio -lt 1.8}	{move $imageFile '1609'}
		{$aspectRatio -ge 1.8  -And $aspectRatio -lt 1.85} 	{move $imageFile 'widescreen'}
		{$aspectRatio -eq 2.3  -And $aspectRatio -le 2.4} 	{move $imageFile 'anamorphic'}
		{$aspectRatio -eq 2	-And $aspectRatio -lt 2.2} 	{move $imageFile 'univisium'}
		{$aspectRatio -lt 1.0}								{move $imageFile 'portrait'}
		default												{move $imageFile 'alien'}
	}

}
