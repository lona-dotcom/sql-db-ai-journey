@echo off
echo =====================================================
echo   Configuration de l'environnement SQL-DB-AI-Journey
echo =====================================================
echo.

:: 1. Vérifier si Python est installé
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERREUR] Python n'est pas trouve dans le PATH.
    pause
    exit /b 1
)
echo [OK] Python est installe.

:: 2. Création de l'environnement virtuel (venv - nommé "venv" selon votre capture)
IF NOT EXIST "venv" (
    echo [INFO] Creation de l'environnement virtuel "venv"...
    python -m venv venv
) ELSE (
    echo [OK] L'environnement venv existe deja.
)

:: 3. Activation de l'environnement
echo [INFO] Activation de l'environnement...
call venv\Scripts\activate.bat

:: 4. Installation des dépendances
IF EXIST "requirements.txt" (
    echo [INFO] Mise a jour des bibliotheques Python a partir de requirements.txt...
    pip install --upgrade pip
    pip install -r requirements.txt
) ELSE (
    echo [ATTENTION] requirements.txt introuvable. Creation automatique...
    pip freeze > requirements.txt
)
echo [OK] Dependances installees.

:: 5. Création du fichier .env pour les connexions BDD et API
IF NOT EXIST ".env" (
    echo [INFO] Creation du fichier .env...
    (
        echo # =========================================
        echo # Configuration SQL-DB-AI-Journey
        echo # =========================================
        echo.
        echo # Connexion PostgreSQL (Phase 2 et 3)
        echo POSTGRES_HOST=localhost
        echo POSTGRES_PORT=5432
        echo POSTGRES_USER=postgres
        echo POSTGRES_PASSWORD=VOTRE_MOT_DE_PASSE
        echo POSTGRES_DB=nom_de_votre_base
        echo.
        echo # Connexion DuckDB (Phase 4)
        echo DUCKDB_PATH=./data/database.duckdb
        echo.
        echo # Cles API pour l'IA (Phases 8, 9, 10)
        echo OPENAI_API_KEY=VOTRE_CLE_OPENAI
        echo ANTHROPIC_API_KEY=VOTRE_CLE_ANTHROPIC
    ) > .env
    echo [OK] Fichier .env cree. Pensez a remplir vos identifiants !
) ELSE (
    echo [OK] Le fichier .env existe deja.
)

:: 6. Vérification de Git (Ne touche pas à votre historique existant)
IF NOT EXIST ".git" (
    echo [INFO] Initialisation du depot Git...
    git init
) ELSE (
    echo [OK] Depot Git deja initialise. Historique conserve.
)

:: 7. Création des dossiers data
IF NOT EXIST "data\raw" mkdir data\raw
IF NOT EXIST "data\external" mkdir data\external
IF NOT EXIST "data\interim" mkdir data\interim
IF NOT EXIST "data\samples" mkdir data\samples
IF NOT EXIST "data\processed" mkdir data\processed
echo [OK] Structure de dossiers "data" verifiee.

echo.
echo =====================================================
echo   Configuration terminee !
echo   Remplissez vos identifiants dans le fichier .env
echo   Lancez le projet avec le fichier run.bat
echo =====================================================
pause