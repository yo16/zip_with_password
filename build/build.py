import re


SOURCE_PS1_FILE = "..\\src\\zip_with_password.ps1"
RELEASE_FILE = "..\\release\\zip_with_password.bat"
PS1_FILE_SJ = ".\\zip_with_password.ps1_sj"
PS1_FILE = ".\\zip_with_password.ps1"
ENCODER_FILE = ".\\encode_sj2utf8.ps1"

def main():
	# ps1ファイルを読む
	lines = []
	with open(SOURCE_PS1_FILE, mode="r", encoding="utf8") as fr:
		lines = fr.readlines()
	
	# 実行用のbatファイルを書く
	with open(RELEASE_FILE, mode="w", encoding="shift-jis") as fw:
		# PS1ファイル生成部分
		fw.write(f"echo,>{PS1_FILE_SJ}\n")
		for l in lines:
			l = l.rstrip()
			
			# 特殊文字の置換
			l = escape_for_batch(l)
			
			fw.write(f"echo,{l}>>{PS1_FILE_SJ}\n")
		fw.write("\n")
		
		# エンコード変換スクリプトを生成
		cmd = f"echo,Get-Content {PS1_FILE_SJ} | Set-Content -Encoding UTF8 {PS1_FILE}"
		fw.write(escape_for_batch(cmd) + f">{ENCODER_FILE}\n")
		fw.write("\n")
		
		# エンコーダーを呼ぶ
		fw.write(f"powershell -NoProfile -ExecutionPolicy Unrestricted  ./{ENCODER_FILE}\n")
		fw.write("\n")
		
		# zip_with_password.ps1を呼ぶ
		fw.write(f"powershell -NoProfile -ExecutionPolicy Unrestricted {PS1_FILE} %*\n")
		
		
	
	return


def escape_for_batch(s1):
	ret = s1.replace("^", "^^")
	ret = ret.replace("|", "^|")
	ret = ret.replace("<", "^<")
	ret = ret.replace(">", "^>")
	ret = ret.replace("&", "^&")
	ret = ret.replace("%", "%%")
	ret = ret.replace("\"", "^\"")
	
	
	return ret


if __name__=="__main__":
	main()
