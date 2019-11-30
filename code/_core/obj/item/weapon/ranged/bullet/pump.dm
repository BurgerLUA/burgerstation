/obj/item/weapon/ranged/bullet/pump/
	var/action_name = "pump"
	open = TRUE
	open_icon = FALSE

	var/pump_sound = 'sounds/weapons/shotgun_pump.ogg'

/obj/item/weapon/ranged/bullet/pump/get_damage_type()
	return stored_bullets[1] ? stored_bullets[1].damage_type : damage_type

/obj/item/weapon/ranged/bullet/pump/click_self(var/mob/caller)

	if(next_shoot_time > curtime + 1)
		return TRUE

	caller.to_chat(span("notice","You [action_name] \the [src]."))

	eject_chambered_bullet(caller,get_turf(src))

	if(stored_bullets[1])
		var/obj/item/bullet/B = stored_bullets[1]
		stored_bullets -= B
		chambered_bullet = B
		stored_bullets += null

	var/area/A = get_area(caller.loc)
	play_sound(pump_sound,all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	update_icon()

	next_shoot_time = curtime + 1

	return TRUE

/obj/item/weapon/ranged/bullet/pump/get_ammo_count()
	return get_real_length(stored_bullets)