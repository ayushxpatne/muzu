from flask import Flask, request, jsonify
import pickle
from datetime import datetime as datetimeforcurrent
import datetime
import get_category_summary
import random
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords


app = Flask(__name__)


# Initialize NLTK
nltk.download('punkt')
nltk.download('stopwords')

# List of greetings and responses
greetings = ['hello', 'hi', 'hey', 'howdy', 'greetings', 'good morning', 'good afternoon', 'good evening']
responses = [
    'Hello!', 'Hi there!', 'Hey!', 'Hello, how can I help you?', 'Greetings!',
    'Good morning!', 'Good afternoon!', 'Good evening!', 'Nice to see you!'
]

# Function to preprocess text
def preprocess_text(text):
    tokens = word_tokenize(text.lower())  # Tokenize and convert to lowercase
    tokens = [token for token in tokens if token not in stopwords.words('english')]  # Remove stopwords
    return tokens




with open("lib/chatbot_logic/naive_bayes_classification.pkl", "rb") as file:
    naive_bayes_model = pickle.load(file)


def regression_next_month():
    with open("lib/chatbot_logic/regression_model.pkl", "rb") as file:
        regression_model = pickle.load(file)

    current_month = datetimeforcurrent.now().month
    name = datetime.date(1900, current_month, 1).strftime("%B")

    current_year = datetimeforcurrent.now().year

    prediction = regression_model.predict([[current_month]])[0]

    return f"Hello! After seeing your data, I think you will spend INR {prediction} this month."


def regression_next_months():
    pass


def classify_user_message(message):
    pred = naive_bayes_model.predict([message])
    return pred[0]


class_list = [
    "predict_month",
    "predict_months",
    "analyse_top_category",
    "analyse_and_compare_categories",
    "analyse",
    "advice",
]

# Function to handle user input

   


# Route for handling incoming messages
@app.route("/message", methods=["POST"])
def handle_message():

    data = request.get_json()
    message = data["message"]
    class_ = classify_user_message(message)
    response = f"Category: {class_}"  # Simple echo response
    
    tokens = preprocess_text(message)
    # Check for greetings

    if class_ == "predict_month" or class_ == "predict_months":
        response = regression_next_month()
        return jsonify({"response": response})

    elif class_ in [
        "analyse_top_category",
        "analyse_and_compare_categories",
        "analyse",
    ]:
        response = category_most_spent()
        return jsonify({"response": response})
    elif class_ == 'greetings':
        response = random.choice(responses)
        return jsonify({"response": response})
    else:
        return jsonify({"response": response})

    # data = request.get_json()
    # message = data['message']
    # class_ = classify_user_message(message)
    # response = f'Category: {class_}'  # Simple echo response
    # return jsonify({'response': response})


# spend this month?
# category most spent on?


def analysis():

    pass


def category_most_spent():

    current = datetimeforcurrent.now().month - 3
    name = datetime.date(1900, current, 1).strftime("%B")

    current_year = datetimeforcurrent.now().year

    summary, max_spent_category = get_category_summary.get_category_and_max_category(
        f"{name}, {current_year}"
    )

    response_pre = f"""Hello, for the month of {name}, you have spent INR {max_spent_category[1]} on {max_spent_category[0]}.
\nHere are the rest of expenses:\n
"""
    for category_and_amt in summary:
        response_pre += f"INR {category_and_amt[1]} on {category_and_amt[0]}\n"

    return response_pre


def category_comparisons():
    pass


def advice():
    pass


# * MORE OPTIONS CAN BE
# * MONTH-ON-MONTH CATEGORY EXPENSE ANALYSIS
# * YEARLY ANALYSIS
# * COMPARISON OF CURRENT AND PREVIOUS MONTHS

if __name__ == "__main__":
    app.run(debug=True)
