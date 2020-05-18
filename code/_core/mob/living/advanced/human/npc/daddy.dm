/mob/living/advanced/npc/daddy
	name = "\improper the legend"
	enable_AI = TRUE
	ai = /ai/advanced/daddy
	class = "daddy"


/mob/living/advanced/npc/daddy/setup_name()
	name = "\improper THE LEGEND (SL 99)"
	return TRUE

/mob/living/advanced/npc/daddy/Initialize()

	. = ..()

	equip_loadout("daddy")

	var/obj/item/weapon/melee/zweihander/W = new(src.loc)
	INITIALIZE(W)
	GENERATE(W)
	put_in_hands(W,FALSE)

	var/obj/item/weapon/melee/shield/S = new(src.loc)
	INITIALIZE(S)
	GENERATE(S)
	put_in_hands(S,TRUE)

	return .