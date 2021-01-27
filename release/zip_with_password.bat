@echo off

echo,>.\zip_with_password.ps1_sj
echo,# zip_with_password>>.\zip_with_password.ps1_sj
echo,# (c) 2021 yo16>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# フルパスをスラッシュ区切りへ置換>>.\zip_with_password.ps1_sj
echo,$bash_paths = @()>>.\zip_with_password.ps1_sj
echo,foreach($arg1 in $args){>>.\zip_with_password.ps1_sj
echo,	$tmp = $arg1>>.\zip_with_password.ps1_sj
echo,	$tmp = $tmp -replace ^"^^([A-Za-z]):\\^", ^"/mnt/`$1/^">>.\zip_with_password.ps1_sj
echo,	$tmp = $tmp -replace ^"\\^", ^"/^">>.\zip_with_password.ps1_sj
echo,	$bash_paths += $tmp>>.\zip_with_password.ps1_sj
echo,}>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# １個目のファイルのベースファイル名>>.\zip_with_password.ps1_sj
echo,$base_file_name = (Get-ChildItem $args[0]).BaseName>>.\zip_with_password.ps1_sj
echo,# １個目のファイルのフォルダパス>>.\zip_with_password.ps1_sj
echo,$base_dir_path = (Get-ChildItem $args[0]).DirectoryName>>.\zip_with_password.ps1_sj
echo,# １個目のファイルのフォルダパス（bash版）>>.\zip_with_password.ps1_sj
echo,$base_dir_path_bash = [regex]::Replace($base_dir_path, ^"^^([A-Za-z]):\\^", {^"/mnt/^"+$args.groups[1].value.tolower()+^"/^"})>>.\zip_with_password.ps1_sj
echo,$base_dir_path_bash = $base_dir_path_bash -replace ^"\\^", ^"/^">>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# bash_pathsから、base_dir_path_bashを除く>>.\zip_with_password.ps1_sj
echo,$bash_files = @()>>.\zip_with_password.ps1_sj
echo,$remove_str = $base_dir_path_bash+^"/^">>.\zip_with_password.ps1_sj
echo,foreach($bash_path in $bash_paths){>>.\zip_with_password.ps1_sj
echo,	$bash_files += $bash_path -ireplace $remove_str, ^"^">>.\zip_with_password.ps1_sj
echo,}>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# 今日の日付>>.\zip_with_password.ps1_sj
echo,$today = Get-Date -UFormat ^"%%Y%%m%%d^">>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# zipファイル名>>.\zip_with_password.ps1_sj
echo,$zip_file_base = ^"{0}_{1}^" -f $today, $base_file_name>>.\zip_with_password.ps1_sj
echo,$zip_file_name = ^"{0}.zip^" -f $zip_file_base>>.\zip_with_password.ps1_sj
echo,# Write-Output($zip_file_name)>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# password生成>>.\zip_with_password.ps1_sj
echo,$password_file_name = ^".\{0}.password^" -f $zip_file_base>>.\zip_with_password.ps1_sj
echo,Add-type -AssemblyName System.Web>>.\zip_with_password.ps1_sj
echo,$pw = [System.Web.Security.Membership]::GeneratePassword(10,2)>>.\zip_with_password.ps1_sj
echo,Write-Output($pw) `>>.\zip_with_password.ps1_sj
echo,^| %% { [Text.Encoding]::UTF8.GetBytes($_) } `>>.\zip_with_password.ps1_sj
echo,^| Set-Content -Path $password_file_name -Encoding Byte>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# shファイル生成>>.\zip_with_password.ps1_sj
echo,Write-Output(^">>.\zip_with_password.ps1_sj
echo,cd ^"+$base_dir_path_bash+^">>.\zip_with_password.ps1_sj
echo,expect -c ^"^">>.\zip_with_password.ps1_sj
echo,spawn zip -e ^"+$zip_file_name+^" ^"+$bash_files+^">>.\zip_with_password.ps1_sj
echo,expect \^"^"Enter password:\^"^">>.\zip_with_password.ps1_sj
echo,send \^"^"^"+$pw+^"\n\^"^">>.\zip_with_password.ps1_sj
echo,expect \^"^"Verify password:\^"^">>.\zip_with_password.ps1_sj
echo,send \^"^"^"+$pw+^"\n\^"^">>.\zip_with_password.ps1_sj
echo,expect \^"^"$\^"^">>.\zip_with_password.ps1_sj
echo,^"^"^") `>>.\zip_with_password.ps1_sj
echo,^| Out-String `>>.\zip_with_password.ps1_sj
echo,^| %% { [regex]::Replace($_, ^"\r^", ^"^") } `>>.\zip_with_password.ps1_sj
echo,^| %% { [Text.Encoding]::UTF8.GetBytes($_) } `>>.\zip_with_password.ps1_sj
echo,^| Set-Content -Path ^".\zip_with_password.sh^" -Encoding Byte>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# zip圧縮>>.\zip_with_password.ps1_sj
echo,bash zip_with_password.sh>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj

echo,Get-Content .\zip_with_password.ps1_sj ^| Set-Content -Encoding UTF8 .\zip_with_password.ps1>.\encode_sj2utf8.ps1

powershell -NoProfile -ExecutionPolicy Unrestricted  ./.\encode_sj2utf8.ps1

powershell -NoProfile -ExecutionPolicy Unrestricted .\zip_with_password.ps1 %*

del /Q encode_sj2utf8.ps1
del /Q zip_with_password.ps1
del /Q zip_with_password.ps1_sj
del /Q zip_with_password.sh

