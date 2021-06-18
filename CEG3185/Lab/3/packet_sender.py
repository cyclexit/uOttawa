import argparse
import socket

import const

# python3 packet_sender.py -server 192.168.0.1 -payload "COLOMBIA 2 - MESSI 0"

def get_ip_packet(src_ip, dst_ip, payload):
    # encode the payload to get bytes
    payload_bytearray = bytearray(payload.encode("ascii"))
    
    # fixed part
    res = bytearray.fromhex("4500")

    # total length of bytes
    ip_header_len = 20 + len(payload_bytearray)
    # print(ip_header_len) # test
    res += bytearray(ip_header_len.to_bytes(2, "big"))

    print(res.hex()) # test
    return res


if __name__ == "__main__":
    # parse the args
    parser = argparse.ArgumentParser(description="Client to send IP packets")
    parser.add_argument("-server", required=True, help="Server IP address")
    parser.add_argument("-payload", required=True, help="Data of the IP packet")
    args = parser.parse_args()

    # get IP addresses
    src_ip = socket.gethostbyname(socket.gethostname())
    dst_ip = args.server

    # get IP packet
    data = get_ip_packet(src_ip, dst_ip, args.payload)

    # open the socket and connect to the server
    # client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # client_socket.connect((args.server, const.SERVER_PORT))

    # send the data
    # try:
        # pass
    # finally:
        # pass