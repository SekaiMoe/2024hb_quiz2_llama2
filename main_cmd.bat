@echo off
setlocal enabledelayedexpansion

:cleanup
echo 清理中...
del out.txt
exit /b 1

:main
echo 复赛测试系统
echo 这是来自chi的测试系统
echo 使用你的聪明才智，骗过AI吧
echo 在这里输入你的小作文:
set /p input=

run.o stories15M.bin -i "!input!" > out.txt

set score=0
set points_awesome=20
set points_great=30
set points_good=30
set points_nekovanilla=5
set points_chihuo2104=10

for %%k in (awesome great good nekovanilla chihuo2104) do (
    findstr /i %%k out.txt >nul
    if not errorlevel 1 (
        set /a score+=!points_%%k!
    )
)

echo.
echo 您的分数为: !score!
echo 输入文本为: !input!
echo 返回文本为:
type out.txt
echo.
del out.txt

endlocal
