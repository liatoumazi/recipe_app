from flask import Flask, request, jsonify
from recipe_retrival import get_recipes

app = Flask(__name__)

@app.route('/output', methods=['POST'])
def output():
    input_string = request.json['input_string']
    result = get_recipes(input_string)
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run()
