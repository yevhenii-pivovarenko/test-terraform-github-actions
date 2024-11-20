import functions_framework

from markupsafe import escape

@functions_framework.http
def hello(request):
    return "hello, stranger"
