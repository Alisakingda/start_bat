@ECHO OFF
color 07
::  �ж��Ƿ����node����? continue : ��ʾ��װ�������������
echo step 0
echo.
echo	node�������
for /f "delims=" %%a in ('node --version') do ( 
	set node_var=%%a 
	set str=v1
)
:: node --version ��ʵ���п��ܻ��л��з��Ĵ��ڣ�����echoʧ�ܻ��ߴ���
rem echo	%node_var%
rem echo	%str%

echo %node_var% | findstr %str% >nul && (
	echo		node����ok��
	goto step1
) || (
	echo �밲װnode����
)

:step1
:: �ж�node_modules�ļ����Ƿ����
echo step 1
echo.
echo ����Ƿ���Ҫnpm install

if exist ".\node_modules\" (
	echo		node_modules ���ڣ�continue step 3
	goto  step3
	
) else (
	echo 		node_modules ������, step 2
	goto step2
)

:step2
:: ִ����ص�npm install ָ�Ȼ��ִ��step3
echo step 2
echo.
npm install | goto step3

:step3
:: ���package.json��script�е�ָ��������
echo step 3
echo.
rem type package.json, ��������ת�����ʶ����
for /f "delims=" %%s in (package.json) do (
	echo %%s | findstr  \"dev\" >nul && (
		echo ׼������npm run dev
		goto step4
	)	
	echo %%s | findstr \"serve\" >nul && (
		echo ׼������npm run serve
		goto step5
	)
	echo %%s | findstr \"start\" >nul && (
		echo ׼������npm run start
		goto step6
	)
)
echo "δ�ܳɹ�������Ŀ������"

:step4
:: ִ��
echo step 4
echo.
npm run dev

:step5
:: ִ��
echo step 5
echo.
npm run serve

:step6
:: ִ��
echo step 6
echo.
npm run start

pause  >nul