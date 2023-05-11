""" API for object detection using Flask """

from flask import Flask, request, jsonify
import werkzeug

app = Flask(__name__)

@app.route('/upload', methods=['POST'])
def upload():
    if(request.method == "POST"):
        imagefile = request.files['image']
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        imagefile.save("source/scripts/uploads" + filename)
        return jsonify({
            "message": "200 - SUCCESS (img uploaded to database)"
        })
    
if __name__ == '__main__':
    app.run(debug=True, port=4000)
