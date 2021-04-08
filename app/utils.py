import time
import datetime
import pandas as pd


def get_current_epoch_timestamp_ms():
	return int(time.time() * 1000)


def get_last_hour_epoch_timestamp_ms(timestamp):
	return timestamp - 3600000


def drop_data_frame_columns(dataframe, columns):
	return dataframe.drop(columns=columns)


def epoch_timestamp_to_date_time(timestamp):

	return datetime.datetime.fromtimestamp(epoch_ms_to_s(timestamp))


def epoch_ms_to_s(timestamp):
	return timestamp / 1000
