import socket

import const

if __name__ == "__main__":
    # bind the socket to listen
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(
        socket.SOL_SOCKET, socket.SO_REUSEADDR, 1
    )
    server_socket.bind(("", const.SERVER_PORT)) # all available interface
    server_socket.listen(1)
    print(server_socket.getsockname()) # test

    # running until the keyboard interrupt
    try:
        while True:
            print("Wait for the connection...")
            conn, client_ip = server_socket.accept()
            print(client_ip) # test
            
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
            
            # decode the data


            # first print
            print("The data received from {} is {}".format(
                client_ip[0], "" # TODO: decode the packet
            ))
            # second print
            print(
                "The data has {} bits or {} bytes.".format(
                    0, 0 # TODO: decode the packet
                ),
                "Total length of the packet is {} bytes.".format(
                    len(data_bytearray)
                )
            )
            # third print
    except KeyboardInterrupt:
        server_socket.close()
        print("Bye~")
