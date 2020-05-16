package server

import (
	"context"
	"log"
	"net"

	pb "grpc/pb"

	"google.golang.org/grpc"
)

type HelloService struct {
}

func (s *HelloService) Hello(ctx context.Context, req *pb.HelloRequest) (*pb.HelloResponse, error) {
	return &pb.HelloResponse{
		Msg: "Hello " + req.Msg,
	}, nil
}

func main() {
	listenPort, err := net.Listen("tcp", ":10000")
	if err != nil {
		log.Fatalln(err)
	}
	server := grpc.NewServer()
	helloService := &HelloService{}

	pb.RegisterHelloServer(server, helloService)
	server.Serve(listenPort)
}
