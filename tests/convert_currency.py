from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json

url = ' https://pro-api.coinmarketcap.com/v1/tools/price-conversion'
parameters = {
    'symbol': 'DOGE',
    'convert': 'EUR',
    'amount': 1
}
# too lazy to secure key
# 57e78373-0c60-4f4c-aa10-966bd4c9b970
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': '57e78373-0c60-4f4c-aa10-966bd4c9b970',
}

session = Session()
session.headers.update(headers)

try:
    response = session.get(url, params=parameters)
    data = json.loads(response.text)
    print(data['data']['quote']['EUR']['price'])
except (ConnectionError, Timeout, TooManyRedirects) as e:
    print(e)
