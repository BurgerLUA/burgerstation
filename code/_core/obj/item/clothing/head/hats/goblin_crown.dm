/obj/item/clothing/head/hat/goblin_crown
	name = "Goblin King's crown"
	desc = "You monster, stealing from the little green men."
	desc_extended = "The crown is imbued with the life essence of the late Goblin King. Greatly desired by mages."
	icon = 'icons/obj/item/clothing/hats/goblin_crown.dmi'

	armor = /armor/gold

	size = SIZE_2

	value = 1000

	value_burgerbux = 1

	var/cooldown_effect = 0

/obj/item/clothing/head/hat/goblin_crown/post_move(atom/old_loc)
	. = ..()
	if(istype(loc, /obj/hud/inventory/organs/head))
		START_THINKING(src)
	else
		STOP_THINKING(src)

/obj/item/clothing/head/hat/goblin_crown/think()
	if(cooldown_effect > world.time)
		return TRUE
	cooldown_effect = world.time + SECONDS_TO_DECISECONDS(1)
	var/turf/T = get_turf(src)
	for(var/mob/living/affectLiving in T)
		if(affectLiving.dead)
			continue
		if(affectLiving.health.mana_current >= affectLiving.health.mana_max)
			continue
		affectLiving.mana_regen_buffer += 1
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
