zhihu-scrapy
============

A Scrapy Zhihu Crawler

### What is zhihu-scrapy?

zhihu-scrapy is a distributed crawler system for crawling zhihu website.The data we gather include user profile, followees and followers.Collected data can be used for various purpose(eg. finding communities, identifying popular answer posters)

###How does it work?

It combines the following systems:

1. **scrapy**	(parsing and logging)
2. **selenium**	(downloading and executing javascript)
3. **redis**	(queueing and storing results)

The crawler system consists of one main redis server to manage crawling records.
All crawling machines start a local redis server for storing user data.

###How to get started?

Start redis server on main server and crawling machines.

Add initial users to the main redis server, here we provide a python example, you can rewrite it with other clients:

```

import redis
from zhihu import settings

r = redis.StrictRedis(host=settings.REDIS_HOST, port=6379, db=0)
init_list = ['shen',]
for item in init_list:
	if not r.sismember('id_set',item):
		r.lpush('new_id_queue',item)
		r.sadd('id_set',item)

```

In `zhihu/settings.py` set `REDIS_HOST` to the ip address of the main redis server.

Use `scrapy crawl zhihu_people` to start a crawler.