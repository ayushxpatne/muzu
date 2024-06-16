import json

def appendList(jsonfile):
    with open(jsonfile, mode='r', encoding='utf-8') as f:
        feeds = json.load(f)
        print(feeds)

    with open(jsonfile, mode='w', encoding='utf-8') as feedsjson:
        entry = { "user": "user3","id": "21574"}
        feeds.append(entry)
        print(json.dump(feeds, feedsjson))