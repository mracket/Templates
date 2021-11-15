param (
    [string]$Path
)

New-PSDrive -Name "N" -PSProvider "FileSystem" -Root "$Path" -verbose


