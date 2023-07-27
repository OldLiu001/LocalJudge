:: Usage: judge <problem_number> <executable_path> [time_limit]
:: Return:
:: 	0 Accepted
:: 	1 Wrong Answer
:: 	2 Runtime Error
:: 	3 Time Limit Exceeded
:: 	4 Missing Output File(s)

@echo off
setlocal ENABLEDELAYEDEXPANSION
pushd "%~dp0"

:generate_temporary_output_file_path
set "output_file=!tmp!\!random!.out"
if exist "!output_file!" goto generate_temporary_output_file_path

for %%i in (".\problems\%~1\*.in") do (
	cscript -nologo run.vbs "%~2" "%~3" "%~4" <"%%~fi" >"!output_file!"
	if errorlevel 2 (
		>&2 echo Time limit exceeded.
		set /a result = 3 & goto exit
	) else if errorlevel 1 (
		>&2 echo Runtime error.
		set /a result = 2 & goto exit
	)
	fc "%%~dpni.out" "!output_file!" >nul 2>nul
	if errorlevel 2 (
		>&2 echo Missing output file.
		set /a result = 4 & goto exit
	) else if errorlevel 1 (
		>&2 echo Wrong answer.
		set /a result = 1 & goto exit
	)
)
echo Accepted.
set /a result = 0

:exit
del /f "!output_file!" >nul 2>nul
popd
exit /b !result!