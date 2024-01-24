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

	rarity = RARITY_LEGENDARY


/obj/item/clothing/head/hat/goblin_crown/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn)
		START_THINKING(src)

/obj/item/clothing/head/hat/goblin_crown/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	STOP_THINKING(src)

/obj/item/clothing/head/hat/goblin_crown/think()
	if(cooldown_effect > world.time)
		return TRUE
	cooldown_effect = world.time + 1 SECONDS
	var/turf/T = get_turf(src)
	for(var/mob/living/affectLiving in T)
		if(affectLiving.dead)
			continue
		if(affectLiving.health.mana_current >= affectLiving.health.mana_max)
			continue
		affectLiving.mana_regen_buffer += 1
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
