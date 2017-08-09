#!/usr/bin/env python3
# coding=utf-8

import socket

def TcpSendDemo():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect(("192.168.10.113", 8080))
    s.send(b"1234567")
    s.close()

def UdpSendDemo():
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
    times = 0
    while True:
        print("times = ", times)
        data, addr = s.recvfrom(8081)
        if(data != ""):
            print('Got message from', addr, "data", data)
        times = times + 1

RecvDate()
