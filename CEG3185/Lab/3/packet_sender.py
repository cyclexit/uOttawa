import argparse
import socket
import textwrap

import const

# python3 packet_sender.py -server 192.168.0.1 -payload "COLOMBIA 2 - MESSI 0"

def is_ipv4_addr(ip_addr):
    '''
        Argument:
        ip_addr: a string in the form "x.x.x.x" where 0<=x<=255

        Return:
        True if ip_addr is a valid IPv4 address.
        False otherwise.
    '''
    arr = ip_addr.split('.')
    if len(arr) != 4:
        return False
    try:
        for x in arr:
            if int(x) < 0 or int(x) > 255:
                return False
        return True
    except:
        return False

def ipv4_addr_to_bytearray(ip_addr):
    '''
        Argument:
        ip_addr: a string in the form "x.x.x.x" where 0<=x<=255

        Return:
        IP address in bytearray form
    '''
    return bytearray(bytes(map(int, ip_addr.split('.'))))

def get_ipv4_checksum(src_ip_hexstr, dst_ip_hexstr, ip_header_len):
    '''
        Argument:
        src_ip_hexstr: a hex string represent the source IP address
        dst_ip_hexstr: a hex string represent the destination IP address
        ip_header_len: a decimal value

        Return:
        IPv4 checksum in bytearray form
    '''
    # print(src_ip_hexstr) # test
    # print(dst_ip_hexstr) # test
    # print(ip_header_len) # test

    checksum = 0
    # add ip_header_len
    checksum += ip_header_len
    # add the data in const.py
    checksum += int(const.IPV4_FIXED_PART_1, 16)
    checksum += int(const.IPV4_FIXED_PART_2, 16)
    checksum += int(const.IPV4_FIXED_PART_3, 16)
    checksum += int(const.PACKET_ID, 16)
    # add src_ip
    src_ip_arr = textwrap.wrap(src_ip_hexstr, 4)
    # print(src_ip_arr) # test
    for x in src_ip_arr:
        checksum += int(x, 16)
    # add dst_ip
    dst_ip_arr = textwrap.wrap(dst_ip_hexstr, 4)
    # print(dst_ip_arr) # test
    for x in dst_ip_arr:
        checksum += int(x, 16)

    # covert the checksum to hex str
    checksum_hexstr = hex(checksum)[2:] # ignore 0x
    # print("checksum =", checksum_hexstr) # test
    # deal with the overflow
    if len(checksum_hexstr) > 4:
        checksum += int(checksum_hexstr[0])
        checksum_hexstr = hex(checksum)[3:] # ignore 0x and the overflow
    # 1s complement
    checksum_hexstr = hex(int(checksum_hexstr, 16) ^ 0xffff)[2:] # ignore 0x
    # print("checksum =", checksum_hexstr) # test
    return bytearray.fromhex(checksum_hexstr)

def get_ipv4_packet(src_ip, dst_ip, payload):
    '''
        Argument:
        src_ip: a string represent the source IP address
        dst_ip: a string represent the destination IP address
        payload: a string of data

        Return:
        IP packet in bytearray form
    '''
    # encode src_ip, dst_ip and payload
    payload_bytearray = bytearray(payload.encode("ascii"))
    src_ip_bytearray = ipv4_addr_to_bytearray(src_ip)
    dst_ip_bytearray = ipv4_addr_to_bytearray(dst_ip)
    
    # fixed part 1
    packet = bytearray.fromhex(const.IPV4_FIXED_PART_1)

    # total length of the header in bytes
    ip_header_len = 20 + len(payload_bytearray) # decimal
    packet += bytearray(ip_header_len.to_bytes(2, "big"))

    # fixed ID field
    packet += bytearray.fromhex(const.PACKET_ID)

    # fixed part 2
    packet += bytearray.fromhex(const.IPV4_FIXED_PART_2)

    # fixed part 3
    packet += bytearray.fromhex(const.IPV4_FIXED_PART_3)

    # calculate the checksum
    packet += get_ipv4_checksum(
        src_ip_bytearray.hex(),
        dst_ip_bytearray.hex(),
        ip_header_len
    )

    # source IP in bytes
    packet += src_ip_bytearray

    # destination IP in bytes
    packet += dst_ip_bytearray

    # payload
    packet += payload_bytearray

    # print(textwrap.wrap(packet.hex(), 4)) # test
    return packet


if __name__ == "__main__":
    # parse the args
    parser = argparse.ArgumentParser(description="Client to send IP packets")
    parser.add_argument("-server", required=True, help="Server IP address")
    parser.add_argument("-payload", required=True, help="Data of the IP packet")
    args = parser.parse_args()

    # get IP addresses
    src_ip = socket.gethostbyname(socket.gethostname())
    src_ip = "192.168.0.3" # test
    if is_ipv4_addr(args.server):
        dst_ip = args.server
    else:
        print("ERROR: Invalid IPv4 address")
        exit(1)

    # get IP packet
    data = get_ipv4_packet(src_ip, dst_ip, args.payload)

    # open the socket and connect to the server
    # client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # client_socket.connect((args.server, const.SERVER_PORT))

    # send the data
    # try:
        # pass
    # finally:
        # pass