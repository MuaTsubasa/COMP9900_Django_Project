import json

from django.http import JsonResponse
from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.http import require_http_methods
import dialogflow
import os
import json
from django.views.decorators.csrf import csrf_exempt

from flask import Flask
from flask import request
from flask_restplus import Resource, Api
from flask_restplus import fields
from flask_restplus import inputs
from flask_restplus import reqparse
from flask_cors import CORS

import time
import requests
import operator

from pymongo import MongoClient



###################################################


app = Flask(__name__)
cors = CORS(app, resources={r"/ASK_questions_to_dialogflow/*": {"origins": "*"}})
api = Api(app,
          default="Chatbot",  # Default namespace
          title="Chatbot",  # Documentation Title
          description="This is a project of COMP9900.")  # Documentation Description






def detect_intent_with_parameters(project_id, session_id, query_params, language_code, user_input):
    """Returns the result of detect intent with texts as inputs.

    Using the same `session_id` between requests allows continuation
    of the conversaion."""
    session_client = dialogflow.SessionsClient()

    session = session_client.session_path(project_id, session_id)
    print('Session path: {}\n'.format(session))

    # text = "this is as test"
    text = user_input

    text_input = dialogflow.types.TextInput(
        text=text, language_code=language_code)

    query_input = dialogflow.types.QueryInput(text=text_input)

    response = session_client.detect_intent(
        session=session, query_input=query_input,
        query_params=query_params
    )

    print('=' * 20)
    print('Query text: {}'.format(response.query_result.query_text))
    print('Detected intent: {} (confidence: {})\n'.format(
        response.query_result.intent.display_name,
        response.query_result.intent_detection_confidence))
    print('Fulfillment text: {}\n'.format(
        response.query_result.fulfillment_text))

    return format(response.query_result.fulfillment_text)

@api.route('/ASK_questions_to_dialogflow/<string:id>')
@api.param('id', 'user input')
class Dentists(Resource):
    @api.response(404, '404 Error')
    @api.response(200, 'Successful')
    @api.doc(description="ask chatbot questions and return answers")
    def get(self, id):
        GOOGLE_AUTHENTICATION_FILE_NAME = "-9900Clinic-c50668370261.json"
        current_directory = os.path.dirname(os.path.realpath(__file__))
        path = os.path.join(current_directory, GOOGLE_AUTHENTICATION_FILE_NAME)
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = path

        GOOGLE_PROJECT_ID = "e9900clinic-qtuqsm"
        session_id = "1234567891"
        context_short_name = "does_not_matter"

        context_name = "projects/" + GOOGLE_PROJECT_ID + "/agent/sessions/" + session_id + "/contexts/" + \
                       context_short_name.lower()

        parameters = dialogflow.types.struct_pb2.Struct()

        context_1 = dialogflow.types.context_pb2.Context(
            name=context_name,
            lifespan_count=2,
            parameters=parameters
        )
        query_params_1 = {"contexts": [context_1]}

        language_code = 'en'
        input_text = id

        response = detect_intent_with_parameters(
            project_id=GOOGLE_PROJECT_ID,
            session_id=session_id,
            query_params=query_params_1,
            language_code=language_code,
            user_input=input_text
        )
        print("response:",response)
        result = {}
        result['result'] = response

        return result, 200






if __name__ == '__main__':
    db_name = 'k_database'
    mongo_port = 25912
    mongo_host = 'mongodb://Zanlai:hzl13579@ds125912.mlab.com:25912/k_database'

    # run the application
    app.run(debug=True, port=8888)
