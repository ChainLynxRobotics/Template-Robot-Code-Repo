@echo on
set JAVA_HOME="C:\Users\Public\wpilib\2024\jdk"
setlocal

ping -n 1 google.com > nul
if %errorlevel% neq 0 (
    echo Not connected to the internet, defaulting to deploying main branch.
    goto :deploy_main
)

git fetch origin
git switch --force main

:deploy_main

call gradlew deploy
if %errorlevel% neq 0 (
    echo Deployment failed!
    exit /b 1
)
echo Deployment successful!

:end
pause
exit /b
