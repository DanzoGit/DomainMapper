@echo off
setlocal enabledelayedexpansion

REM �஢��塞, ��⠭����� �� Python 3
python --version 2>NUL | findstr /I "Python 3" >NUL
if ERRORLEVEL 1 (
	echo Python 3 �� ��⠭�����.
	choice /C YN /M "��⠭�����?"
	if ERRORLEVEL 2 (
		echo ��� Python 3 ��祣� �� ��������...
		pause
		exit /b 1
	) else (
        echo ����㧪� ����ਡ�⨢�...
        powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe' -OutFile 'python_installer.exe'"
        REM �஢��塞, �� �� �ᯥ譮 ᪠砭 䠩�
        if not exist "python_installer.exe" (
			echo �訡�� ����㧪� ��⠭��騪� Python 3.
			pause
			exit /b 1
		)
		REM ��⠭���� Python 3
		echo ��⠭����...
		echo PS - �� ������ �� ࠧ���� � �ᥤ��� ����
		python_installer.exe /quiet InstallAllUsers=1 PrependPath=1
		del /q /f python_installer.exe
		REM �㦭� �������� ��ᨥ��� PATH, �� � �⮬ ᥠ�� �� ��������
		echo �த� �� �� ��諮 㤠筮, �� �㦭� �������� ���㦥���, ������� ��� �ਯ� �� ࠧ.
		pause
		exit
	)
) else (
	echo ��宦� Python 3 ������� � ��⥬�.
	)

REM �஢��塞 ����稥 ����室���� ������⥪
set "modules=requests dnspython ipaddress configparser httpx"

for %%m in (%modules%) do (
    pip show %%m >NUL 2>&1
    if ERRORLEVEL 1 (
        echo ��⠭���� ������⥪� %%m...
        pip install %%m
        if ERRORLEVEL 1 (
            echo �� 㤠���� ��⠭����� ������⥪� %%m. �஢���� pip.
            exit /b 1
        )
    )
)

cls
REM ���稢��� main.py
echo ����㧪� Domain Mapper...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Ground-Zerro/DomainMapper/main/main.py' -OutFile 'main.py'"
if not exist "main.py" (
    echo �訡�� ����㧪� Domain Mapper.
	pause
    exit /b 1
)

REM ����� main.py � Python 3
echo ����᪠��...
python main.py
if ERRORLEVEL 1 (
    echo �訡�� �믮������ main.py.
    pause
    del /q /f main.py
    exit /b 1
)

echo �ணࠬ�� �����襭�.
endlocal
del /q /f main.py
exit
