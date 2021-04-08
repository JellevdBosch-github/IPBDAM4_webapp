from flask import Blueprint, request, render_template, redirect, url_for, session, flash
import pandas as pd
import app.utils as utils
import config.config as config
from app.graphs.candlestick import Candlestick
import app.database.connection as db_conn

mod_dashboard = Blueprint('dashboard', __name__, url_prefix='/')


@mod_dashboard.route('/')
def dashboard_overview():
    connection = db_conn.Connection(config.DB_HOST, config.DB_PORT, config.DB_NAME, config.DB_USER, config.DB_PASS)
    with connection.get_connection() as conn:
        candlestick_result = conn.execute("SELECT * FROM candlestick")
    candles = []
    for row in candlestick_result:
        candles.append({
            'date_time': row.open_timestamp,
            'open': row.open,
            'close': row.close,
            'high': row.high,
            'low': row.low
        })
    candles = pd.DataFrame(candles)
    candles['date_time'] = candles['date_time'].astype('float64')
    candles['date_time'] = candles['date_time'].apply(utils.epoch_timestamp_to_date_time)
    candlestick_chart = Candlestick(candles, 'Dogecoin rate', 'Price').get_json_graph()
    return render_template("dashboard/index.html", title="Dashboard Overview", candlestick=candlestick_chart)


@mod_dashboard.route('/wallet')
def dashboard_wallet():
    connection = db_conn.Connection(config.DB_HOST, config.DB_PORT, config.DB_NAME, config.DB_USER, config.DB_PASS)
    with connection.get_connection() as conn:
        wallet_result = conn.execute("SELECT * FROM wallet")
    wallet = []
    for row in wallet_result:
        wallet.append({
            'eur_value': row.eur_value,
            'usd_value': row.usd_value,
            'doge_value': row.doge_value,
        })
    return render_template("dashboard/wallet.html", title="Wallet | Dashboard", wallet=wallet[0])
