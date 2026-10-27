@echo off
rem ============================================================
rem 本地预览 Nuclei Development Tool Guide
rem 用法:
rem   preview.bat             构建并启动 http://localhost:8000
rem   preview.bat 8080        指定端口
rem   preview.bat 8000 nobrowser  不自动打开浏览器
rem 说明: Windows 下跳过 wavedrom/drawio 扩展(依赖 libxcb.dll 与
rem       pass_fds, 本机不可用), 文档内容未使用相关指令, 不影响预览。
rem ============================================================
setlocal
chcp 65001 >nul
cd /d "%~dp0"

set "PORT=%~1"
if "%PORT%"=="" set "PORT=8000"

where python >nul 2>nul
if errorlevel 1 (
    echo [ERROR] 未找到 python, 请先安装 Python 并加入 PATH。
    pause
    exit /b 1
)

set "SPHINX_EXT=sphinx_rtd_theme,sphinx.ext.githubpages,sphinx.ext.mathjax,sphinx.ext.autosectionlabel,sphinx_markdown_tables,recommonmark"

echo [1/2] 构建 HTML 到 build\html ...
python -m sphinx -b html source build\html -q -D "extensions=%SPHINX_EXT%"
if errorlevel 1 (
    echo [ERROR] 构建失败, 请检查上面的输出。
    pause
    exit /b 1
)

if not exist "build\html\ide\intro.html" (
    echo [ERROR] 未生成 build\html\ide\intro.html。
    pause
    exit /b 1
)

set "URL=http://localhost:%PORT%/ide/intro.html"
echo [2/2] 预览地址: %URL%   ^(Ctrl+C 停止^)
if /i not "%~2"=="nobrowser" start "" "%URL%"

rem 先结束占用该端口的旧预览进程, 避免重复启动多个 http.server
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /R ":%PORT% " ^| findstr "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>nul
)

python -m http.server %PORT% -d build\html
