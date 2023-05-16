/obj/item/weapon/ranged/unique/flamethrower/
	name = "flamethrower"
	desc = "Mphh Mphh!"
	desc_extended = "A dated flamethrower. Disarm + Fire to release a blast of compressed Fuel"
	icon = 'icons/obj/item/weapons/ranged/flamethrower.dmi'

	automatic = TRUE

	allow_reagent_transfer_from = TRUE
	allow_reagent_transfer_to = TRUE
	var/allowed_reagents = list(/reagent/fuel/phoron,/reagent/fuel/oil,/reagent/fuel/welding)
	shoot_delay = 3

	size = SIZE_5

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	projectile = /obj/projectile/bullet/flamer
	projectile_speed = TILE_SIZE*0.3

	reagents = /reagent_container/weapon/flamethrower
	var/fuel_per_shot = 2
	var/fuel_per_airblast = 10
	uses_until_condition_fall = 100
	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	can_wield = TRUE
	wield_only = TRUE

	inaccuracy_modifier = 0.2

/obj/item/weapon/ranged/unique/flamethrower/get_ammo_count()
	return FLOOR((reagents.volume_current/fuel_per_shot),1)

/obj/item/weapon/ranged/unique/flamethrower/can_gun_shoot(mob/caller, atom/object, location, params, check_time, messages)
	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE
	return ..()

/obj/item/weapon/ranged/unique/flamethrower/click_on_object(mob/caller, atom/object, location, control, params)

	if((caller.attack_flags & CONTROL_MOD_DISARM) && wielded)
		return airblast(caller,object,location,params)
	. = ..()

/obj/item/weapon/ranged/unique/flamethrower/handle_ammo(mob/caller)
	return reagents.remove_reagents(fuel_per_shot,TRUE,FALSE,caller)

/obj/item/weapon/ranged/unique/flamethrower/shoot_projectile(atom/caller, atom/target, location, params, obj/projectile/projectile_to_use, damagetype/damage_type_to_use, icon_pos_x, icon_pos_y, accuracy_loss, projectile_speed_to_use, bullet_count_to_use, bullet_color, view_punch, damage_multiplier, desired_iff_tag, desired_loyalty_tag, desired_inaccuracy_modifier, base_spread, penetrations_left)
	. = ..()
	var/avg_flammability = 0
	for(var/reagent/fuel/F in reagents.stored_reagents)
		avg_flammability += F.fire_strength_per_unit * (reagents.get_reagent_volume(F)/reagents.volume_current)
	for(var/obj/projectile/P in .)
		P.damage_multiplier += avg_flammability

/obj/item/weapon/ranged/unique/flamethrower/proc/airblast(mob/caller,atom/object,location,params)

	if(get_ammo_count() >= fuel_per_airblast)
		reagents.remove_reagents(fuel_per_airblast-fuel_per_shot,check_recipes = FALSE,caller = caller) //We remove -fuel per shot because the SHOOT proc eats it.
		return shoot(caller,object,location,params,projectile_override = /obj/projectile/airblast)
	return FALSE

/obj/item/weapon/ranged/unique/flamethrower/Generate()
	reagents.add_reagent(/reagent/fuel/welding,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/unique/flamethrower/austrailium/
	value_burgerbux = 100
	bypass_balance_check = TRUE //This is an admeme weapon.
	name = "austrailium flamethrower"
	icon = 'icons/obj/item/weapons/ranged/aussieflamethrower.dmi'
	desc = "Feel the heat!"
	desc_extended = "Made from a rare golden element from ancient Austrailia,boasts endless reserves of fuel."


/obj/item/weapon/ranged/unique/flamethrower/austrailium/Generate()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/unique/flamethrower/austrailium/handle_ammo(mob/caller)
	return null //Inf ammo.

/obj/item/weapon/ranged/unique/flamethrower/austrailium/airblast(mob/caller, atom/object, location, params)
	return shoot(caller,object,location,params,projectile_override = /obj/projectile/airblast) //inf airblast
