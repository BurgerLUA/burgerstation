/obj/item/cross
	name = "wooden cross"
	desc = "SPIRITS BE GONE."
	desc_extended = "A special wooden cross that inhibits evil things."
	icon = 'icons/obj/item/cross.dmi'
	icon_state = "inventory"

/obj/item/cross/Cross(var/atom/movable/O)

	if(O.health)
		var/list/defense = O.health.get_defense()
		if(defense[HOLY] - defense[DARK] < 0)
			return FALSE

	return ..()