import os
import datetime
import shutil
import sys
import signal

def Get_ProcessMem_Cmd(argProcId):
    cmd1 = "cat /proc/"
    cmd2 = "/status | grep VmRSS"
    return cmd1 + argProcId + cmd2
    
if __name__ == '__main__':
    argLst = sys.argv
    print(argLst)
    cmd = Get_ProcessMem_Cmd(argLst[1])
    count = 0
    strOld = ""
    strNow = ""
    while True:
        try:
            strNow = os.popen(cmd).readlines()
            if(strNow != strOld):
                strOld = strNow
                print(strOld)
            count = count + 1
        except KeyboardInterrupt:
            input("")
            #sys.exit()
