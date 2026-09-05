@echo off
:: Active l'environnement virtuel du projet
call venv\Scripts\activate.bat
echo ======================================================
echo.
echo		      Bonjour Lovatahiana
echo.
echo  Tongasoa eto amin'ny tontolon'ny "SQL DB AI Journey"
echo.
echo =====================================================
echo  Efa velona ny tontolo iainana "SQL DB AI Journey" !
echo =====================================================
echo.
echo Inona no tianao ho atao?
echo.
echo   [1] Handefa ny Jupyter Notebook (Ao anatin'ny dossier notebooks)
echo   [2] Hanokatra terminal Python interactif
echo   [3] Hampiasa script ao @ dossier "scripts" (ex: script.py)
echo   [4] Hivoaka
echo.
set /p choice="Ataovy ary ny safidinao (1, 2, 3 ou 4) : "

if "%choice%"=="1" (
    echo Eo am-pandefasana an'i Jupyter. Mahandrasa kely azafady...
    jupyter notebook "notebooks"
) else if "%choice%"=="2" (
    echo Eo am-panokafana ny terminal Python...
    python
) else if "%choice%"=="3" (
    set /p script_name="Entrez le nom du script (ex: connexion_postgres.py) : "
    python "scripts\%script_name%"
) else (
    echo Fermeture du script.
    pause
)