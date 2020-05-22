package main

import (
	"context"
	pb "grpc/pb"
	"testing"

	"github.com/golang/mock/gomock"

	mock_Hello "grpc/mock_hello"
)

func Test_main(t *testing.T) {
	tests := []struct {
		name string
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			main()
		})
	}
}

func Test_sayHello(t *testing.T) {
	type args struct {
		msg string
	}
	tests := []struct {
		name string
		args args
		want string
	}{
		{
			name: "ok",
			args: args{msg: "World!"},
			want: "Hello World!",
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			ctrl := gomock.NewController(t)
			defer ctrl.Finish()

			m := mock_Hello.NewMockHelloClient(ctrl)

			m.
				EXPECT().
				Hello(context.TODO(), &pb.HelloRequest{Msg: "World!"}).
				Return(&pb.HelloResponse{Msg: "Hello World!"}, nil)

			if got := sayHello(m, tt.args.msg); got != tt.want {
				t.Errorf("sayHello() = %v, want %v", got, tt.want)
			}
		})
	}
}
