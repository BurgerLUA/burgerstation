/obj/item/weapon/ranged/bullet/pump/
	var/action_name = "pump"
	open = TRUE
	open_icon = FALSE

	var/pump_sound = 'sound/weapons/ranged/generic/shotgun_pump.ogg'

	movement_spread_base = 0.03

	var/pump_delay = 1

	tier_type = "shotgun"


/obj/item/weapon/ranged/bullet/pump/proc/pump(mob/caller,silent=FALSE)

	var/turf/T = get_turf(src)

	caller?.to_chat(span("notice","You [action_name] \the [src]."))

	eject_chambered_bullet(caller,T,TRUE)

	if(stored_bullets[1])
		var/obj/item/bullet_cartridge/B = stored_bullets[1]
		if(B)
			chambered_bullet = B
			stored_bullets.Cut(1,2)
			stored_bullets += null

	if(!silent && pump_sound)
		play_sound(pump_sound,T,range_max=VIEW_RANGE)
	update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/pump/get_ranged_damage_type()
	return stored_bullets[1] ? stored_bullets[1].damage_type : null

/obj/item/weapon/ranged/bullet/pump/click_self(mob/caller,location,control,params)

	if(next_shoot_time > world.time + pump_delay)
		return TRUE

	if(next_shoot_time > world.time + shoot_delay)
		return TRUE

	INTERACT_CHECK
	INTERACT_DELAY(1)

	pump()

	next_shoot_time = max(next_shoot_time,world.time + pump_delay)

	return TRUE

/obj/item/weapon/ranged/bullet/pump/get_ammo_count()
	return get_real_length(stored_bullets)


/obj/item/weapon/ranged/bullet/pump/can_load_chamber(mob/caller,obj/item/bullet_cartridge/B)
	return FALSE

/obj/item/weapon/ranged/bullet/pump/get_examine_list(mob/caller)
	return ..() + div("notice","[get_ammo_count()] shell\s remaining in the tube.")
