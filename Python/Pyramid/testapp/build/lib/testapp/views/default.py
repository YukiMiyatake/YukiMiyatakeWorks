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
            return Response(self.db_err_msg, content_type='text/plain', status=500)
        return {"rendered_form": form}


    db_err_msg = """\
    Pyramid is having a problem using your SQL database.  The problem
    might be caused by one of the following things:

    1.  You may need to run the "initialize_testapp_db" script
        to initialize your database tables.  Check your virtual
        environment's "bin" directory for this script and try to run it.

    2.  Your database server may not be running.  Check that the
        database server referred to by the "sqlalchemy.url" setting in
        your "development.ini" file is running.

    After you fix the problem, please restart the Pyramid application to
    try it again.
    """

    @view_config(route_name="newpage", renderer="templates/newpage.html")
    def newpage(self):
        try:
            query = self.request.dbsession.query(MyModel)
            one = query.filter(MyModel.name == 'one').first()
            form = self.form_.render()
        except DBAPIError:
            return Response(self.db_err_msg, content_type='text/plain', status=500)
        return {"project": "testapp", "one": one}
