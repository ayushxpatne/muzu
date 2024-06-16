from flask import Flask, request, jsonify
from nltk.chat.util import Chat, reflections  # Import NLTK chat utilities

app = Flask(__name__)  # Initialize Flask app

amount = 0
category = 0
# NLTK chatbot responses
responses = {
    "predict_monthly_spends": f"Based on current trends, your estimated spending for this month is INR {amount}.",
    "predict_category_spending": f"You will spend more on {category} category.",
    "analyze_data": f"You spent the most on {category} category last month.",
    # Add more responses as needed
}

# NLTK chatbot patterns and responses
patterns = [
    (r'.*how much will i spend this month?.*', "Based on current trends, your estimated spending for this month is $XXXX."),
    (r'.*estimated spending?.*', "Based on current trends, your estimated spending for this month is $XXXX."),
    (r'.*which category will i spend more on?.*', "You will spend more on %1 category."),
    (r'.*analyze my spendings?.*', "You spent the most on %1 category last month."),
    (r'How much did I spend on (\w+)\?', "You have spent $%s on %%1." % ('{amount}')), 
    (r'.*show me my (\w+) spending for last month.*', "Your %1 spending for last month was $XXXX."),
    (r'.*compare my spending on (\w+) between last month and this month.*', "Your spending on %1 has increased/decreased by $XXXX compared to last month."),
    (r'.*what is my average spending on (\w+).*', "Your average spending on %1 is $XXXX."),
    (r'.*suggest tips to save money on (\w+).*', "Consider %1 to save money on %1."),
    (r'.*provide insights into my (\w+) spending.*', "Your %1 spending shows a consistent increase/decrease."),
    # Add more patterns and responses as needed
    # Add more patterns as needed
]

# Create NLTK chatbot
chatbot = Chat(patterns, reflections)

# Route for handling user queries
@app.route('/chatbot', methods=['POST'])
def chatbot_response():
    user_query = request.json['query']  # Get user query from JSON request
    chat_response = chatbot.respond(user_query)  # Get chatbot response based on user query
    return jsonify({"response": chat_response})  # Return JSON response with chatbot's response

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)  # Run the Flask app in debug mode
