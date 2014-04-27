from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
from scrapy.selector import Selector
from scrapy.http import FormRequest,Request
import redis
import time,datetime
from scrapy.http.cookies import CookieJar
from selenium import webdriver
from zhihu.items import User

def get_mac_address(self):
	import uuid
	node = uuid.getnode()
	mac = uuid.UUID(int = node).hex[-12:]
	return mac
    
class PeopleSpider(CrawlSpider):
    name = 'zhihu_people'
    start_urls = ['http://www.zhihu.com/#signin']
    r = redis.StrictRedis(host='localhost', port=6379, db=0)
    driver = webdriver.Chrome()
    MAX_FETCH = 10
    def __init__(self):
        self.driver.get('http://www.zhihu.com/#signin')
        u = self.driver.find_element_by_name("email")
        p = self.driver.find_element_by_name("password")
        u.send_keys(raw_input("Email:"))
        p.send_keys(raw_input("Password:"))
        u.submit()
        self.after_login()
        
    def after_login(self):
        #f = open('response.html')
        #f.write(response.body)
        #f.close()
        #while True:
        #fetch new ids to crawl
        new_id_list = []
        pipe = self.r.pipeline()
        new_id_len = self.r.llen('new_id_queue')
        for i in range(min(new_id_len,self.MAX_FETCH)):
            new_id = self.r.rpop('new_id_queue')
            self.r.sadd('proc_id_set',new_id)
            new_id_list.append(new_id)
            self.r.lpush('machine_list:'+new_id,self.get_mac_address())
            self.r.set('update_time:'+new_id,datetime.datetime.utcnow())
        pipe.execute()
        #process new ids
        user = User()
        for new_id in new_id_list:
            #fetch personal information
            ##name
            driver.get('http://m.zhihu.com/people/%s/about' % new_id)
            details = driver.find_element_by_xpath('//div[@class="zm-profile-section-wrap zm-profile-details-wrap"]')
            try:
                name_div = details.find_element_by_xpath('.//span[@class="zm-profile-section-name"]')
                user['name'] = name_div.find_element_by_xpath('a').text
            except:
                pass
            ##achivements
            try:
                achive_div = details.find_element_by_css_selector('.zm-profile-details-reputation')
                spans = achive_div.find_element_by_css_selector('.zm-profile-module-desc').find_element_by_xpath('span[class=""]')
                
                user['name'] = name_div.find_element_by_xpath('a').text
            except:
                pass
            #process followees
            driver.get('http://m.zhihu.com/people/%s/followees' % new_id)
            ##click 'more' button until all loaded
            
            #process followers
            driver.get('http://m.zhihu.com/people/%s/followers' % new_id)
            ##click 'more' button until all loaded
        
    def parse_followee_page(self,response):
        print "HELLO HERE"
        f = open('response.html','wb')
        f.write(response.body)
        f.close()

        # continue scraping with authenticated session...