#!/usr/bin/python
from socket import *
import optparse
from threading import *
from termcolor import colored

def connScan(tgtHost, tgtPort):
    try:
        sock = socket(AF_INET, SOCK_STREAM)
        sock.connect((tgtHost, tgtPort))
        print(colored('[+] %d/tcp Open' %tgtPort, 'green'))
    except:
        print(colored('[-] %d/tcp Closed' %tgtPort, 'red'))
    finally:
        sock.close()

def portScan(tgtHost, tgtPorts):
    try:
        tgtIP = gethostbyname(tgtHost)
    except:
        print("Unknown host %s" %tgtHost)
    try:
        tgtName = gethostbyaddr(tgtIP)
        print('[+] Scan Results for: ' + tgtName[0])
    except:
        print('[+] Scan Results for: ' + tgtIP)
    setdefaulttimeout(1)
    for tgtPort in tgtPorts:
        t = Thread(target=connScan, args=(tgtHost, int(tgtPort)))
        t.start()

def main():
    parser = optparse.OptionParser('Usage of program: ' + '-H <target port> -p <target port>')
    parser.add_option('-H', dest='tgtHost', type='string', help='specify target host')
    parser.add_option('-p', dest='tgtPort', type='string', help='specify target ports separated by comma')
    (options, arg) = parser.parse_args()
    tgtHost = options.tgtHost
    tgtPorts = str(options.tgtPort).split(',')
    if((tgtHost == None) | (not tgtPorts) ):
        print(parser.usage)
        exit()
    portScan(tgtHost, tgtPorts)

if __name__ == '__main__':
    main()