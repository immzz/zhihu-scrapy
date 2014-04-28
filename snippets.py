//*[@id="zh-load-more"]

ex = r'"http://www\.zhihu\.com/people/([^"|^\\]+)\\"'
ex = r'((?!").)+'
$.post( "/node/ProfileFolloweesListV2",{method:"next",_xsrf:"9665b9cfdb32488383aaffa5d7a8e23c",params: {"hash_id": "f5cb85b181cf109d2d9c1680de8f3243", "order_by": "created", "offset": 0}},function(data) {alert("page content:" + data);});

script_content = str(driver.find_element_by_css_selector('.zh-general-list.clearfix').get_attribute('data-init'))
_xsrf = str(driver.find_element_by_name('_xsrf').get_attribute('value'))
post_data = ast.literal_eval(script_content)
post_data['_xsrf'] = _xsrf
post_data['method'] = 'next'
del post_data['nodename']
driver.execute_script("if($('#temp-store').length == 0) $('body').append('<input type=\"hidden\" id=\"temp-store\">'); else $('#temp-store').html('');$.post( '/node/ProfileFolloweesListV2',%s,function(data) {$('#temp-store').val(JSON.stringify(data));});" % post_data.__str__())

AJAX_CHECK_INTERVAL = 0.1
AJAX_TIMEOUT = 5

def block_ajax_load(url,method,params):
    driver.execute_script("if($('#temp-store').length == 0) $('body').append('<input type=\"hidden\" id=\"temp-store\">'); else $('#temp-store').val('');");
    driver.execute_script("$.%s( '%s',%s,function(data) {$('#temp-store').val((data === undefined)?'undefined':((data=='')?'empty':JSON.stringify(data)));});" % (method,url,params.__str__()))
    start_time = time.time()
    while True:
        res =  driver.execute_script('return $("#temp-store").val()')
        if res == "":
            time.sleep(AJAX_CHECK_INTERVAL)
        elif res == "undefined":
            return None
        elif res == "empty":
            return ""
        else:
            print time.time()-start_time
            return res
        if time.time() - start_time > AJAX_TIMEOUT:
            return None

t = block_ajax_load("/node/ProfileFolloweesListV2","post",post_data)

$.post("/node/MemberFollowBaseV2",{method:c?"follow_member":"unfollow_member",params:{hash_id:b}


init_list = 


POST /node/ProfileFolloweesListV2 HTTP/1.1
Host: m.zhihu.com
Connection: keep-alive
Content-Length: 221
Accept: */*
Origin: http://m.zhihu.com
X-Requested-With: XMLHttpRequest
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1951.5 Safari/537.36
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
Referer: http://m.zhihu.com/people/magie/followees
Accept-Encoding: gzip,deflate,sdch
Accept-Language: zh-CN,zh;q=0.8
Cookie: q_c1=dd9cd62b41e8486faed1355e7023f3ed|1398571264000|1398571264000; c_c=8dbdd192cdc011e388d552540a3121f7; q_c0="NWI5MThjNGM4MmZjM2EzMTI1MDMwNTIxM2FmZmVkMmZ8aVBTMXNueHg1MjR4dGJUMg==|1398571271|7d2dab2db1903f6d3949d820354938d194c6f325"; _xsrf=9665b9cfdb32488383aaffa5d7a8e23c; __utma=99241410.2012288519.1398579597.1398579597.1398579597.1; __utmb=99241410.1.10.1398579597; __utmc=99241410; __utmz=99241410.1398579597.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utma=51854390.1381687638.1398571258.1398571258.1398577204.2; __utmb=51854390.12.10.1398577204; __utmc=51854390; __utmz=51854390.1398571258.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmv=51854390.110-2|2=registration_date=20120510=1^3=entry_date=20120510=1

ssh -i crawlers.pem ubuntu@54.187.128.27

