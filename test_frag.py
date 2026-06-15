import urllib.request

url = 'https://www.fragrantica.com/perfume/Nautica/Nautica-Voyage-913.html'
req = urllib.request.Request(
    url, 
    headers={'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36'}
)

try:
    with urllib.request.urlopen(req) as response:
        html = response.read().decode('utf-8')
        print(html[:500])
except Exception as e:
    print("Error:", e)
