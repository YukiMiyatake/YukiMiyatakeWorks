package main

import (
	"context"
	"fmt"
	pb "grpc/pb"
	"log"

	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial("127.0.0.1:10000", grpc.WithInsecure())
	if err != nil {
		log.Fatal("client connection error:", err)
	}
	defer conn.Close()
	client := pb.NewHelloClient(conn)
	msg := &pb.HelloRequest{Msg: "World!"}
	res, err := client.Hello(context.TODO(), msg)
	fmt.Printf("response={%s} \n", res)
}
