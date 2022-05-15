/obj/item/clothing/neck/goblin_necklace
	name = "Goblin King's necklace"
	icon = 'icons/obj/item/clothing/neck/goblin_necklace.dmi'
	desc = "You monster, stealing from the little green men."
	desc_extended = "The loin is imbued with the life essence of the late Goblin King. Greatly desired by mages."
	worn_layer = LAYER_MOB_CLOTHING_BELT

	item_slot = SLOT_NECK

	protected_limbs = list(BODY_TORSO)

	armor = /armor/cloth

	size = SIZE_1

	value = 1000

	var/cooldown_effect = 0

	item_slot_layer = 1

/obj/item/clothing/neck/goblin_necklace/post_move(atom/old_loc)
	. = ..()
	if(istype(loc, /obj/hud/inventory/organs/neck))
		START_THINKING(src)
	else
		STOP_THINKING(src)

/obj/item/clothing/neck/goblin_necklace/think()
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
