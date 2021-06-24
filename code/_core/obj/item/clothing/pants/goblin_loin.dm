/obj/item/clothing/pants/goblin_loin
	name = "Goblin King's loin"
	desc = "You monster, stealing from the little green men."
	desc_extended = "The loin is imbued with the life essence of the late Goblin King. Greatly desired by mages."
	icon = 'icons/obj/item/clothing/pants/goblin_loin.dmi'

	defense_rating = list(
		ARCANE = 80,
		HOLY = -80,
		DARK = 80
	)

	rarity = RARITY_LEGENDARY

	size = SIZE_2

	value = 1000

	var/cooldown_effect = 0

/obj/item/clothing/pants/goblin_loin/post_move(atom/old_loc)
	. = ..()
	if(istype(loc, /obj/hud/inventory/organs/groin))
		start_thinking(src)
	else
		stop_thinking(src)

/obj/item/clothing/pants/goblin_loin/think()
	if(cooldown_effect > world.time)
		return TRUE
	cooldown_effect = world.time + SECONDS_TO_DECISECONDS(1)
	var/turf/T = get_turf(src)
	for(var/mob/living/affectLiving in T)
		if(affectLiving.dead)
			continue
		if(affectLiving.health.get_mana_loss())
			affectLiving.mana_regen_buffer += 3
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
