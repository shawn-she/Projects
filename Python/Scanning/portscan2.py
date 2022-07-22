#!/usr/bin/python

import socket
from termcolor import colored

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# AF_INET = IPv4 address; SOCK_STREAM = TCP Packets
socket.setdefaulttimeout(2)				# time in seconds

host = input("[*] Enter the Host to Scan: ")		# takes string

def portscanner(port):
	if sock.connect_ex((host, port)):		# connect_ex looks for (any) error
		print(colored("[!!] Port %d is closed" %(port), 'red'))	# if error found: port is closed
	else:
		print(colored("[+] Port %d is open" %(port), 'green'))	# else: port is open

for port in range(1, 1001):
	portscanner(port)
