@echo off
rem Launch FaceFusion from the current directory with Anaconda and serve the web UI on the LAN.
rem Update FACEFUSION_ENV_NAME if your Conda env name is different.
setlocal

cd /d %~dp0
set "OUTPUT=W:\Deepfakes\faceoutput"

set "FACEFUSION_ENV_NAME=facefusion"
set "GRADIO_SERVER_NAME=0.0.0.0"
set "GRADIO_SERVER_PORT=7860"
set "GRADIO_ANALYTICS_ENABLED=0"
set "CUDA_VISIBLE_DEVICES=0"

echo Activating Conda environment: %FACEFUSION_ENV_NAME%
call conda activate "%FACEFUSION_ENV_NAME%"
if errorlevel 1 (
  echo.
  echo Failed to activate Conda environment "%FACEFUSION_ENV_NAME%".
  echo Make sure Conda is initialized for this shell and the env exists.
  echo You can also replace FACEFUSION_ENV_NAME with your actual env name.
  goto :eof
)

echo Starting FaceFusion server on http://0.0.0.0:%GRADIO_SERVER_PORT%
python facefusion.py run --open-browser --execution-device-ids 0 --output-path %OUTPUT% --execution-providers cuda
explorer.exe %OUTPUT%

endlocal
