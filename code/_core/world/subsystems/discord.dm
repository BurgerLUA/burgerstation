//tfw byond doesn't support POST requests


#define WEBHOOK_FILE "data/server/discord_api.txt"

SUBSYSTEM_DEF(discord)
	name = "Discord API"
	desc = "Handles the discord API."
	priority = SS_ORDER_PRELOAD

	var/private_webhook

/subsystem/recipe/Initialize()


	if(!fexists(WEBHOOK_FILE))
		log_subsystem(name,"Could not find a webhook file in [WEBHOOK_FILE].")
		return TRUE

	private_webhook = file2text(WEBHOOK_FILE)
	log_subsystem(name,"Sucessfully Loaded Discord Webhook!")

	var/list/result = Export("[private_webhook]/channels/693563558155255900/webhooks?name",null)

	print_list(result)

	return TRUE
