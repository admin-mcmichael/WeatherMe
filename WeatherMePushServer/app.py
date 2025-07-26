from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/notify', methods=['POST'])
def notify():
    data = request.get_json()
    print("Received notification request:", data)
    # TODO: Validate + trigger APNs push notification here
    return jsonify({"status": "Push initiated"}), 200

if __name__ == "__main__":
    app.run(debug=True)
