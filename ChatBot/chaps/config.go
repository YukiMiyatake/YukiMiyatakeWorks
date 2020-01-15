package main

type slackConfig struct {
	Port              string `envconfig:"PORT" default: "3000"`
	BotToken          string `envconfig:"BOT_TOKEN" required: "true"`
	VerificationToken string `envconfig:"VERIFICATION_TOKEN" required: "true"`
	BotID             string `envconfig:"BOT_ID" require: "true"`
	ChannelID         string `envconfig:"CHANNEL_ID" require: "true"`
}
