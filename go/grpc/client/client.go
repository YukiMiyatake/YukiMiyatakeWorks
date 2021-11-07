package main

import (
	"context"
	"fmt"
	"log"

	pb "grpc/pb"

	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("127.0.0.1:10000", grpc.WithInsecure())
	if err != nil {
		log.Fatal("client connection error:", err)
	}
	defer conn.Close()
	client := pb.NewHelloClient(conn)

	fmt.Printf(sayHello(client, "World!"))
}

func sayHello(client pb.HelloClient, msg string) string {
	res, _ := client.Hello(context.TODO(), &pb.HelloRequest{Msg: msg})
	return res.GetMsg()
}
