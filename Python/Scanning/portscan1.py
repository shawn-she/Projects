#!/usr/bin/python

import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# AF_INET = IPv4 address; SOCK_STREAM = TCP Packets

host = "127.0.0.1"
port = 443

def portscanner(port):
	if sock.connect_ex((host, port)):		# connect_ex looks for any  error
		print("Port %d is closed" %(port))	# if error found: port is closed
	else:
		print("Port %d is open" %(port))

portscanner(port)