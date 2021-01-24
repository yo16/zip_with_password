# zip_with_password
ランダムな文字列でパスワード付き圧縮
-----
# 使い方
1. zip_with_password.batへ、圧縮したいファイル/フォルダをドロップする。
2. zipファイルができあがる。
3. ついでに、拡張子なしのパスワードファイルがそっとできている。

# 前提（準備）
- bashにzipとexpectをインストールしておくこと
  1. PowerShellを起動
  2. bash
  3. sudo apt install zip
  3. sudo apt-get install expect

# しくみ
- Windows標準のzip圧縮/解凍は、PowerShellでないとできない。
- なのでbatからPowerShellのソースを作り出して、PowerShellを実行し、PowerShellソースを消す。

# フォルダ構成
- ./src
  - PowerShellソースとして開発するところ。
  - テスト実行するときには、「テスト実行.bat」を実行する。
- ./build
  - srcにあるPowerShellを作り出すbatファイルを作るソース。
  - ここはPythonでやる。
  - 結果はreleaseへ作成する。
- ./release
  - batのみ。
  - PowerShellソースを作り出す仕組み込み。

