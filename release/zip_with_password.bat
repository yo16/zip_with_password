echo,>.\zip_with_password.ps1_sj
echo,# zip_with_password>>.\zip_with_password.ps1_sj
echo,# (c) 2021 yo16>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# �����̓��t>>.\zip_with_password.ps1_sj
echo,$today = Get-Date -UFormat ^"%%Y%%m%%d^">>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# �P�ڂ̃t�@�C���̃x�[�X�t�@�C����>>.\zip_with_password.ps1_sj
echo,$base_file_name = (Get-ChildItem $args[0]).BaseName>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# zip�t�@�C����>>.\zip_with_password.ps1_sj
echo,$zip_file_name = ^"{0}_{1}.zip^" -f $today, $base_file_name>>.\zip_with_password.ps1_sj
echo,# Write-Output($zip_file_name)>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# password����>>.\zip_with_password.ps1_sj
echo,Add-type -AssemblyName System.Web>>.\zip_with_password.ps1_sj
echo,$pw = [System.Web.Security.Membership]::GeneratePassword(10,2)>>.\zip_with_password.ps1_sj
echo,Write-Output($pw) `>>.\zip_with_password.ps1_sj
echo,^| %% { [Text.Encoding]::UTF8.GetBytes($_) } `>>.\zip_with_password.ps1_sj
echo,^| Set-Content -Path ^".\password^" -Encoding Byte>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# sh�t�@�C������>>.\zip_with_password.ps1_sj
echo,Write-Output(^">>.\zip_with_password.ps1_sj
echo,expect -c ^"^">>.\zip_with_password.ps1_sj
echo,spawn zip -e ^"+$zip_file_name+^" ^"+$args+^">>.\zip_with_password.ps1_sj
echo,expect \^"^"Enter password:\^"^">>.\zip_with_password.ps1_sj
echo,send \^"^"^"+$pw+^"\n\^"^">>.\zip_with_password.ps1_sj
echo,expect \^"^"Verify password:\^"^">>.\zip_with_password.ps1_sj
echo,send \^"^"^"+$pw+^"\n\^"^">>.\zip_with_password.ps1_sj
echo,expect \^"^"$\^"^">>.\zip_with_password.ps1_sj
echo,exit 0>>.\zip_with_password.ps1_sj
echo,^"^"^") `>>.\zip_with_password.ps1_sj
echo,^| Out-String `>>.\zip_with_password.ps1_sj
echo,^| %% { [Text.Encoding]::UTF8.GetBytes($_) } `>>.\zip_with_password.ps1_sj
echo,^| Set-Content -Path ^".\zip_with_password.sh^" -Encoding Byte>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj
echo,# zip���k>>.\zip_with_password.ps1_sj
echo,bash zip_with_password.sh>>.\zip_with_password.ps1_sj
echo,>>.\zip_with_password.ps1_sj

echo,Get-Content .\zip_with_password.ps1_sj ^| Set-Content -Encoding UTF8 .\zip_with_password.ps1>.\encode_sj2utf8.ps1

powershell -NoProfile -ExecutionPolicy Unrestricted  ./.\encode_sj2utf8.ps1

powershell -NoProfile -ExecutionPolicy Unrestricted .\zip_with_password.ps1 %*

pause
