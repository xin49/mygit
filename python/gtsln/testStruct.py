# 'define class '
# '1. public member'
# '2. provate member'
# '3. function'
class TRange:
    begin=0
    end=0
    def __init__(self, begin, end):
        self.begin=begin
        self.end=end

class TTime:
    type=0
    range=TRange(0, 0)
    content=''
    def __init__(self, type, range):
        self.type=type
        self.range=range

class TTypeTime:
    type=0
    timeList=[]
    contentList=[]

    def __init__(self, type):
        self.type=type
        self.timeList=[]

class TEmployee:
    name=''
    id=0
    secureTimeLst=[]
    unCheckTimeLst=[]
    def __init__(self, name, id):
        self.name=name
        self.id=id