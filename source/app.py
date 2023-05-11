import os
from flask import Flask, request
from werkzeug.utils import secure_filename

app = Flask(__name__)

parent_path = os.getcwd()
UPLOAD_FOLDER = os.path.join(parent_path, 'uploads')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    if file:
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        return "200 - Success"
    else:
        return "409 - File did not upload"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000, debug=True)