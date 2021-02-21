/mob/living/advanced/npc/deus_vault
	name = "crusader"
	starting_factions = list(
		FACTION_PLAYER_HOSTILE
	)
	ai = /ai/advanced
	class = "crusader"

/mob/living/advanced/npc/deus_vault/Initialize()

	. = ..()

	var/list/possible_weapons = list(
		/obj/item/weapon/melee/sword/claymore,
		/obj/item/weapon/melee/sword/claymore,
		/obj/item/weapon/melee/sword/claymore,
		/obj/item/weapon/ranged/bullet/crossbow
	)

	var/picked_weapon = pick(possible_weapons)

	var/obj/item/weapon/W = new picked_weapon(src.loc)
	pickup(W)

	if(W.type == /obj/item/weapon/ranged/bullet/crossbow)
		var/obj/item/bullet/bolt/B = new(src.loc)
		B.on_spawn()
		B.update_icon()
		pickup(B)

	