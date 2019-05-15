from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

with open('index.html') as f:
    index_html = f.read()

whitelist = ['ls', 'echo', 'whoami', 'id', 'uname', 'pwd']

@app.route('/')
def index():
    return index_html

@app.route('/query')
def query():
    data = request.get_json()
    q = data['query'].split(' ')
    if len(q) == 0:
        return jsonify({'result': 'invalid query'})
    if q[0] not in whitelist:
        return jsonify({'result': 'invalid command'})
    s = subprocess.check_output(' '.join(q), shell=True, timeout=1)
    return jsonify({'result': 'ok', 'data': s})
