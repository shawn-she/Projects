#!/usr/bin/python

import socket
from termcolor import colored

def retBanner(ip, port):
    try:
        socket.setdefaulttimeout(2)
        s = socket.socket()
        s.connect((ip, port))
        banner = s.recv(1024)
        return banner
    except:
        return

def main():
    ip = input("[*] Enter Target IP: ")
    for i in range(1, 101):
        banner = retBanner(ip, i)
        if(banner):
            print(colored("[+] %s: %s" %(ip, banner) , "green"))
            # print(colored("[+] %s: "+ ip + ":", i, banner), "green"))
        else:
            print(colored("[+] %s: %d" %(ip,i) , "green"))

if __name__ == '__main__':
    main()