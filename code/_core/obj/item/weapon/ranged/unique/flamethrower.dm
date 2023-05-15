/obj/item/weapon/ranged/unique/flamethrower/
	name = "flamethrower"
	desc = "Mphh Mphh!"
	desc_extended = "A dated flamethrower. Alt fire while weilding to release a blast of compressed phoron."
	icon = 'icons/obj/item/weapons/ranged/flamethrower.dmi'

	automatic = TRUE

	allow_reagent_transfer_from = FALSE
	allow_reagent_transfer_to = TRUE

	shoot_delay = 3

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	projectile = /obj/projectile/bullet/flamer
	projectile_speed = TILE_SIZE*0.3

	reagents = /reagent_container/weapon/flamethrower
	var/fuel_per_shot = 1
	var/fuel_per_airblast = 20
	uses_until_condition_fall = 100
	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	can_wield = TRUE
	wield_only = TRUE

	inaccuracy_modifier = 0.2

/obj/item/weapon/ranged/unique/flamethrower/get_ammo_count()
	return CEILING(reagents.volume_current,1)

/obj/item/weapon/ranged/unique/flamethrower/can_gun_shoot(mob/caller, atom/object, location, params, check_time, messages)
	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE
	return ..()

/obj/item/weapon/ranged/unique/flamethrower/click_on_object(mob/caller, atom/object, location, control, params)

	if((caller.attack_flags & CONTROL_MOD_DISARM) && wielded)
		return airblast(caller,object,location,params)
	. = ..()

/obj/item/weapon/ranged/unique/flamethrower/proc/airblast(mob/caller,atom/object,location,params)

	if(get_ammo_count() >= 20)
		reagents.add_reagent(/reagent/fuel/phoron,-20,TNULL,TRUE,FALSE,caller) //using a -add reagent because it needs to know im removing specifically phoron.
		return shoot(caller,object,location,params,projectile_override = /obj/projectile/airblast)
	return FALSE

/obj/item/weapon/ranged/unique/flamethrower/Generate()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/unique/flamethrower/austrailium/
	value_burgerbux = 1
