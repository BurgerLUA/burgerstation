/obj/item/weapon/ranged/bullet/pump/
	var/action_name = "pump"
	open = TRUE
	var/needs_pump = TRUE
	var/obj/item/bullet/stored_chamber

	open_icon = FALSE

	var/pump_sound = 'sounds/weapons/shotgun_pump.ogg'

/obj/item/weapon/ranged/bullet/pump/get_damage_type()
	return length(stored_bullets) && stored_bullets[1] ? stored_bullets[1].damage_type : damage_type

/obj/item/weapon/ranged/bullet/pump/can_gun_shoot(var/atom/caller)
	return stored_chamber && stored_chamber.is_spent == FALSE

/obj/item/weapon/ranged/bullet/pump/click_self(var/mob/caller)

	if(next_shoot_time > curtime + 1)
		return TRUE

	caller.to_chat(span("notice","You [action_name] \the [src]."))

	if(stored_chamber)
		stored_chamber.force_move(caller.loc)
		stored_chamber.update_icon()
		stored_chamber = null

	if(length(stored_bullets) && stored_bullets[1])
		stored_chamber = stored_bullets[1]
		stored_bullets -= stored_chamber

	var/area/A = get_area(caller.loc)
	play_sound(pump_sound,all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	needs_pump = FALSE
	update_icon()

	next_shoot_time = curtime + 1

	return TRUE

/obj/item/weapon/ranged/bullet/pump/get_ammo_count()
	return length(stored_bullets)

/obj/item/weapon/ranged/bullet/pump/spend_bullet()
	needs_pump = TRUE
	stored_chamber.spend_bullet()
	return stored_chamber