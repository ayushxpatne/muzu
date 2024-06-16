from flask import Flask, request, jsonify
import pickle
import json

app = Flask(__name__)

# Load the trained regression model
with open('/Users/ayushpatne/Documents/Flutter/expense_tracker/lib/chatbot_logic/regression_model.pkl', 'rb') as file:
    model = pickle.load(file)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json  # Assuming JSON data with input features
    month = data['month']  # Extract the month feature

    # Perform prediction using the loaded model
    prediction = model.predict([[month]])[0]  # Assuming model expects a 2D array

    return jsonify({'prediction': prediction})

# @app.route('/add_record', methods=['POST'])
# def appendList():
#     jsonfile = '/Users/ayushpatne/Documents/Flutter/expense_tracker/lib/data/transaction2.json'
#     with open(jsonfile, mode='r', encoding='utf-8') as f:
#         feeds = json.load(f)
#         print(feeds)

#     with open(jsonfile, mode='w', encoding='utf-8') as feedsjson:
#         entry = { "user": "user3","id": "21574"}
#         feeds.append(entry)
#         print(json.dump(feeds, feedsjson))

if __name__ == '__main__':
    app.run(debug=True)