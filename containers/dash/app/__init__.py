from flask import Flask

def init_app():

	flask_app = Flask(__name__)
	
	@flask_app.route('/')
	def index():
		return 'Hello Flask app'
	
	
	return flask_app


    
