/obj/item/coin/
	name = "coin"
	desc = "Shiny!"
	desc_extended = "A special coin that does something special."
	icon = 'icons/obj/item/coin.dmi'
	icon_state = "coin"

	drop_sound = 'sound/items/drop/ring.ogg'

	weight = 0.05

/obj/item/coin/antag_token
	name = "antag token"
	desc = "Valid or salid?"
	desc_extended = "Buying this and then crushing it in your hand will increase your number of OOC antag tokens by 1. Antag tokens can be redeemed while observing and pressing the \"Become Antagonist\" menu option at the start of the round. Note that slots are limited."
	icon_state = "antag_token_gold"
	value = 250
	value_burgerbux = 3

/obj/item/coin/antag_token/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!caller.client || !caller.client.globals)
		caller.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	caller.client.globals.loaded_data["antag_tokens"] += 1 //We don't save here because there might be an exploit where you don't save or something.
	caller.to_chat(span("warning","Your antag token count has increased by 1! It is now [caller.client.globals.loaded_data["antag_tokens"]]."))
	qdel(src)

	return TRUE