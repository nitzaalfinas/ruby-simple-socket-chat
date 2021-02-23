require "socket"

class Client
    def initialize(server)
        @server = server
        @request = nil
        @response = nil

        listen
        send
        @request.join
        @response.join
    end

    def send
        @request = Thread.new do
            loop { # write as much as you want
                # read from the console
                # with the enter key, send the message to the server

                msg = @server.gets.chomp
                puts "#{msg}"
            }
        end
    end

    def listen
        @response = Thread.new do
            loop { # listen for ever
                # listen the server responses
                # show them in the console

                msg = $stdin.gets.chomp
                @server.puts( msg )
            }
        end
    end
end

server = TCPSocket.open( "localhost", 3000 )
Client.new( server )
