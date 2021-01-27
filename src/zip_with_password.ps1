# zip_with_password
# (c) 2021 yo16


# フルパスをスラッシュ区切りへ置換
$bash_paths = @()
foreach($arg1 in $args){
	$tmp = $arg1
	$tmp = $tmp -replace "^([A-Za-z]):\\", "/mnt/`$1/"
	$tmp = $tmp -replace "\\", "/"
	$bash_paths += $tmp
}


# １個目のファイルのベースファイル名
$base_file_name = (Get-ChildItem $args[0]).BaseName
# １個目のファイルのフォルダパス
$base_dir_path = (Get-ChildItem $args[0]).DirectoryName
# １個目のファイルのフォルダパス（bash版）
$base_dir_path_bash = [regex]::Replace($base_dir_path, "^([A-Za-z]):\\", {"/mnt/"+$args.groups[1].value.tolower()+"/"})
$base_dir_path_bash = $base_dir_path_bash -replace "\\", "/"


# bash_pathsから、base_dir_path_bashを除く
$bash_files = @()
$remove_str = $base_dir_path_bash+"/"
foreach($bash_path in $bash_paths){
	$bash_files += $bash_path -ireplace $remove_str, ""
}


# 今日の日付
$today = Get-Date -UFormat "%Y%m%d"


# zipファイル名
$zip_file_base = "{0}_{1}" -f $today, $base_file_name
$zip_file_name = "{0}.zip" -f $zip_file_base
# Write-Output($zip_file_name)


# password生成
$password_file_name = ".\{0}.password" -f $zip_file_base
Add-type -AssemblyName System.Web
$pw = [System.Web.Security.Membership]::GeneratePassword(10,2)
Write-Output($pw) `
| % { [Text.Encoding]::UTF8.GetBytes($_) } `
| Set-Content -Path $password_file_name -Encoding Byte


# shファイル生成
Write-Output("
cd "+$base_dir_path_bash+"
expect -c ""
spawn zip -e "+$zip_file_name+" "+$bash_files+"
expect \""Enter password:\""
send \"""+$pw+"\n\""
expect \""Verify password:\""
send \"""+$pw+"\n\""
expect \""$\""
""") `
| Out-String `
| % { [regex]::Replace($_, "\r", "") } `
| % { [Text.Encoding]::UTF8.GetBytes($_) } `
| Set-Content -Path ".\zip_with_password.sh" -Encoding Byte


# zip圧縮
bash zip_with_password.sh

