import os


BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# App config
DEBUG = True
# Develop locally if debugging, open app to network if production
HOST = '127.0.0.1' if DEBUG else '0.0.0.0'
PORT = 5000

# Database config
SQLALCHEMNY_DATABASE_URI_STAGING = 'mysql+pymysql://root@127.0.0.1:3306/staging'
SQLALCHEMY_TRACK_MODIFICATIONS = False

# Protection against *Cross-site Request Forgery (CSRF)*
CSRF_ENABLED = True

# Secret key for signing the data.
CSRF_SESSION_KEY = "secret"

# Secret key for cookies, session
SECRET_KEY = "secret"

