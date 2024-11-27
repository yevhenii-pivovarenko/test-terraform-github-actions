import functions_framework  # pre-installed in Cloud Functions

@functions_framework.http
def hello(request):
    return "hello, stranger"
