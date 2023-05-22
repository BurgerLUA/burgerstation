/obj/item/weapon/ranged/reagent_ammo/flamethrower/
	name = "flamethrower"
	desc = "Mphh Mphh!"
	desc_extended = "A dated flamethrower. Disarm + Fire to release a blast of compressed Fuel"
	icon = 'icons/obj/item/weapons/ranged/flamethrower.dmi'

	automatic = TRUE

	allow_reagent_transfer_from = TRUE
	allow_reagent_transfer_to = TRUE

	shoot_delay = 3

	size = SIZE_5

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	projectile = /obj/projectile/bullet/flamer
	projectile_speed = TILE_SIZE*0.3

	reagents = /reagent_container/weapon/flamethrower
	fuel_per_shot = 2
	var/fuel_per_airblast = 20
	uses_until_condition_fall = 100
	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	can_wield = TRUE
	wield_only = TRUE

	inaccuracy_modifier = 0.15

/obj/item/weapon/ranged/reagent_ammo/flamethrower/click_on_object(mob/caller, atom/object, location, control, params)
	if((caller.attack_flags & CONTROL_MOD_DISARM) && wielded)
		return airblast(caller,object,location,params)
	return ..()

/obj/item/weapon/ranged/reagent_ammo/flamethrower/shoot_projectile(atom/caller, atom/target, location, params, obj/projectile/projectile_to_use, damagetype/damage_type_to_use, icon_pos_x, icon_pos_y, accuracy_loss, projectile_speed_to_use, bullet_count_to_use, bullet_color, view_punch, damage_multiplier, desired_iff_tag, desired_loyalty_tag, desired_inaccuracy_modifier, base_spread, penetrations_left)
	. = ..()
	var/avg_flammability = 0
	for(var/reagent/fuel/F in reagents.stored_reagents)
		avg_flammability += F.fire_strength_per_unit * (reagents.get_reagent_volume(F)/reagents.volume_current)
	for(var/obj/projectile/P in .)
		P.damage_multiplier += avg_flammability

/obj/item/weapon/ranged/reagent_ammo/flamethrower/proc/airblast(mob/caller,atom/object,location,params)

	if(get_ammo_count() >= fuel_per_airblast)
		if(!is_living(caller))
			log_error("Non-living mob [caller.get_debug_name()] called airblast of [src.get_debug_name()]! Bad!")
			return FALSE
		var/mob/living/C = caller
		if (fuel_per_airblast > 0)
			reagents.remove_reagents(fuel_per_airblast,check_recipes = FALSE,caller = C)
		var/list/screen_loc_parsed = parse_screen_loc(C.client.last_params["screen-loc"])
		var/target_x = C.x * TILE_SIZE + screen_loc_parsed[1] - (C.client.view * TILE_SIZE)
		var/target_y = C.y * TILE_SIZE + screen_loc_parsed[2] - (C.client.view * TILE_SIZE)
		C.face_atom(object)
		var/desired_loc = get_step(C,C.dir)
		var/obj/structure/reflector/R = new /obj/structure/reflector(desired_loc,C,C.loyalty_tag,target_x,target_y)
		INITIALIZE(R)
		GENERATE(R) //I dont THINK this is nessissary but JIC
		FINALIZE(R)
		play_shoot_sounds(C,shoot_sounds)
		return TRUE
	return FALSE

/obj/item/weapon/ranged/reagent_ammo/flamethrower/Generate()
	reagents.add_reagent(/reagent/fuel/welding,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/reagent_ammo/flamethrower/austrailium/
	value_burgerbux = 100
	bypass_balance_check = TRUE //This is an admeme weapon.
	name = "austrailium flamethrower"
	icon = 'icons/obj/item/weapons/ranged/aussieflamethrower.dmi'
	desc = "Feel the heat!"
	desc_extended = "Made from a rare golden element from ancient Austrailia,boasts endless reserves of fuel."
	fuel_per_airblast = 0
	fuel_per_shot = 0


/obj/item/weapon/ranged/reagent_ammo/flamethrower/austrailium/Generate()
	. = ..()
	reagents.remove_all_reagents()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
