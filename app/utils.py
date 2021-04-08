import time
import pandas as pd


def get_current_unix_timestamp_ms():
	return int(time.time() * 1000)


def get_last_hour_unix_timestamp_ms(timestamp):
	return timestamp - 3600000


def drop_data_frame_columns(dataframe, columns):
	return dataframe.drop(columns=columns)
