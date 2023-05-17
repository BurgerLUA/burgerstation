/obj/item/weapon/ranged/reagent_ammo/
	var/fuel_per_shot = 0 //reagents from reagent container to remove per-shot.

/obj/item/weapon/ranged/reagent_ammo/get_ammo_count()
	return FLOOR((reagents.volume_current/fuel_per_shot),REAGENT_ROUNDING)

/obj/item/weapon/ranged/reagent_ammo/handle_ammo(mob/caller)
	return reagents.remove_reagents(fuel_per_shot,TRUE,FALSE,caller)

/obj/item/weapon/ranged/reagent_ammo/can_gun_shoot(mob/caller, atom/object, location, params, check_time, messages)
	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE
	return ..()
