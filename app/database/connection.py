# class for connecting and retrieving connection to mysql database
from sqlalchemy import create_engine


class Connection:

    def __init__(self, host, port, database, user, password):
        self.engine = create_engine(f'mysql+pymysql://{user}@{host}:{port}/{database}')
        self.conn = self.connect()

    def connect(self):
        try:
            return self.engine.connect()
        except ConnectionError as ce:
            print(ce)

    def disconnect(self):
        return self.conn.close()

    def get_connection(self):
        return self.conn

    # def execute(self, query):
    #     with self.engine.begin() as connection:
    #         connection.execute(query)
    #
    # def read(self, query):
    #     with self.engine.begin() as connection:
    #         return connection.execute(query).fetchall()
