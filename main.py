from fastapi import FastAPI
import socket

app = FastAPI()

@app.get("/", response_model=str)
def hello_world():
    return "Hello World"

@app.get("/hostname", response_model=str)
def hello_world():
    return socket.gethostname()