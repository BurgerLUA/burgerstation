/obj/item/coin/
	name = "coin"
	desc = "Shiny!"
	desc_extended = "A special coin that does something special."
	icon = 'icons/obj/item/coin.dmi'
	icon_state = "coin"

	drop_sound = 'sound/items/drop/ring.ogg'

	weight = 0.05
	size = SIZE_0


/obj/item/coin/bronze
	name = "solarian bronze coin"
	value = 50
	icon_state = "coin2"
	color = COLOR_BRONZE
	rarity = RARITY_COMMON

/obj/item/coin/silver
	name = "solarian silver coin"
	value = 100
	icon_state = "coin3"
	color = COLOR_SILVER
	rarity = RARITY_UNCOMMON

/obj/item/coin/gold
	name = "solarian gold coin"
	value = 250
	icon_state = "coin4"
	color = COLOR_GOLD
	rarity = RARITY_RARE

/obj/item/coin/phoron
	name = "solarian phoron coin"
	value = 500
	icon_state = "coin5"
	color = COLOR_PHORON
	rarity = RARITY_RARE

/obj/item/coin/platinum
	name = "solarian platinum coin"
	value = 1000
	icon_state = "coin6"
	color = COLOR_PLATINUM
	rarity = RARITY_MYTHICAL

/obj/item/coin/diamond
	name = "solarian diamond coin"
	value = 2500
	icon_state = "coin7"
	color = COLOR_DIAMOND
	rarity = RARITY_MYTHICAL

/obj/item/coin/adamantium
	name = "solarian adamantium coin"
	value = 5000
	icon_state = "coin8"
	color = COLOR_ADAMANITUM_CARBON
	rarity = RARITY_LEGENDARY

/obj/item/coin/cursed
	name = "shady coin"
	desc = "Always pick tails."
	desc_extended = "An unnerving coin made of unknown material, crushing this coin feels like it can change your fate."
	icon_state = "coin5"
	value = 2000
	rarity = RARITY_UNCOMMON

/obj/item/coin/cursed/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!caller)
		return ..()

	var/mob/living/L = caller

	caller.to_chat(span("warning","You crush the coin in your hand, hoping for the best."))
	if(prob(50))
		caller.to_chat(span("notice","You feel okay."))
	else if(prob(50))
		L.add_attribute_xp(ATTRIBUTE_LUCK,1)
		caller.to_chat(span("notice","You feel luckier!"))
	else
		L.add_attribute_xp(ATTRIBUTE_LUCK, L.get_attribute_level(ATTRIBUTE_LUCK) - (L.get_attribute_level(ATTRIBUTE_LUCK) + 1))
		caller.to_chat(span("danger","You feel cursed..."))
	qdel(src)

	return TRUE

/obj/item/coin/antag_token
	name = "antag token"
	desc = "Valid or salid?"
	desc_extended = "Buying this and then crushing it in your hand will increase your number of OOC antag tokens by 1. Antag tokens can be redeemed while observing and pressing the \"Become Antagonist\" menu option at the start of the round. Note that slots are limited."
	icon_state = "antag_token_gold"
	value = 4000

	rarity = RARITY_RARE

/obj/item/coin/antag_token/click_self(var/mob/caller)

	if(!is_player(caller))
		return FALSE

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!caller.client)
		return TRUE //literally how

	var/savedata/client/globals/GD = GLOBALDATA(caller.client.ckey)

	if(!GD)
		caller.to_chat(span("warning","You don't know how to use this..."))
		return TRUE

	GD.loaded_data["antag_tokens"] += 1 //We don't save here because there might be an exploit where you don't save or something.
	caller.to_chat(span("warning","Your antag token count has increased by 1! It is now [GD.loaded_data["antag_tokens"]]."))
	qdel(src)

	return TRUE