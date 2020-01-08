import colander
from deform.widget import TextAreaWidget


class NewPageSchema(colander.MappingSchema):
#class NewPageSchema(CSRFSchema):
    username = colander.SchemaNode(colander.String(), title="username",
                                   validator=colander.Length(min=4, min_err='Shorter than minimum length ${min}'),
                                   default="", missing=colander.null)
    email = colander.SchemaNode(colander.String(), title="email",
                                   validator=colander.Email(), missing=colander.null)

    def validator(self, node: "NewPageSchema", appstruct: dict):
        """Custom schema level validation code."""

        # appstruct is Colander appstruct after all other validations have passed
        # Note that this method might not ever be reached
        if appstruct["username"]  == colander.null:
            # This error message appears at the top of the form
            raise colander.Invalid(node["username"], "username least 4 word.")

        if appstruct["email"] == colander.null:
            # This error message appears at the top of the form
            raise colander.Invalid(node["email"], "Please fill in email field if you want to send a preview email.")

