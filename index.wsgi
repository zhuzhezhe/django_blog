import sae
from mywebsite import wsgi

application = sae.create_wsgi_app(wsgi.application)