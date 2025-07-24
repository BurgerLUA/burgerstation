/obj/item/weapon/ranged/reagent_ammo/
	var/reagent_volume_per_shot = 0 //reagents from reagent container to remove per-shot.
	quality_max = 175

/obj/item/weapon/ranged/reagent_ammo/get_ammo_count()

	if(reagent_volume_per_shot <= 0)
		return 0



	return FLOOR(reagents.volume_current/reagent_volume_per_shot,1)

/obj/item/weapon/ranged/reagent_ammo/handle_ammo(mob/activator)
	if(reagent_volume_per_shot <= 0)
		return null
	return reagents.remove_reagents(reagent_volume_per_shot,TRUE,FALSE,activator)

/obj/item/weapon/ranged/reagent_ammo/can_gun_shoot(mob/activator, atom/object, location, params, check_time, messages)

	if(!..())
		return FALSE

	if(get_ammo_count() <= 0)
		handle_empty(activator)
		return FALSE

	return TRUE
