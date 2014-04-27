# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy.item import Item, Field

class User(Item):
    # define the fields for your item here like:
    # name = Field()
    name = Field()
    achivement = Field()
    company = Field()
    location = Field()
    edu = Field()
    
