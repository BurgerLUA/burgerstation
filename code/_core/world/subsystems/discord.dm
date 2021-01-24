//tfw byond doesn't support POST requests


#define WEBHOOK_FILE "data/server/discord_api.txt"

SUBSYSTEM_DEF(discord)
	name = "Discord API"
	desc = "Handles the discord API."
	priority = SS_ORDER_PRELOAD

	var/discord_webhook_key

/subsystem/discord/Initialize()

	if(!fexists(WEBHOOK_FILE))
		log_subsystem(name,"Could not find a webhook file in [WEBHOOK_FILE].")
		return TRUE

	discord_webhook_key = file2text(WEBHOOK_FILE)

	return TRUE

/subsystem/discord/proc/send_message(var/message_to_send)

	if(world.port == 0) //Don't send to local servers.
		return FALSE

	var/list/webhook_forum_params = list(
		"content" = message_to_send
	)

	var/list/webhook_header_params = list(
		"Content-Type" = "application/json"
	)

	rustg_http_request_blocking(RUSTG_HTTP_METHOD_POST,"https://discordapp.com/api/webhooks/[discord_webhook_key]",json_encode(webhook_forum_params),json_encode(webhook_header_params))

	return TRUE
