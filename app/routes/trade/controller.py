from flask import Blueprint, request, render_template, redirect, url_for, session, flash
import pandas as pd
import app.utils as utils
import config.config as config
import app.database.connection as db_conn

mod_trade = Blueprint('trade', __name__, url_prefix='/trade')


@mod_trade.route('/history')
def trade_history():
    connection = db_conn.Connection(config.DB_HOST, config.DB_PORT, config.DB_NAME, config.DB_USER, config.DB_PASS)
    with connection.get_connection() as conn:
        primary_trades_result = conn.execute("SELECT * FROM trade WHERE 'original' = 1")
        secondary__trades_result = conn.execute("SELECT * FROM trade WHERE 'original' = 0")
    primary_trades = []
    secondary_trades = []
    for row in primary_trades_result:
        primary_trades.append({
            'id': row.id,
            'price': row.price,
            'quantity': row.quantity,
            'eur_value': row.eur_value,
            'usd_value': row.usd_value,
            'doge_value': row.doge_value,
            'status': row.status,
            'success': row.success,
            'error_code': row.error_code,
            'error_message': row.error_message,
            'timestamp': row.timestamp,
            'taker_side': row.taker_side,
            'wallet_eur_value': row.wallet_eur_value
        })
    for row in secondary__trades_result:
        secondary_trades.append({
            'original_id': row.original_id,
            'price': row.price,
            'quantity': row.quantity,
            'eur_value': row.eur_value,
            'usd_value': row.usd_value,
            'doge_value': row.doge_value,
            'status': row.status,
            'success': row.success,
            'error_code': row.error_code,
            'error_message': row.error_message,
            'timestamp': row.timestamp,
            'taker_side': row.taker_side,
            'wallet_eur_value': row.wallet_eur_value
        })
    df_p_trades = pd.DataFrame(primary_trades)
    df_s_trades = pd.DataFrame(secondary_trades)
    if primary_trades:
        df_p_trades['timestamp'] = df_p_trades['timestamp'].astype('float64')
        df_s_trades['timestamp'] = df_s_trades['timestamp'].astype('float64')
        df_p_trades['date_time'] = df_p_trades['timestamp'].apply(utils.epoch_timestamp_to_date_time)
        df_s_trades['date_time'] = df_s_trades['timestamp'].apply(utils.epoch_timestamp_to_date_time)
        success_map = {0: 'N', 1: 'Y'}
        side_map = {0: 'Seller', 1: 'Buyer'}
        df_p_trades['success'] = df_p_trades['success'].map(success_map)
        df_s_trades['success'] = df_s_trades['success'].map(success_map)
        df_p_trades['taker_side'] = df_p_trades['taker_side'].map(side_map)
        df_s_trades['taker_side'] = df_s_trades['taker_side'].map(side_map)
    return render_template("trade/history.html", title="Trade history", p_trades=df_p_trades, s_trades=df_s_trades)
