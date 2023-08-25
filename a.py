import requests
import bs4

data = requests.post(
    'http://localhost:8191/v1',
    json={
        "cmd": "request.get",
        "url":"https://www.dextools.io/app/en/ether/pair-explorer/0x4d80e91672aa477ad8cf518e27a56f63a89023d7",
        "maxTimeout": 600000
    },
    headers={
        'Content-Type': 'application/json'
    }
)

res = bs4.BeautifulSoup(data.json()['solution']['response'], 'html.parser')
tg_icon = res.select('.fa-telegram')
if tg_icon:
    tg_icon = tg_icon[0]
    tg_link = tg_icon.parent.parent
    print(tg_link.attrs['href'])
else:
    print('NOT FOUND')
