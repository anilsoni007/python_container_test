FROM python:3.13-rc-alpine3.18
WORKDIR python_exec
COPY main.py .
ENTRYPOINT ["python3","main.py"]
