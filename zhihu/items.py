# -*- coding: utf-8 -*-
# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy.item import Item, Field

class User(Item):
    # define the fields for your item here like:
    # name = Field()
    id = Field()
    name = Field()
    stats = Field()
    achivement = Field()
    company = Field()
    location = Field()
    education = Field()
    followees = Field()
    followers = Field()
    CATEGORY_CONVERTION = {u"个人成就":"achivement",u"职业经历":"company",u"居住信息":"location",u"教育经历":"education"}
    @classmethod
    def parse_category(cls,s):
        return cls.CATEGORY_CONVERTION[s] if s in cls.CATEGORY_CONVERTION else s
    
    def __init__(self):
        super(User,self).__init__()
        self['followees'] = []
        self['followers'] = []
        