@ECHO OFF
color 07
::  判断是否存在node环境? continue : 提示安装环境，程序结束
echo step 0
echo.
echo	node环境检测
for /f "delims=" %%a in ('node --version') do ( 
	set node_var=%%a 
	set str=v1
)
:: node --version 在实际中可能会有换行符的存在，导致echo失败或者错误
rem echo	%node_var%
rem echo	%str%

echo %node_var% | findstr %str% >nul && (
	echo		node环境ok！
	goto step1
) || (
	echo 请安装node环境
)

:step1
:: 判断node_modules文件夹是否存在
echo step 1
echo.
echo 检测是否需要npm install

if exist ".\node_modules\" (
	echo		node_modules 存在，continue step 3
	goto  step3
	
) else (
	echo 		node_modules 不存在, step 2
	goto step2
)

:step2
:: 执行相关的npm install 指令，然后执行step3
echo step 2
echo.
npm install | goto step3

:step3
:: 检测package.json中script中的指令与命令
echo step 3
echo.
rem type package.json, “”利用转义符标识出来
for /f "delims=" %%s in (package.json) do (
	echo %%s | findstr  \"dev\" >nul && (
		echo 准备启动npm run dev
		goto step4
	)	
	echo %%s | findstr \"serve\" >nul && (
		echo 准备启动npm run serve
		goto step5
	)
	echo %%s | findstr \"start\" >nul && (
		echo 准备启动npm run start
		goto step6
	)
)
echo "未能成功启动项目！！！"

:step4
:: 执行
echo step 4
echo.
npm run dev

:step5
:: 执行
echo step 5
echo.
npm run serve

:step6
:: 执行
echo step 6
echo.
npm run start

pause  >nul