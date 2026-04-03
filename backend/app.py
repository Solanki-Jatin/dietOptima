from flask import Flask, request, jsonify
import random

app = Flask(__name__)

# Mock AI Model Logic
# Later, you will replace this with your .h5 or .pth model
def mock_predict(image_path):
    foods = [
        {"item": "Paneer Bhurji", "calories": 400, "protein": 22},
        {"item": "Dal Tadka", "calories": 250, "protein": 12},
        {"item": "Greek Yogurt", "calories": 150, "protein": 15}
    ]
    return random.choice(foods)

@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return jsonify({"error": "No image uploaded"}), 400
    
    # In a real app, save image and run model
    # For now, let's return a "Smart" mock response
    result = mock_predict("placeholder")
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)