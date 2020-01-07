from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError
from ..schema import *
import deform
from deform.widget import TextAreaWidget
from pyramid.decorator import reify
from pyramid.renderers import get_renderer
from ..models import MyModel


class Views(object):
    def __init__(self, request):
        self.request = request

    @reify
    def form_(self):
        schema = NewPageSchema().bind(request=self.request)
        btn = deform.form.Button(name="newpage", title="newpage")
        return deform.form.Form(schema, buttons=(btn,), action="/newpage")

    @view_config(route_name='home', renderer='../templates/mytemplate.html')
    def my_view(self):
        try:
            query = self.request.dbsession.query(MyModel)
            one = query.filter(MyModel.name == 'one').first()
            form = self.form_.render()
        except DBAPIError:
            return Response(self.err_msg, content_type='text/plain', status=500)
        return {"rendered_form": form}


    db_err_msg = """\
    sorry error
    """

    @view_config(route_name="newpage", renderer="../templates/newpage.html")
    def newpage(self):
        username = self.request.params.get("username", "")
        return {"username": username}
