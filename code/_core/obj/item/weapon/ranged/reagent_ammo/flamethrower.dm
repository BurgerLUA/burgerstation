/obj/item/weapon/ranged/reagent_ammo/flamethrower
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
	reagent_volume_per_shot = 2

	var/airblast_ammo_multiplier = 10 //Airblast per shot = this * reagent_volume_per_shot

	uses_until_condition_fall = 100
	use_loyalty_tag = TRUE
	use_iff_tag = FALSE

	can_wield = TRUE
	wield_only = TRUE

	inaccuracy_modifier = 0.15

/obj/item/weapon/ranged/reagent_ammo/flamethrower/get_base_value()
	return 4000

/obj/item/weapon/ranged/reagent_ammo/flamethrower/click_on_object(mob/caller, atom/object, location, control, params)
	if((caller.attack_flags & CONTROL_MOD_DISARM) && wielded)
		return airblast(caller,object,location,params)
	. = ..()


/obj/item/weapon/ranged/reagent_ammo/proc/get_average_flammability()

	if(!reagents.volume_current)
		return 0

	. = 0

	for(var/r_id in reagents.stored_reagents)
		var/reagent/R = REAGENT(r_id)
		var/volume = reagents.stored_reagents[r_id]
		. += R.get_flammability()*volume

	. *= 1 / reagents.volume_current

	return .

/obj/item/weapon/ranged/reagent_ammo/flamethrower/shoot_projectile(atom/caller, atom/target, location, params, obj/projectile/projectile_to_use, damagetype/damage_type_to_use, icon_pos_x, icon_pos_y, accuracy_loss, projectile_speed_to_use, bullet_count_to_use, bullet_color, view_punch, damage_multiplier, desired_iff_tag, desired_loyalty_tag, desired_inaccuracy_modifier, base_spread, penetrations_left)

	if(!reagents.volume_current)
		return null

	. = ..()

	var/average_flammability = get_average_flammability()*10

	for(var/k in .)
		var/obj/projectile/P = k
		P.damage_multiplier += average_flammability

/obj/item/weapon/ranged/reagent_ammo/flamethrower/proc/airblast(var/mob/caller,var/atom/object,location,params)

	var/desired_dir = get_dir(caller,object)
	var/turf/desired_loc = get_step(caller,desired_dir)
	caller.set_dir(desired_dir)

	if(!desired_loc || get_ammo_count() < airblast_ammo_multiplier)
		handle_empty()
		return FALSE

	var/loyalty_tag_to_use
	if(is_living(caller))
		var/mob/living/L = caller
		if(L.loyalty_tag)
			loyalty_tag_to_use = L.loyalty_tag

	if(airblast_ammo_multiplier > 0)
		reagents.remove_reagents(reagent_volume_per_shot*airblast_ammo_multiplier,check_recipes = FALSE,caller = caller)

	var/obj/reflector/R = new /obj/reflector(desired_loc,caller,loyalty_tag_to_use,src.get_average_flammability()*10)
	R.set_dir(desired_dir)
	INITIALIZE(R)
	GENERATE(R)
	FINALIZE(R)
	play_shoot_sounds(caller,shoot_sounds)
	return TRUE

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
	reagent_volume_per_shot = 0


/obj/item/weapon/ranged/reagent_ammo/flamethrower/austrailium/Generate()
	. = ..()
	reagents.remove_all_reagents()
	reagents.add_reagent(/reagent/fuel/phoron,reagents.volume_max)
