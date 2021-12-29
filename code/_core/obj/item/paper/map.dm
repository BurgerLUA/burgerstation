/obj/item/map/
	name = "digital map"
	desc = "Hmmm."
	desc_extended = "A special electronic device that digitally shows a map of the current user's location."
	icon = 'icons/obj/item/map.dmi'
	icon_state = "inventory"
	value = 100

/obj/item/map/click_self(var/mob/caller)

	var/obj/hud/button/map/M = locate() in caller.buttons
	if(!M)
		M = new(caller)
		M.update_owner(caller)
		caller.to_chat(span("notice","You open the map."))

	return TRUE