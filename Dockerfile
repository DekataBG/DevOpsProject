FROM python:3.11
WORKDIR /project
COPY . /project
RUN pip install "fastapi[standard]"
EXPOSE 80
CMD ["python", "main.py"]