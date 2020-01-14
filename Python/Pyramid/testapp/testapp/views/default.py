import logging
from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError
from ..schema import *
import deform
from deform.widget import TextAreaWidget
from pyramid.decorator import reify
from pyramid.renderers import get_renderer
from ..models import MyModel
#from pylons.controllers.util import abort, redirect
from pyramid.httpexceptions import HTTPFound

logger = logging.getLogger(__name__)

from deform import (
    Form,
    ValidationFailure,
    widget
)

class Views(object):
    def __init__(self, request):
        self.request = request

    @reify
    def form_(self):
        schema = NewPageSchema()
        btn = deform.form.Button(name="newpage", title="newpage")
        return deform.form.Form(schema, buttons=(btn,), action="/")

    @view_config(route_name='home', renderer='../templates/mytemplate.html')
    def my_view(self):
        form = {}
        if 'newpage' in self.request.params:
            controls = self.request.POST.items()

            try:
                self.form_.validate(controls)
                self.request.session["testapp.username"] = self.request.params.get("username")
                self.request.session["testapp.email"] = self.request.params.get("email")
                return HTTPFound(location= self.request.route_url('newpage'))
            except ValidationFailure as e:
                form=e.render()
        else:
            form = self.form_.render()

        return {"rendered_form": form}

    @view_config(route_name="newpage", renderer="../templates/newpage.html")
    def newpage(self):

        username = self.request.session["testapp.username"]
        email = self.request.session["testapp.email"]
        return {"username": username, "email": email }
