# zip_with_password
# (c) 2021 yo16

# 今日の日付
$today = Get-Date -UFormat "%Y%m%d"

# １個目のファイルのベースファイル名
$base_file_name = (Get-ChildItem $args[0]).BaseName

# zipファイル名
$zip_file_name = "{0}_{1}.zip" -f $today, $base_file_name
# Write-Output($zip_file_name)


# password生成
Add-type -AssemblyName System.Web
$pw = [System.Web.Security.Membership]::GeneratePassword(10,2)
Write-Output($pw) `
| % { [Text.Encoding]::UTF8.GetBytes($_) } `
| Set-Content -Path ".\password" -Encoding Byte


# shファイル生成
Write-Output("
expect -c ""
spawn zip -e "+$zip_file_name+" "+$args+"
expect \""Enter password:\""
send \"""+$pw+"\n\""
expect \""Verify password:\""
send \"""+$pw+"\n\""
expect \""$\""
exit 0
""") `
| Out-String `
| % { [Text.Encoding]::UTF8.GetBytes($_) } `
| Set-Content -Path ".\zip_with_password.sh" -Encoding Byte


# zip圧縮
bash zip_with_password.sh

