/obj/item/weapon/ranged/reagent_sprayer
	name = "reagent sprayer"
	desc = "Finally."
	desc_extended = "Shoots reagents."

	var/reagent_per_shot = 5

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	projectile = /obj/projectile/spray
	projectile_speed = 5

	shoot_sounds = list('sound/effects/window_spray.ogg')

	movement_spread_base = 0.01

	use_loyalty_tag = FALSE
	use_iff_tag = FALSE
	firing_pin = null

	inaccuracy_modifier = 0

/obj/item/weapon/ranged/reagent_sprayer/get_ammo_count()
	return CEILING(reagents.volume_current / (reagent_per_shot*bullet_count),1)

/obj/item/weapon/ranged/reagent_sprayer/can_gun_shoot(var/mob/caller,var/atom/object,location,params,var/check_time=TRUE,var/messages=TRUE)

	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE

	return ..()

/obj/item/weapon/ranged/reagent_sprayer/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color,var/view_punch=0,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/base_spread = get_base_spread())

	. = ..()

	for(var/k in .)
		var/obj/projectile/P = k
		if(!P.reagents)
			log_error("Warning: Could not transfer reagents from [src.get_debug_name()] to [P.get_debug_name()] as it had no reagent container!")
			continue
		reagents.transfer_reagents_to(P.reagents,reagent_per_shot, caller = caller,check_recipes=FALSE) //Recipes aren't checked here because there is no need and it will cause race conditions otherwise.

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle
	name = "spray bottle"
	reagents = /reagent_container/beaker/large
	reagent_per_shot = 5
	icon = 'icons/obj/item/container/spray_bottle.dmi'

	size = SIZE_2
	weight = 2

	value = 50

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/water
	name = "spray bottle (water)"

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube
	name = "spray bottle (lube)"

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/lube/Generate()
	reagents.add_reagent(/reagent/lube,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/space_cleaner
	name = "spray bottle (space cleaner)"

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle/space_cleaner/Generate()
	reagents.add_reagent(/reagent/space_cleaner,reagents.volume_max)
	return ..()


/obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher
	name = "fire extinguisher"
	desc = "For use in emergencies only."
	desc_extended = "A lackluster red extinguisher (allegedly) containing enough water to put out small fires."
	icon = 'icons/obj/item/extinguisher.dmi'

	projectile = /obj/projectile/extinguisher_spray

	size = SIZE_3
	weight = 8

	value = 100

	dan_mode = TRUE

	reagent_per_shot = 3

	projectile_speed = 15

	automatic = TRUE

	shoot_delay = 3

	bullet_count = 2

	reagents = /reagent_container/beaker/bucket

/obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/structure/interactive/fire_closet))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/obj/structure/interactive/fire_closet/FC = object
		if(FC.stored_extinguisher)
			caller.to_chat(span("warning","There is already a [FC.stored_extinguisher.name] in \the [FC.name]!"))
			return TRUE
		src.drop_item(FC)
		FC.stored_extinguisher = src
		FC.update_sprite()
		return TRUE

	. = ..()

/obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()

/obj/item/weapon/ranged/reagent_sprayer/fire_extinguisher/get_base_spread()
	return 0.1




/obj/item/weapon/ranged/reagent_sprayer/mega_sprayer
	name = "mega sprayer"
	reagents = /reagent_container/beaker/bucket
	reagent_per_shot = 20
	icon = 'icons/obj/item/weapons/ranged/chem_sprayer.dmi'

	size = SIZE_3
	weight = 15

	value = 300

	dan_mode = FALSE