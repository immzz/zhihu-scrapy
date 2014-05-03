def image_from_string(s):
    import cStringIO
    from PIL import Image
    file = cStringIO.StringIO(s)
    im = Image.open(file)
    return im
    
def get_external_ip():
    import urllib
    from zhihu.settings import PUBLIC_IP
    if PUBLIC_IP and PUBLIC_IP != '':
        return PUBLIC_IP
    return urllib.urlopen('http://myexternalip.com/raw').read().rstrip('\n')
    
def get_mac_address():
	import uuid
	node = uuid.getnode()
	mac = uuid.UUID(int = node).hex[-12:]
	return mac