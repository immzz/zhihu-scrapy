# -*- coding: utf-8 -*-
from scrapy.contrib.spiders import CrawlSpider
from scrapy.spider import Spider
from scrapy import log
#from scrapy.contrib.linkextractors.sgml import SgmlLinkExtractor
#from scrapy.selector import Selector
#from scrapy.http import FormRequest,Request
import redis
import time,datetime
#from scrapy.http.cookies import CookieJar
from selenium import webdriver
from selenium.webdriver import ChromeOptions,DesiredCapabilities
from zhihu.items import User
import ast
import re
import random
import traceback
class PeopleSpider(Spider):
    name = 'zhihu_people'
    start_urls = []
    REDIS_HOST = 'localhost'
    r = redis.StrictRedis(host=REDIS_HOST, port=6379, db=0)
    r_local = redis.StrictRedis(host='localhost', port=6379, db=0)
    driver = None
    MAX_FETCH = 10
    FOLLOW_PER_PAGE = 20
    FOLLOW_PAGE_INTERVAL = 1
    AJAX_CHECK_INTERVAL = 0.2
    AJAX_TIMEOUT = 5
    AJAX_RETRY = 3
    AJAX_WAIT = 2
    AJAX_URL = {"followees":"/node/ProfileFolloweesListV2","followers":"/node/ProfileFollowersListV2"}
    QUERY_INTERVAL = 10
    LOGIN_URL = 'http://m.zhihu.com/#signin'
    def __init__(self):
        log.start(logfile=time.strftime("log/%Y%m%d%H%M%S")+".log",logstdout=False)
        co = ChromeOptions()
        co.add_experimental_option("prefs",{"profile.default_content_settings":{"images":2,"media":2}})
        self.driver = webdriver.Chrome(chrome_options=co)
        self.driver.set_window_size(640,960)
    def parse(self,response):
        pass
    def start_requests(self):
        self.driver.get(self.LOGIN_URL)
        
        u = self.driver.find_element_by_name("email")
        p = self.driver.find_element_by_name("password")
        u.send_keys(raw_input("Email:"))
        p.send_keys(raw_input("Password:"))
        u.submit()
        time.sleep(5)
        if self.driver.current_url == self.LOGIN_URL:
            print "login failed"
            time.sleep(7)
            u.submit()
            time.sleep(5)
        self.logged_in()
    def logged_in(self):
        while True:
            #fetch new ids to crawl
            log.msg("wait for a new query...",level=log.INFO)
            time.sleep(self.QUERY_INTERVAL)
            log.msg("fetching new ids",level=log.INFO)
            try:
                new_id_list = self.fetch_new_id_list()
            except:
                log.msg("error fetching new ids",level=log.ERROR)
                log.msg(traceback.format_exc(), level=log.ERROR)
                continue
            for new_id in new_id_list:
                user = User()
                user['id'] = new_id
                #fetch personal information
                log.msg("extracting profile for %s" % new_id,level=log.INFO)
                try:
                    self.parse_profile_page(new_id,user)
                except:
                    log.msg("error extracting profile for %s" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                    continue
                #process followees
                log.msg("extracting followees for %s" % new_id,level=log.INFO)
                try:
                    self.parse_follow_page(new_id,'followees',user)
                except:
                    log.msg("error extracting followees for %s" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                    continue
                #process followers
                log.msg("extracting followers for %s" % new_id,level=log.INFO)
                try:
                    self.parse_follow_page(new_id,'followers',user)
                except:
                    log.msg("error extracting followers for %s" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                    continue
                #save user locally
                log.msg("saving user %s locally" % new_id,level=log.INFO)
                try:
                    self.save_user_locally(user)
                except:
                    log.msg("error saving user %s locally" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                    continue
                #push new ids to redis server
                log.msg("uploading new ids for %s" % new_id,level=log.INFO)
                try:
                    upload_list = user['followees']+user['followers']
                    self.upload_new_id_list(upload_list)
                except:
                    log.msg("error uploading new ids for %s" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                    continue
                #move finished user from proc set to finish queue and update user record
                log.msg("moving %s from proc set to finish queue" % new_id,level=log.INFO)
                try:
                    if self.r.srem('proc_id_set',new_id) == 1:
                        pipe = self.r.pipeline()
                        pipe.lpush('finish_id_queue',new_id)
                        pipe.set('update_time:'+new_id,datetime.datetime.utcnow())
                        pipe.execute()
                    else:
                        log.msg("error removing id %s from proc set" % new_id,level=log.ERROR)
                except:
                    log.msg("error moving id %s from proc set to finish queue" % new_id,level=log.ERROR)
                    log.msg(traceback.format_exc(), level=log.ERROR)
                        
    def fetch_new_id_list(self):
        new_id_list = []
        pipe = self.r.pipeline()
        for i in range(self.MAX_FETCH):
            pipe.rpop('new_id_queue')
        new_id_list = pipe.execute()
        new_id_list = [x for x in new_id_list if x is not None]
        for new_id in new_id_list:
            pipe.sadd('proc_id_set',new_id)
            pipe.lpush('machine_list:'+new_id,self.get_mac_address())
            pipe.set('update_time:'+new_id,datetime.datetime.utcnow())
        pipe.execute()
        return new_id_list
            
    def upload_new_id_list(self,upload_list):
        pipe = self.r.pipeline()
        for i in range(len(upload_list)):    
            pipe.sadd('id_set',upload_list[i])
        upload_status_list = pipe.execute()
        for i in range(len(upload_status_list)):
            if upload_status_list[i] == 1:
                pipe.lpush('new_id_queue',upload_list[i])
        pipe.execute()       
            
    def parse_profile_page(self,new_id,user):
        self.driver.get('http://m.zhihu.com/people/%s/about' % new_id)
        details = self.driver.find_element_by_xpath('//div[@class="zm-profile-section-wrap zm-profile-details-wrap"]')
        try:
            user['name'] = details.find_element_by_xpath('.//span[@class="zm-profile-section-name"]/a').text
        except:
            log.msg("error extracting personal info for %s" % new_id,level=log.ERROR)
            log.msg(traceback.format_exc(), level=log.ERROR)
        ##achivements
        try:
            achive_div = details.find_element_by_xpath('.//div[@class="zm-profile-module zm-profile-details-reputation"]')
            spans = achive_div.find_elements_by_xpath('.//div[@class="zm-profile-module-desc"]/span[not(@class)]')
            user['achivement'] = {}
            for span in spans:
                achivement = span.text.split(' ')
                user['achivement'][achivement[1]] = int(achivement[0])
        except:
            log.msg("error extracting achivements for %s" % new_id,level=log.ERROR)
            log.msg(traceback.format_exc(), level=log.ERROR)
        ##detail infomation
        try:
            info_divs = details.find_elements_by_xpath('.//div[@class="zm-profile-module zg-clear"]')
            for info_div in info_divs:
                category = User.parse_category(info_div.find_element_by_xpath('./h3/span').text)
                user[category] = []
                lis = info_div.find_elements_by_xpath('./div[@class="zm-profile-module-desc"]/ul/li')
                for li in lis:
                    user[category].append([li.get_attribute('data-title'),li.get_attribute('data-sub-title'),])
        except:
            log.msg("error extracting detail information for %s" % new_id,level=log.ERROR)
            log.msg(traceback.format_exc(), level=log.ERROR)
            
    def parse_follow_page(self,new_id,category,user):
        # category - 'followees' or 'follower'
        self.driver.get('http://m.zhihu.com/people/%s/%s' % (new_id,category))
        script_content = str(self.driver.find_element_by_css_selector('.zh-general-list.clearfix').get_attribute('data-init'))
        _xsrf = str(self.driver.find_element_by_name('_xsrf').get_attribute('value'))
        post_data = ast.literal_eval(script_content)
        post_data['_xsrf'] = _xsrf
        post_data['method'] = 'next'
        del post_data['nodename']
        
        page = 1
        user[category] = []
        while True:
            post_data['params']['offset']=(page-1)*self.FOLLOW_PER_PAGE
            follow_res = self.block_ajax_load(self.AJAX_URL[category],"post",post_data)
            if not follow_res:
                break
            ex = r'"http://www\.zhihu\.com/people/([^"]+)"'
            extract_ids = re.findall(ex,follow_res)
            if len(extract_ids) == 0:
                break
            for followee_id in extract_ids:
                user[category].append(re.sub(r'\\','',followee_id))
            page += 1
            print page
            
    def save_user_locally(self,user):
        self.r_local.set(user['id'],user.__str__())
        
    def get_mac_address(self):
    	import uuid
    	node = uuid.getnode()
    	mac = uuid.UUID(int = node).hex[-12:]
    	return mac
        
    def random_sleep(self,sec):
        time.sleep(random.uniform(max(sec-1,0),sec+1))
        
    def block_ajax_load(self,url,method,params,wait=AJAX_WAIT):
        retry = 0
        while True:
            self.driver.execute_script("if($('#temp-store').length == 0) $('body').append('<input type=\"hidden\" id=\"temp-store\">'); else $('#temp-store').val('');");
            self.driver.execute_script("$.%s( '%s',%s,function(data) {$('#temp-store').val((data === undefined)?'undefined':((data=='')?'empty':JSON.stringify(data)));});" % (method,url,params.__str__()))
            start_time = time.time()
            while True:
                res =  self.driver.execute_script('return $("#temp-store").val()')
                if res == "":
                    time.sleep(self.AJAX_CHECK_INTERVAL)
                elif res == "undefined":
                    return None
                elif res == "empty":
                    return ""
                else:
                    log.msg("[Block Ajax Load] %s in %ss" % (url,str(time.time()-start_time)),level=log.INFO)
                    self.random_sleep(wait)
                    return res
                if time.time() - start_time > self.AJAX_TIMEOUT:
                    if retry < self.AJAX_RETRY:
                        log.msg("[Block Ajax Load] %s retry" % url,level=log.WARNING)
                        retry += 1
                        break
                    else:
                        log.msg("[Block Ajax Load] %s timeout" % url,level=log.WARNING)
                        return None