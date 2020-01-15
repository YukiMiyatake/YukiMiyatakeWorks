import os

from wsgiref.simple_server import make_server
from pyramid.config import Configurator

from colander import (
    Boolean,
    Integer,
    Length,
    MappingSchema,
    OneOf,
    SchemaNode,
    SequenceSchema,
    String
)

from deform import (
    Form,
    ValidationFailure,
    widget
)


here = os.path.dirname(os.path.abspath(__file__))

colors = (('red', 'Red'), ('green', 'Green'), ('blue', 'Blue'))

class DateSchema(MappingSchema):
    month = SchemaNode(Integer())
    year = SchemaNode(Integer())
    day = SchemaNode(Integer())

class DatesSchema(SequenceSchema):
    date = DateSchema()

class MySchema(MappingSchema):
    name = SchemaNode(String(),
                      description = 'The name of this thing')
    title = SchemaNode(String(),
                       widget = widget.TextInputWidget(size=40),
                       validator = Length(max=20),
                       description = 'A very short title')
    password = SchemaNode(String(),
                          widget = widget.CheckedPasswordWidget(),
                          validator = Length(min=5))
    is_cool = SchemaNode(Boolean(),
                         default = True)
    dates = DatesSchema()
    color = SchemaNode(String(),
                       widget = widget.RadioChoiceWidget(values=colors),
                       validator = OneOf(('red', 'blue')))

def form_view(request):
    schema = MySchema()
    myform = Form(schema, buttons=('submit',))
    template_values = {}
    template_values.update(myform.get_widget_resources())

    if 'submit' in request.POST:
        controls = request.POST.items()
        try:
            myform.validate(controls)
        except ValidationFailure as e:
            template_values['form'] = e.render()
        else:
            template_values['form'] = 'OK'
        return template_values

    template_values['form'] = myform.render()
    return template_values

if __name__ == '__main__':
    settings = dict(reload_templates=True)
    config = Configurator(settings=settings)
    config.include('pyramid_chameleon')
    config.add_view(form_view, renderer=os.path.join(here, 'form.pt'))
    config.add_static_view('static', 'deform:static')
    app = config.make_wsgi_app()
    server = make_server('0.0.0.0', 8080, app)
    server.serve_forever()
    