from pyramid.config import Configurator
from pyramid.session import SignedCookieSessionFactory
from pyramid.session import JSONSerializer
from pyramid.session import PickleSerializer
from pyramid.session import SignedCookieSessionFactory


class JSONSerializerWithPickleFallback(object):
    def __init__(self):
        self.json = JSONSerializer()
        self.pickle = PickleSerializer()

    def dumps(self, value):
        # maybe catch serialization errors here and keep using pickle
        # while finding spots in your app that are not storing
        # JSON-serializable objects, falling back to pickle
        return self.json.dumps(value)

    def loads(self, value):
        try:
            return self.json.loads(value)
        except ValueError:
            return self.pickle.loads(value)

def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """

    serializer = JSONSerializerWithPickleFallback()
    session_factory = SignedCookieSessionFactory('testapp', serializer=serializer)

    config = Configurator(settings=settings)
    config.set_session_factory(session_factory)
    config.include('pyramid_jinja2')
    config.include('.models')
    config.include('.routes')
    config.scan()
    
    config.add_jinja2_renderer(".html")

    return config.make_wsgi_app()
