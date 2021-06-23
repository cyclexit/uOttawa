import socket
import textwrap

import const

def validate_ipv4_checksum(header_arr):
    '''
        Argument:
        header_arr: a list of data where each element is a hex string with length 4.

        Return:
        True if 1s complement of the sum of the data is 0.
        False otherwise.
    '''
    # print(header_arr) # test
    sum = 0
    for x in header_arr:
        sum += int(x, 16)
    sum_hexstr = hex(sum)[2:] # ignore 0x
    if len(sum_hexstr) > 4:
        sum += int(sum_hexstr[0], 16)
        sum_hexstr = hex(sum)[3:] # ignore 0x and the overflow
    # print(sum_hexstr) # test
    # 1s complement
    res = int(sum_hexstr, 16) ^ 0xffff
    # print(res) # test
    return (res == 0)

def get_ipv4_msg(msg_arr):
    '''
        Argument:
        msg_arr: a list of data where each element is a hex string with length 4.

        Return:
        A string decoded from msg_arr
    '''
    msg = ""
    for x in msg_arr:
        first_byte = x[0:2]
        if first_byte == "00":
            break
        msg += bytes(bytearray.fromhex(first_byte)).decode("ascii")
        second_byte = x[2:]
        if second_byte == "00":
            break
        msg += bytes(bytearray.fromhex(second_byte)).decode("ascii")
    return msg

if __name__ == "__main__":
    # bind the socket to listen
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(
        socket.SOL_SOCKET, socket.SO_REUSEADDR, 1
    )
    server_socket.bind(("", const.SERVER_PORT)) # all available interface
    server_socket.listen(1)
    # print(server_socket.getsockname()) # test

    # running until the keyboard interrupt
    try:
        while True:
            print("Wait for the connection...")
            conn, client_ip = server_socket.accept()
            # print(client_ip) # test
            
            # read the data
            data_bytearray = bytearray()
            with conn:
                conn.sendall("Data is received.".encode("ascii"))
                while True:
                    data = conn.recv(const.SOCKET_BUFFER_SIZE)
                    if data:
                        data_bytearray += bytearray(data)
                    else:
                        break
                # Question: Why can't the message be sent here?
            
            # check the length of the data
            data_arr = textwrap.wrap(data_bytearray.hex(), 4)
            if len(data_arr) < 10:
                print("ERROR: Incorrect data size. Discard the data.")
                continue
            # validate the checksum
            if not validate_ipv4_checksum(data_arr[0:10]): # first 20 bytes
                print("The verification of the checksum demonstrates that the packet received is corrupted. Packet discarded!")
            else:
                # decode the data
                msg = get_ipv4_msg(data_arr[10:])
                # print(len(msg)) # test
                # first print
                print("The data received from {} is {}".format(
                    client_ip[0], msg
                ))
                # second print
                print(
                    "The data has {} bits or {} bytes.".format(
                        len(msg) * 8, len(msg)
                    ),
                    "Total length of the packet is {} bytes.".format(
                        len(data_bytearray)
                    )
                )
                # third print
                print("The verification of the checksum demonstrates that the packet received is correct.")
    except KeyboardInterrupt:
        server_socket.close()
        print("Bye~")
