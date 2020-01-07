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
        schema = NewPageSchema()
        btn = deform.form.Button(name="newpage", title="newpage")
        return deform.form.Form(schema, buttons=(btn,), action="/newpage")

    @view_config(route_name='home', renderer='../templates/mytemplate.html')
    def my_view(self):
        form = self.form_.render()
        return {"rendered_form": form}

    @view_config(route_name="newpage", renderer="../templates/newpage.html")
    def newpage(self):
        username = self.request.params.get("username", "")
        return {"username": username}
