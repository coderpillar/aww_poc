# aww_poc
This app is intended as a proof of concept to quickly learn dart and flutter.  It remains a work in progress, as does this readme document, which was hastily written and therefore lacks decent markup and reference links.  This document may be incomplete at the time of writing.

In order to run the local web server which supports the application mysql must be installed and running.  Then a mysql database should be created and its name and valid credentials should replace those in the string assigned to the 'mysqluri' variable located in '/flask_backend/config.example.py'.  Copy that file and rename as 'config.py' which is gitignored.

Some recent Python 3 version and pip should be installed and virtualenv should be installed using pip.  Then create a new virtualenv in '/flask_backend' as in 'virtualenv venv', activate it, and install the dependencies using 'pip install -r requirements.txt'

Export the flask app name (OS dependent) using instructions here(https://flask.palletsprojects.com/en/1.1.x/quickstart/#what-to-do-if-the-server-does-not-start) and run 'Flask run --cert=adhoc' so that an emulated device can communicate over ssl.
