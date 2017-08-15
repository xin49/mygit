#!/usr/bin/env python3
# coding=utf-8

import socket

def TcpSendDemo():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("192.168.10.113", 8080))
    s.send(b"1234567")
    s.close()

def UdpSendDemo():
    print("UdpSendDemo")
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.sendto(b"1234567", ("192.168.10.113", 8080))
    s.close()

def Rollcall():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.sendto(b"call", ("", 8080))
    s.close()

def RecvDate():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.bind(("", 52221))
    time = 0
    while True:
        print("time = ", time)
        data, addr = s.recvfrom(8081)
        if(data != ""):
            print('Got message from', addr, "data", data)
        time = time + 1

def SignIn():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.sendto(b"Online", ("", 8080))
    s.close()
'''
obj: server, client 
    server status:
        1 signin list
    client status:
        1 signin
        2 busy
        3 offline
        4 signout
    server rollcall and get client status(signin, busy, offline)
    client respond server rollcall and send change status
'''

# server
import threading
import time
import sys

def DecodeData(argData):
    print("DecodeData in")
    print("DecodeData out")

def ServerRollcall(argServer=socket.socket(socket.AF_INET, socket.SOCK_DGRAM), argPort=("", 52221), argCont="", argCloseFlg=True):
    print("ServerRollcall in")
    times = 1
    while True:
        print("times:", times)
        argServer.sendto(argCont.encode(), argPort)
        time.sleep(0.5)
        times = times + 1
    if(argCloseFlg):
        argServer.close
    print("ServerRollcall out")

def ServerReciveClientStatus(argServer=socket.socket(socket.AF_INET, socket.SOCK_DGRAM), argPort=("", 52222), argMesLen=1024):
    print("ServerReciveClientStatus in")
    time = 1
    argServer.bind(argPort)
    while True:
        data, addr = argServer.recvfrom(argMesLen)
        print("time:", time)
        if(data != ""):
            print('Got message from', addr, "data", data)
            DecodeData(data)
        time = time + 1
    argServer.close
    print("ServerReciveClientStatus out")

class TThreadServerReciveClientStatus(threading.Thread):
    def __init__(self, threadID, name):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
    def run(self):
        print ("TThreadServerReciveClientStatus.run() in")
        ServerReciveClientStatus()
        print ("TThreadServerReciveClientStatus.run() out")

class TThreadServerRollcall(threading.Thread):
    def __init__(self, threadID, name):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
    def run(self):
        print ("TThreadServerRollcall.run() in")
        ServerRollcall(argCont="rollcall")
        print ("TThreadServerRollcall.run() out")

# client
import random

def ClientGetStatus():
    print("ClientReplyStatus in")
    status = random.randint(0, 1)
    if(status == 0):
        return "signin"
    else:
        return "busy"
    print("ClientReplyStatus out")

def ClientReplyStatus(argServer=socket.socket(socket.AF_INET, socket.SOCK_DGRAM), argPort=("", 52222), argCont="", argCloseFlg=True):
    print("ClientReplyStatus in")
    argServer.sendto(argCont.encode(), argPort)
    if(argCloseFlg):
        argServer.close
    print("ClientReplyStatus out")

def ClientReciveRollcall(argServer=socket.socket(socket.AF_INET, socket.SOCK_DGRAM), argPort=("", 52221), argMesLen=1024):
    print("ClientReciveRollcall in")
    time = 1
    argServer.bind(argPort)
    while True:
        data, addr = argServer.recvfrom(argMesLen)
        print("time:", time)
        print('Got message from', addr, "data", data)
        if(data.decode() == "rollcall"):
            ClientReplyStatus(argCont=ClientGetStatus())
        time = time + 1
    argServer.close
    print("ClientReciveRollcall out")

class TThreadClientReciveRollcall(threading.Thread):
    def __init__(self, threadID, name):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.name = name
    def run(self):
        print ("TThreadClientReciveRollcall.run() in")
        ClientReciveRollcall()
        print ("TThreadClientReciveRollcall.run() out")

threadClientReciveRollcall = TThreadClientReciveRollcall(1, "threadClientReciveRollcall")
try:
    threadClientReciveRollcall.start()
except KeyboardInterrupt:
    input("")
threadClientReciveRollcall.join()
