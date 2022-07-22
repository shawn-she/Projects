import java.util.*;
// import java.util.Date;
import java.io.*;
// import java.io.IOException;
// import java.io.BufferedReader;
// import java.io.InputStreamReader;
import java.net.*;
// import java.net.ServerSocket;
// import java.net.Socket;
// import java.net.clientSocket;

public class SimpleHTTPServer{
    public static void main(String[] args) throws Exception {
        final ServerSocket server = new ServerSocket(8080);
        System.out.println("Listening for connection on port 8080 ...");
        // input
        // while(true){
        //     final Socket client = server.accept();
        //     BufferedReader br = new BufferedReader(new InputStreamReader(client.getInputStream()));
        //     String line = br.readLine();
        //     while(!line.isEmpty()){
        //         System.out.println(line);
        //         line = br.readLine();
        //     }
        // }

        // output
        while(true){
            try (Socket client = server.accept() ){
                Date today = new Date();
                String HTTPResponse = "HTTP/1.1 200 OK\r\n\r\n" + today;
                client.getOutputStream().write(HTTPResponse.getBytes("UTF-8"));
            }
        }
    }

}