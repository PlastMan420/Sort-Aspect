# Sort-Aspect
A simple PowerShell script that sorts images (wallpaper) by their aspect ratio (or by what their aspect ratio would fit on). 
It might not be the best, but it does its thing.

It works by creating a couple of folder in the directory where it runs.
And then sorts photos with the following extensions based on their aspect ratio: `png`, `jpg/jpeg`, `avif`, `heic` and `webp`.

### Syntax
Run it like this:
`Sort-Aspect [directory]`

example: `Sort-Aspect C:\library`
