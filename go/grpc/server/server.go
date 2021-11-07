package main

import (
	"context"
	"fmt"
	"log"
	"net"

	pb "grpc/pb"

	"google.golang.org/grpc"
)

// HelloService is gRPC service
type HelloService struct {
}

// Hello implements
func (s *HelloService) Hello(ctx context.Context, req *pb.HelloRequest) (*pb.HelloResponse, error) {
	msg := "Hello " + req.GetMsg()
	fmt.Printf("string={%s} \n", req.String())

	fmt.Printf("request={%s} \n", req)
	fmt.Printf("request={%s} \n", msg)

	return &pb.HelloResponse{
		Msg: msg,
	}, nil
}

func main() {
	con, err := net.Listen("tcp", ":10000")
	if err != nil {
		log.Println(err)
	}
	server := grpc.NewServer()

	helloService := &HelloService{}

	pb.RegisterHelloServer(server, helloService)
	server.Serve(con)
}

func serve() {

}
