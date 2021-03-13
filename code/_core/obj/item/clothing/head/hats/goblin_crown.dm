/obj/item/clothing/head/hat/goblin_crown
	name = "Goblin King's crown"
	desc = "You monster, stealing from the little green men."
	desc_extended = "The crown is imbued with the life essence of the late Goblin King. Greatly desired by mages."
	icon = 'icons/obj/item/clothing/hats/goblin_crown.dmi'
	rarity = RARITY_LEGENDARY

	defense_rating = list(
		ARCANE = AP_GREATSWORD,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD
	)

	size = SIZE_2

	value = 1000

	var/cooldown_effect = 0

/obj/item/clothing/head/hat/goblin_crown/Finalize()
	. = ..()
	start_thinking(src)

/obj/item/clothing/head/hat/goblin_crown/think()
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
