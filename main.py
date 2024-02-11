import subprocess
from flask import Flask, request
app = Flask(__name__)


@app.route('/')
def index():
    return '''
<!doctype html>
<html>
<head>
    <title>复赛测试系统</title>
</head>
<body>
<h1>这是来自chi的测试系统</h1>
<h1>使用你的聪明才智，骗过AI吧</h1>
<hr/>
<h2>在这里输入你的小作文</h2>
<textarea id="input" style="width:80%;height:20%"></textarea>
<div id="resp"></div>
<script>
  async function commit () {
    content = document.getElementById("input").value
    r = document.getElementById("resp")
    resp = await fetch('/test?input=' + encodeURIComponent(content))
    res = await resp.text()
    r.innerHTML += (new Date() + '您的输入:' + content +  '返回内容：' + res) + "<br/>"
  }
</script><br/>
<button onclick="commit()">点我提交</button>
</body>
</html>
    '''
@app.route('/test')
def predict():
    res = request.args.get('input')
    prompt = res
    command = ["./run.o", "stories15M.bin", "-i", prompt]

    process_result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    output_text = process_result.stdout if process_result.returncode == 0 else process_result.stderr
    resp = output_text[len(prompt):]
    resp = resp.lower()
    print(resp)
    score = 0
    if resp.find("good") != -1 :
        score += 30
    if resp.find("great") != -1:
        score += 30
    if resp.find("awesome") != -1:
        score += 20
    if resp.find("chihuo2104") != -1:
        score += 10
    if resp.find("neko") != -1:
        score += 5
    if resp.find("🐢") != -1:
        score += 5
    return "您的分数：" + str(score) + "\n返回文本：" + resp
app.run(host='0.0.0.0', port=4000)
