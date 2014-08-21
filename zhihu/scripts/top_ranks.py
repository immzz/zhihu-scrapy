rank = []
f = open('/Volumes/TOSHIBA EXT/Crawls/rank.dat')
for line in f:
    line = line.rstrip('\n')
    row = line.split(' ')
    rank.append((int(row[0]),float(row[1])))

f.close()

rank.sort(key=lambda tup: tup[1],reverse=True) 

f = open('/Volumes/TOSHIBA EXT/Crawls/sorted_rank.dat','wb')
for row in rank:
    f.write(str(row[0])+' '+str(row[1])+'\n')

f.close()

index_user = []
f = open('/Users/apple/Documents/Crawls/zhihu/graph.label')
for line in f:
    line = line.rstrip('\n')
    row = line.split(' ')
    index_user.append(row[1])

f.close()
