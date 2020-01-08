import colander
from deform.widget import TextAreaWidget

#CSRFSchema
#class NewPageSchema(colander.MappingSchema):
class NewPageSchema(colander.Schema):
    username = colander.SchemaNode(colander.String(), title="username",
                                   validator=colander.Length(min=4, min_err='Shorter than minimum length ${min}'),
                                   default="")
    email = colander.SchemaNode(colander.String(), title="email",
                                   validator=colander.Email())
