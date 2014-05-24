# -*- coding: utf-8 -*-
import redis
import ast
class RawDataParser(object):
    MAX_FETCH_NUM = 1000
    def __init__(self,):
        self.next_user_index = 0
        self.user_index = {}
        self.index_user = []
        self.finish_user_set = {}
        self.G = None
        
    def get_user_index(self,user_id):
        if user_id not in self.user_index:
            self.user_index[user_id] = self.next_user_index
            self.index_user.append(user_id)
            self.next_user_index = self.next_user_index + 1
        return self.user_index[user_id]
        
    def get_users_ranked_by_follow(self):
        res = sorted(self.finish_user_set.items(), key=lambda x: x[1]['follow_count'],reverse=True)
        return res
        
    def fetch_data(self,listhost,listport,datahost,dataport):
        r = redis.StrictRedis(host=listhost, port=listport, db=0)
        r_local = redis.StrictRedis(host=datahost, port=dataport, db=0)
        finish_id_len = r.llen('finish_id_queue')
        i = 0
        
        pipe = r_local.pipeline()
        while i < finish_id_len:
            finish_id_list = r.lrange('finish_id_queue',i,i+self.MAX_FETCH_NUM)

            for finish_id in finish_id_list:
                pipe.get("data:"+finish_id)

            finish_info_list = pipe.execute()
            for finish_info in finish_info_list:
                if finish_info:
                    user = ast.literal_eval(finish_info)
                    user['follow_count'] = len(user['followers'])+len(user['followees'])
                    self.finish_user_set[user['id']] = user

            i = i + self.MAX_FETCH_NUM
    
    def build_index(self):
        for user_id in self.finish_user_set:
            user = self.finish_user_set[user_id]
            self.get_user_index(user_id)
            for follower_id in user['followers']:
                self.get_user_index(follower_id)
            for followee_id in user['followees']:
                self.get_user_index(followee_id)
    
    @property
    def total_user_count(self):
        return self.next_user_index
            
    def parse_as_directed_graph(self):
        self.G = [[0]*self.total_user_count]*self.total_user_count
        for user_id in self.finish_user_set:
            user = self.finish_user_set[user_id]
            user_index = self.get_user_index(user_id)
            #update graph
            for follower_id in user['followers']:
                follower_index = self.get_user_index(follower_id)
                self.G[follower_index][user_index] = 1
            for followee_id in user['followees']:
                followee_index = self.get_user_index(followee_id)
                self.G[user_index][followee_index] = 1
                
    def output_edge_list(self,filename):
        f = open(filename,'wb')
        for user_id in self.finish_user_set:
            user = self.finish_user_set[user_id]
            user_index = self.get_user_index(user_id)
            #update graph
            for follower_id in user['followers']:
                follower_index = self.get_user_index(follower_id)
                f.write('%d %d\n' % (follower_index,user_index))
            for followee_id in user['followees']:
                followee_index = self.get_user_index(followee_id)
                f.write('%d %d\n' % (user_index,followee_index))
        f.close()
        
    def output_label(self,filename):
        import io
        import sys
        reload(sys)
        sys.setdefaultencoding("utf-8")
        f = open(filename, 'w')#
        for i in range(len(self.index_user)):
            f.write(u' '.join((str(i),self.index_user[i].encode('utf-8')))+'\n'.encode('utf8'))

        f.close()
                
        


                
            


