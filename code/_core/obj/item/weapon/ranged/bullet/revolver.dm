/obj/item/weapon/ranged/bullet/revolver/
	open = FALSE

/obj/item/weapon/ranged/bullet/revolver/click_self(var/atom/caller)
	open = !open

	if(open)
		eject_spent_casings(caller, caller.loc)
		caller.to_chat(span("notice","You open \the [src]. It contains [get_ammo_count()] bullet\s."))
	else
		caller.to_chat(span("notice","You close \the [src]."))

	var/area/A = get_area(caller.loc)
	play_sound('sounds/weapon/misc/revolver_click2.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)

	update_icon()

	return TRUE

/obj/item/weapon/ranged/bullet/revolver/can_gun_shoot(var/mob/caller)

	if(open)
		return FALSE

	return ..()


