import colander
from deform.widget import TextAreaWidget

class NewPageSchema(colander.MappingSchema):
    username = colander.SchemaNode(colander.String(), title="username",
                                   validate=colander.Length(min=4, min_err='Shorter than minimum length ${min}'),
                                   default="")
