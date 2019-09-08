/obj/item/weapon/ranged/bullet/revolver/
	open = FALSE

/obj/item/weapon/ranged/bullet/revolver/click_self(var/mob/caller)
	open = !open

	if(open)
		eject_spent_casings(caller, caller.loc)
		caller.to_chat(span("notice","You open \the [src]. It contains [get_ammo_count()] bullet\s."))
	else
		caller.to_chat(span("notice","You close \the [src]."))

	var/area/A = get_area(caller.loc)
	play_sound('sounds/weapons/revolver_click2.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment, sound_type = SOUND_TYPE_FX)

	update_icon()

	return TRUE

/obj/item/weapon/ranged/bullet/revolver/can_gun_shoot(var/mob/caller)

	if(open)
		return FALSE

	return ..()


/obj/item/weapon/ranged/bullet/revolver/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(open && object && is_inventory(object) && src && src.loc && is_inventory(src.loc))
		var/obj/hud/inventory/I = object
		var/obj/item/bullet/B = eject_top_stored_bullet(caller, get_turf(src))
		if(B)
			I.add_held_object(B)

		return TRUE

	return ..()