/obj/structure/interactive/vending/rev
	name = "revolutionary vendor"
	icon_state = "sovietsoda"

/obj/structure/interactive/vending/rev/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(!istype(P,/mob/living/advanced/player/antagonist/revolutionary))
		P.to_chat(span("notice","\The [src.name] doesn't seem to respect your IFF tag!"))
		return FALSE

	if(SSgamemode.active_gamemode.state < GAMEMODE_GEARING)
		P.to_chat(span("notice","It's too <b>early</b> to purchase this! Wait a bit and coordinate with your team!"))
		return FALSE

	if(SSgamemode.active_gamemode.state >= GAMEMODE_LAUNCHING)
		P.to_chat(span("notice","It's too late to purchase this!"))
		return FALSE

	return ..()

/obj/structure/interactive/vending/rev/limited
	name = "timed revolutionary vendor"
	desc = "You better buy shit, and fast!"
	desc_extended = "A timed syndicate vendor that is set to destroy all their internal contents when NanoTrasen personel land on the ship. You better grab a loadout, and fast!"
	is_free = TRUE
	stored_types = list(
		/obj/item/clothing/back/storage/backpack/explorer/rev,
		/obj/item/clothing/back/storage/backpack/explorer/medical,
		/obj/item/clothing/back/storage/backpack/explorer/sniper
	)

	is_free = TRUE
	free_text = "choose"

/obj/structure/interactive/vending/rev/limited/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && (P in equipped_antags))
		P.to_chat(span("notice","You already selected your equipment!"))
		return FALSE
	return .

/obj/structure/interactive/vending/rev/limited/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && !(P in equipped_antags))
		equipped_antags += P
	return .