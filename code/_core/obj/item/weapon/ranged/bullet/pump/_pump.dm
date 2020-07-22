/obj/item/weapon/ranged/bullet/pump/
	var/action_name = "pump"
	open = TRUE
	open_icon = FALSE

	var/pump_sound = 'sound/weapons/shotgun_pump.ogg'

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN

	movement_spread_base = 0.03
	movement_spread_mul = 0.05

/obj/item/weapon/ranged/bullet/pump/get_ranged_damage_type()
	return stored_bullets[1] ? stored_bullets[1].damage_type : damage_type

/obj/item/weapon/ranged/bullet/pump/click_self(var/mob/caller)

	if(next_shoot_time > world.time + 1)
		return TRUE

	caller.to_chat(span("notice","You [action_name] \the [src]."))

	eject_chambered_bullet(caller,get_turf(src),TRUE)

	if(stored_bullets[1])
		var/obj/item/bullet_cartridge/B = stored_bullets[1]
		if(B)
			chambered_bullet = B
			stored_bullets.Cut(1,2)
			stored_bullets += null

	play(pump_sound,get_turf(src))
	update_sprite()

	next_shoot_time = world.time + 1

	return TRUE

/obj/item/weapon/ranged/bullet/pump/get_ammo_count()
	return get_real_length(stored_bullets)


/obj/item/weapon/ranged/bullet/pump/can_load_chamber(var/mob/caller,var/obj/item/bullet_cartridge/B)
	return FALSE