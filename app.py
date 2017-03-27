from os import environ as env
from bottle import app
from bottle import route
from bottle import run
from bottle import static_file
from bottle import template


@route('/')
def home():
    return template('index')


@route('/gradings/<assignment>')
def grading(assignment):
	return static_file(assignment, root='gradings', mimetype='text/json')


@route('/grade/<assignment>')
@route('/grade/<assignment>/')
def grade_assignment(assignment):
	return template('grader', assignment=assignment)


if __name__ == '__main__':
    run(debug=True, server='gunicorn', host='0.0.0.0', port=int(env.get("PORT", 5000)))
