# Scrapy settings for zhihu project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'zhihu'

SPIDER_MODULES = ['zhihu.spiders']
NEWSPIDER_MODULE = 'zhihu.spiders'

COOKIES_DEBUG = True

DEBUG = True

#SPIDER SETTINGS
REDIS_HOST = 'localhost' #change this to main server address
MAX_FETCH = 10
FOLLOW_PER_PAGE = 20
AJAX_CHECK_INTERVAL = 0.2
AJAX_TIMEOUT = 5
AJAX_RETRY = 3
AJAX_WAIT = 2
AJAX_URL = {"followees":"/node/ProfileFolloweesListV2","followers":"/node/ProfileFollowersListV2"}
QUERY_INTERVAL = 10
LOGIN_URL = 'http://m.zhihu.com/#signin'
