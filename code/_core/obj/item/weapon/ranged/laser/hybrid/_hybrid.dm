/obj/item/weapon/ranged/laser/hybrid
	var/mode = 0
	//0 = stun
	//1 = kill

	var/obj/projectile/projectile_stun
	var/obj/projectile/projectile_kill

	var/damage_type_kill
	var/damage_type_stun

	var/list/shoot_sounds_kill = list()
	var/list/shoot_sounds_stun = list()

/obj/item/weapon/ranged/laser/hybrid/New(var/desired_loc)
	. = ..()

	mode = 0 //stun
	projectile = projectile_stun
	damage_type = damage_type_stun
	shoot_sounds = shoot_sounds_stun

	update_icon()

	return .

/obj/item/weapon/ranged/laser/hybrid/click_self(var/mob/caller)

	mode = !mode
	caller.to_chat(span("notice","You switch \the [src] to [mode ? "kill" : "stun"]."))

	if(mode)
		projectile = projectile_kill
		damage_type = damage_type_kill
		shoot_sounds = shoot_sounds_kill
	else
		projectile = projectile_stun
		damage_type = damage_type_stun
		shoot_sounds = shoot_sounds_stun

	update_icon()

	return TRUE