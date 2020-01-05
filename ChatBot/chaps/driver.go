/*
  テスト用のコマンドラインドライバー
*/
package main

import (
	"log"
	"net/http"
	"os"
	//	"plugins/echo"
	"plugin"
	//  "echo"

	"github.com/kelseyhightower/envconfig"
	"github.com/nlopes/slack"
)


func main() {
	os.Exit( driver_main(os.Args[1:]))
}

func driver_main(args []string) int {
	var env slackConfig
	if err := envconfig.Process("", &env); err != nil {
		log.Printf("[Error] Failed to process env var: %s", err)
		return 1
	}

	log.Printf("[Info] Start slack event listening ")
	client := slack.New(env.BotToken)

	//client.SetDebug(true)
	var allmsg = map[string]plugin.Symbol{}
	var mention = map[string]plugin.Symbol{}

	loadPlugin(&mention, "memo", "plugins/memo/memo.so")
	loadPlugin(&mention, "echo", "plugins/echo/echo.so")
	//	loadPlugin(&mention, "aws", "plugins/aws/aws.so")
	//	loadPlugin(&mention, "sqs", "plugins/sqs/sqs.so")
	//loadPlugin(&mention, "ecr", "plugins/ecr/ecr.so")
	//loadPlugin(&mention, "ecs", "plugins/ecs/ecs.so")

	slackListener := &SlackListener{
		client:    client,
		botID:     env.BotID,
		channelID: env.ChannelID,
		allmsg:    allmsg,
		mention:   mention,
	}

	go slackListener.ListenAndResponse()

	http.Handle("/interaction", interactionHandler{
		verificationToken: env.VerificationToken,
	})

	log.Printf("[Info] Server listening on: %s", env.Port)
	if err := http.ListenAndServe(":"+env.Port, nil); err != nil {
		log.Printf("[Error] %s", err)
		return 1
	}

	return 0
}
