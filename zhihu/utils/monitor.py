from zhihu.settings import REDIS_HOST,CAPTCHA_CHECK_INTERVAL
from zhihu.utils import image_from_string
import redis
import time
class Monitor(object):
    
    r = redis.StrictRedis(host=REDIS_HOST, port=6379, db=0)
    
    def __init__(self):
        self.crawler_list = self.get_crawler_list()
        self.r_to_crawler = None
        
    def get_crawler_list(self):
        lst = self.r.sscan('crawler_id_set')[1]
        pipe = self.r.pipeline()
        for i in range(len(lst)):
            pipe.get('crawler:ip:%s' % lst[i])
        ip_lst = pipe.execute()
        for i in range(len(lst)):
            lst[i] = (lst[i],ip_lst[i])
        return lst
    
    @classmethod
    def clear_crawler_set(cls):
        cls.r.delete('crawler_id_set')
    
    @classmethod 
    def add_user_id(cls,uid):
    	if not cls.r.sismember('id_set',uid):
    		cls.r.lpush('new_id_queue',uid)
    		cls.r.sadd('id_set',uid)
            
    @classmethod
    def add_user_ids(cls,lst):
        for item in lst:
        	cls.add_user_id(item)
    
    @classmethod
    def recrawl_expired_user(cls):
        #move expired user from proc set to new queue
        pass
        
    def solve_captcha(self,crawler_id,crawler_ip):
         self.r_to_crawler = redis.StrictRedis(host=crawler_ip, port=6379, db=0)
         #TODO: consider lock here(probably multiple monitor)
         if not self.r_to_crawler.get('crawler:status:%s' % crawler_id) == 'captcha_input':
             return
         print 'found captcha for crawler %s on %s' % (crawler_id, crawler_ip)
         self.r_to_crawler.set('crawler:status:%s' % crawler_id,'captcha_snapshot')
         print 'captcha status for crawler %s on %s set to "captcha_snapshot"' % (crawler_id, crawler_ip)
         #wait for client to take snapshot
         while True:
             captcha = self.r_to_crawler.get('captcha:%s' % crawler_id)
             if captcha:
                 print 'got captcha for crawler %s on %s' % (crawler_id, crawler_ip)
                 im = image_from_string(captcha)
                 im.show()
                 self.r_to_crawler.set('captcha_input:%s' % crawler_id,raw_input("captcha:"))
                 print 'set captcha for crawler %s on %s' % (crawler_id, crawler_ip)
                 while True:
                     #check if client made it through
                     if self.r_to_crawler.get('crawler:status:%s' % crawler_id) == 'good':
                         print 'solved captcha for crawler %s on %s' % (crawler_id, crawler_ip)
                         return
                     elif self.r_to_crawler.get('crawler:status:%s' % crawler_id) == 'captcha_input':
                         print 'failed to solve captcha for crawler %s on %s' % (crawler_id, crawler_ip)
                         return
                     time.sleep(CAPTCHA_CHECK_INTERVAL)
                     #TODO: timeout check
                 break
             time.sleep(CAPTCHA_CHECK_INTERVAL)
             
    def solve_captchas(self):
        for crawler in self.crawler_list:
            crawler_id = crawler[0]
            crawler_ip = crawler[1]
            if crawler_id and crawler_ip:
               self.solve_captcha(crawler_id,crawler_ip)
                