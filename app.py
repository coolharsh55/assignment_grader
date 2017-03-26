from bottle import route
from bottle import run
from bottle import template


@route('/')
def home():
    return template('index')


if __name__ == '__main__':
    run(server='gunicorn', host='0.0.0.0', port=5000)