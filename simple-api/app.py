from flask import Flask

import json
import os

app = Flask(__name__)

port = int(os.getenv("PORT", "5000"))

@app.route('/')
def hello():
    msg = {
        "message": "Hello Qmonus Value Stream."
    }
    return json.dumps(msg)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)
