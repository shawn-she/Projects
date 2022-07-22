#!/usr/bin/python

import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# AF_INET = IPv4 address; SOCK_STREAM = TCP Packets
socket.setdefaulttimeout(2)				# time in seconds


host = input("[*] Enter the Host to Scan: ")		# takes string
port = int(input("[*] Enter the Port to Scan: "))	# takes integer

def portscanner(port):
	if sock.connect_ex((host, port)):		# connect_ex looks for (any) error
		print("Port %d is closed" %(port))	# if error found: port is closed
	else:
		print("Port %d is open" %(port))	# else: port is open

portscanner(port)
