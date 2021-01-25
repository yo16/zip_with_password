@echo off

rem Anacondaとかpython環境を整える
if exist make_python_environment.bat ( call make_python_environment.bat )

rem 実行
python build.py

pause
