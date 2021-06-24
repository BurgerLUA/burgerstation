//Here lies a dumb framework.

/spell/
	var/name = "spell name"
	var/desc = "Spell description."

	var/cast_delay = SECONDS_TO_DECISECONDS(0.5)
	var/cast_sound

/spell/proc/on_cast(var/mob/caller,var/atom/target,location,control,params)
	if(cast_sound)
		play_sound(cast_sound,get_turf(caller))
	return TRUE

/spell/proc/can_cast(var/mob/caller,var/atom/target,location,control,params)
	return TRUE



/spell/projectile
	name = "projectile spell"
	desc = "projectile spell description"

	var/obj/projectile/projectile
	var/damagetype/damage_type

	var/base_projectile_speed = TILE_SIZE*0.5
	var/base_projectile_amount = 1
	var/base_spread = 0
	var/base_penetrations = 0

/spell/projectile/on_cast(var/mob/caller,var/atom/target,location,control,params)

	var/icon_pos_x = text2num(params[PARAM_ICON_X])
	var/icon_pos_y = text2num(params[PARAM_ICON_Y])

	var/desired_tag = null
	if(is_living(caller))
		var/mob/living/L = caller
		desired_tag = L.loyalty_tag

	caller.shoot_projectile(
		caller,
		target,
		location,
		params,
		projectile,
		damage_type,
		icon_pos_x,
		icon_pos_y,
		0,
		base_projectile_speed,
		base_projectile_amount,
		"#FFFFFF",
		0, //View Punch
		1, //Damage multiplier
		desired_tag,
		desired_tag,
		1, //Inaccuracy modifier
		base_spread,
		base_penetrations
	)


/spell/projectile/chaos