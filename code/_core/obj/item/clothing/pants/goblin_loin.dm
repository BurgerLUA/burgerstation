/obj/item/clothing/pants/goblin_loin
	name = "Goblin King's loin"
	desc = "You monster, stealing from the little green men."
	desc_extended = "The loin is imbued with the life essence of the late Goblin King. Greatly desired by mages."
	icon = 'icons/obj/item/clothing/pants/goblin_loin.dmi'

	armor = /armor/cloth

	size = SIZE_2

	value = 1000

	var/cooldown_effect = 0

	value_burgerbux = 1

	rarity = RARITY_LEGENDARY

/obj/item/clothing/pants/goblin_loin/on_equip(atom/old_location,silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn)
		START_THINKING(src)

/obj/item/clothing/pants/goblin_loin/on_unequip(obj/hud/inventory/old_inventory,silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	STOP_THINKING(src)

/obj/item/clothing/pants/goblin_loin/think()
	if(cooldown_effect > world.time)
		return TRUE
	cooldown_effect = world.time + 1 SECONDS
	var/turf/T = get_turf(src)
	for(var/mob/living/affectLiving in T)
		if(affectLiving.dead)
			continue
		if(affectLiving.health.mana_current >= affectLiving.health.mana_max)
			continue
		affectLiving.mana_regen_buffer += 3
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
