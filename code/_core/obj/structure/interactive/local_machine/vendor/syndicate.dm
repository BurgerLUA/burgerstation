/obj/structure/interactive/vending/syndicate
	name = "syndicate vendor"
	icon_state = "syndi"

/obj/structure/interactive/vending/syndicate/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	if(SSgamemode.active_gamemode.state < GAMEMODE_GEARING)
		P.to_chat(span("notice","It's too <b>early</b> to purchase this! Wait a bit and coordinate with your team!"))
		return FALSE

	if(SSgamemode.active_gamemode.state >= GAMEMODE_LAUNCHING)
		P.to_chat(span("notice","It's too late to purchase this!"))
		return FALSE

	return ..()

var/global/list/equipped_antags = list()

/obj/structure/interactive/vending/syndicate/limited
	name = "timed syndicate vendor"
	desc = "You better buy shit, and fast!"
	desc_extended = "A timed syndicate vendor that is set to destroy all their internal contents when NanoTrasen personel land on the ship. You better grab a loadout, and fast!"
	is_free = TRUE
	stored_types = list(
		/obj/item/clothing/back/storage/dufflebag/syndicate/normie,
		/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/fuck_you,
		/obj/item/clothing/back/storage/dufflebag/syndicate/medical/field_doctor,
		/obj/item/clothing/back/storage/dufflebag/syndicate/ammo/anti_tank
	)

	is_free = TRUE
	free_text = "choose"

/obj/structure/interactive/vending/syndicate/limited/can_purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && (P in equipped_antags))
		P.to_chat(span("notice","You already selected your equipment!"))
		return FALSE
	return .

/obj/structure/interactive/vending/syndicate/limited/purchase_item(var/mob/living/advanced/player/P,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)
	. = ..()
	if(. && P && !(P in equipped_antags))
		equipped_antags += P
	return .