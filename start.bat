@echo off
color 07
echo	********** node环境检测 **********
node --version
if %errorlevel% == 0 ( 
	goto step1
) else ( 
	echo 请安装node环境
)
:step1
echo	**********    step1     **********
if  exist ".\node_modules\"  (
	goto step3
) else (
	goto step2
)

:step2
echo	**********    step2     **********
if exist ".\package.json\" (
	npm install | goto step3
) else (
	exit
)

:step3
echo	**********    step3     **********
for /f "delims=" %%s in (package.json) do (
	echo %%s | findstr  \"dev\" >nul &&  npm run dev 	
	echo %%s | findstr \"serve\" >nul && npm run serve
	echo %%s | findstr \"start\" >nul && npm run start
)
exit

pause  >nul