from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from config import config
from flask_bootstrap import Bootstrap

app = Flask(__name__)
app.config.update(
    SECRET_KEY=config.SECRET_KEY,
    CSRF_SESSION_KEY=config.CSRF_SESSION_KEY,
    CSRF_ENABLED=config.CSRF_ENABLED,
    SQLALCHEMY_DATABASE_URI=config.SQLALCHEMY_DATABASE_URI,
    SQLALCHEMY_TRACK_MODIFICATIONS=config.SQLALCHEMY_TRACK_MODIFICATIONS
)
Bootstrap(app)
db = SQLAlchemy(app)


@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404


# from app.account.controller import mod_account as account_module
from app.routes.trade.controller import mod_trade as trade_module
from app.routes.dashboard.controller import mod_dashboard as dashboard_module

# app.register_blueprint(account_module)
app.register_blueprint(trade_module)
app.register_blueprint(dashboard_module)

db.create_all()
