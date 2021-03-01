/obj/structure/interactive/crate/chest
	name = "treasure chest"
	icon_state = "chest"

/obj/structure/interactive/crate/chest/filled
	loot = /loot/player_currency
	var/chance_none = 75


/obj/structure/interactive/crate/chest/filled/Generate()
	. = ..()
	if(prob(chance_none))
		qdel(src)