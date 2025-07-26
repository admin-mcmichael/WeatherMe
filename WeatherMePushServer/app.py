from flask import Flask, request, jsonify
from apns2.client import APNsClient
from apns2.payload import Payload
import os

app = Flask(__name__)

# Load your APNs Auth Key (.p8) file
APNS_AUTH_KEY = "AuthKey_XXXXXXXXXX.p8"
APNS_KEY_ID = "YOUR_KEY_ID"
APNS_TEAM_ID = "YOUR_TEAM_ID"
APNS_TOPIC = "com.your.bundle.id"  # your app's bundle identifier
USE_SANDBOX = True  # change to False for production builds

apns_client = APNsClient(
    APNS_AUTH_KEY,
    key_id=APNS_KEY_ID,
    team_id=APNS_TEAM_ID,
    use_sandbox=USE_SANDBOX,
    use_alternative_port=False
)

@app.route('/notify', methods=['POST'])
def notify():
    data = request.get_json()
    print("Received notification request:", data)

    token = data.get('token')
    lat = data.get('lat')
    lon = data.get('lon')

    if not token or lat is None or lon is None:
        return jsonify({"error": "Missing lat, lon or token"}), 400

    # Build the APNs payload
    payload = Payload(
        alert=f"Umbrella alert! It might rain today near ({lat}, {lon}).",
        sound="default",
        badge=1
    )

    try:
        print("Sending push to token:", token)
        result = apns_client.send_notification(token, payload, APNS_TOPIC)
        print("Push sent result:", result)
        return jsonify({"status": "Push sent"}), 200
    except Exception as e:
        print("Push failed:", str(e))
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
