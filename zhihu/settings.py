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
DEBUG_INFO = False
DEBUG_WARNING = True

#SPIDER SETTINGS

REDIS_HOST = '54.187.128.27' #change this to main server address
REDIS_LOCAL_PORT = 80
REDIS_LOCAL_MAPPING_PORT = 14437

PUBLIC_IP = ''

MAX_FETCH = 10
FOLLOW_PER_PAGE = 20
AJAX_CHECK_INTERVAL = 0.2
AJAX_TIMEOUT = 5
AJAX_RETRY = 2
AJAX_WAIT = 2
AJAX_URL = {"followees":"/node/ProfileFolloweesListV2","followers":"/node/ProfileFollowersListV2"}
QUERY_INTERVAL = 10
UNTRACABLE_REQUEST_WAIT = 10
LOGIN_URL = 'http://m.zhihu.com/#signin'
LOGIN_RETRY = 2
CAPTCHA_CHECK_INTERVAL = 5

PROC_ID_TIMEOUT = 72000 #20 hours

CRAWLER_HEARTBEAT_INTERVAL = 60 #report every 1 minute
CRAWLER_HEARTBEAT_TIMEOUT = 120