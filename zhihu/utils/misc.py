def image_from_string(s):
    import cStringIO
    from PIL import Image
    file = cStringIO.StringIO(s)
    im = Image.open(file)
    return im
    
def get_external_ip():
    import urllib
    return urllib.urlopen('http://myexternalip.com/raw').read().rstrip('\n')
    
