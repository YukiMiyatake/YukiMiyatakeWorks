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
        newpage = deform.form.Button(name="newpage", title="newpage")
        return deform.form.Form(schema, buttons=(newpage,), action="/")

    @view_config(route_name='home', renderer='../templates/mytemplate.html')
    def my_view(self):
        form = {}

        if 'newpage' in self.request.params:
            controls = self.request.POST.items()

            try:
                self.form_.validate(controls)
                appstruct = { "username": self.request.params.get("username"), "email": self.request.params.get("email")}
                self.request.session["testapp.formdata"] = appstruct
                return HTTPFound(location= self.request.route_url('newpage'))
            except ValidationFailure as e:
                form=e.render()
        else:
            appstruct = self.request.session.get("testapp.formdata", None)
            if appstruct is None:
                form = self.form_.render()
            else:
                form = self.form_.render(appstruct)

        return {"rendered_form": form}

    @view_config(route_name="newpage", renderer="../templates/newpage.html")
    def newpage(self):

        appstruct = self.request.session["testapp.formdata"] 
        username = appstruct["username"]
        email = appstruct["email"]
        return {"username": username, "email": email }
