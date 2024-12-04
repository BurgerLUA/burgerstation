/obj/item/trash
	name = "trash"
	desc = "Useless."
	desc_extended = "Wrappers, cigarette butts and any remains that have no use other than to be recycled. Dispose responsibly."
	icon = 'icons/obj/item/trash.dmi'
	icon_state = "candy"
	value = 0

	weight = 0.25

	rarity = RARITY_BROKEN

/obj/item/trash/random/Generate()
	. = ..()
	var/list/states = icon_states(icon)
	icon_state = pick(states)

/obj/item/trash/raisins
	icon_state = "raisins"
	value = 1

/obj/item/trash/candy
	icon_state = "candy"
	value = 1

/obj/item/trash/chips
	icon_state = "chips"
	value = 1

/obj/item/trash/cheese_chips
	icon_state = "cheese_chips"
	value = 1

/obj/item/trash/jerky
	icon_state = "jerky"
	value = 1

/obj/item/trash/syndicate
	icon_state = "syndicate"
	value = 1

/obj/item/trash/butt
	icon_state = "butt"
	value = 1