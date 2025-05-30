/obj/item/weapon/ranged/energy/hybrid
	var/mode = 0
	//0 = stun
	//1 = kill

	var/obj/projectile/projectile_stun
	var/obj/projectile/projectile_kill

	var/bullet_color_stun = "#00FFFF"
	var/bullet_color_kill = "#FF0000"

	var/damage_type_kill
	var/damage_type_stun

	var/list/shoot_sounds_kill = list()
	var/list/shoot_sounds_stun = list()

/obj/item/weapon/ranged/energy/hybrid/New(var/desired_loc)
	. = ..()

	//Set to kill.
	mode = 1
	projectile = projectile_kill
	ranged_damage_type = damage_type_kill
	shoot_sounds = shoot_sounds_kill
	bullet_color = bullet_color_kill

	update_sprite()
	update_held_icon()

/obj/item/weapon/ranged/energy/hybrid/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	mode = !mode
	activator.to_chat(span("notice","You switch \the [src] to [mode ? "kill" : "stun"]."))

	if(mode)
		projectile = projectile_kill
		ranged_damage_type = damage_type_kill
		shoot_sounds = shoot_sounds_kill
		bullet_color = bullet_color_kill
	else
		projectile = projectile_stun
		ranged_damage_type = damage_type_stun
		shoot_sounds = shoot_sounds_stun
		bullet_color = bullet_color_stun

	charge_cost = get_charge_cost()

	charge_icon_state_count = null

	update_sprite()
	update_held_icon()

	return TRUE