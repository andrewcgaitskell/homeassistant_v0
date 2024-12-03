from werkzeug.middleware.dispatcher import DispatcherMiddleware

from app import init_app
flask_application = init_app()
import pickle
from app.dashapp1 import app as dashapp1
from app.dashapp2 import app as dashapp2

application = DispatcherMiddleware(flask_application, {
    '/dashapp1': dashapp1.server,
    '/dashapp2': dashapp2.server,
    
})

  
