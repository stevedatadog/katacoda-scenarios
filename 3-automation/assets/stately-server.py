from wsgiref.simple_server import make_server

import falcon
import uuid

class DefaultResource:
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200 
        resp.content_type = "text/html"
        with open('index.html', 'r') as f:
          resp.body = f.read()

class StateResource:
    def on_get(self, req, resp):
        resp.status = falcon.HTTP_200  
        resp.text = '{{ "user": "{}", "state": "010101010" }}'.format(uuid.uuid1())

    def on_post(self, req, resp):
        resp.status = falcon.HTTP_200  
        resp.text = '{{ "user": "{}", "state": "010101010" }}'.format(uuid.uuid1())

app = falcon.App()

app.add_route('/', DefaultResource())
app.add_route('/state', StateResource())

if __name__ == '__main__':
    with make_server('', 8000, app) as httpd:
        print('Serving on port 8000...')

        # Serve until process is killed
        httpd.serve_forever()