from fastapi import FastAPI
import uvicorn
import socket

app = FastAPI()

@app.get("/", response_model=str)
def hello_world():
    return "Hello World"

@app.get("/hostname", response_model=str)
def hello_world():
    return socket.gethostname()

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8000)