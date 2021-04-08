import plotly.graph_objects as go
import plotly.utils
import pandas as pd
from datetime import datetime
import json


class Candlestick:

    def __init__(self, df, title, y_label):
        self.fig = go.Figure(
            data=[go.Candlestick(
                x=df['date_time'],
                open=df['open'],
                close=df['close'],
                high=df['high'],
                low=df['low'],
            )])
        self.fig.update_layout(
            title=title,
            yaxis_title=y_label,
        )

    def get_fig(self):
        return self.fig

    def get_json_graph(self):
        return json.dumps(self.get_fig(), cls=plotly.utils.PlotlyJSONEncoder)
