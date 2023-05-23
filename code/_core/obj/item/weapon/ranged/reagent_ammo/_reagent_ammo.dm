/obj/item/weapon/ranged/reagent_ammo/
	var/reagent_volume_per_shot = 0 //reagents from reagent container to remove per-shot.

/obj/item/weapon/ranged/reagent_ammo/get_ammo_count()

	if(reagent_volume_per_shot <= 0)
		return 0



	return FLOOR(reagents.volume_current/reagent_volume_per_shot,1)

/obj/item/weapon/ranged/reagent_ammo/handle_ammo(mob/caller)
	if(reagent_volume_per_shot <= 0)
		return null
	return reagents.remove_reagents(reagent_volume_per_shot,TRUE,FALSE,caller)

/obj/item/weapon/ranged/reagent_ammo/can_gun_shoot(mob/caller, atom/object, location, params, check_time, messages)

	if(!..())
		return FALSE

	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE

	return TRUE
