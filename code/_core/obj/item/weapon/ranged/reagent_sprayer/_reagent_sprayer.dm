/obj/item/weapon/ranged/reagent_sprayer
	name = "reagent sprayer"
	desc = "Finally."
	desc_extended = "Shoots reagents."

	var/reagent_per_shot = 5

	allow_reagent_transfer_to = TRUE
	allow_reagent_transfer_from = TRUE

	projectile = /obj/projectile/spray
	projectile_speed = 5

/obj/item/weapon/ranged/reagent_sprayer/get_ammo_count()
	return CEILING(reagents.volume_current / (reagent_per_shot*bullet_count),1)


/obj/item/weapon/ranged/reagent_sprayer/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() <= 0)
		handle_empty(caller)
		return FALSE

	return ..()

/obj/item/weapon/ranged/reagent_sprayer/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color,var/view_punch=0,var/view_punch_time=2,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifer=1,var/base_spread = get_base_spread())

	. = ..()

	for(var/obj/projectile/P in .)
		reagents.transfer_reagents_to(P.reagents,reagent_per_shot)

	return .

/obj/item/weapon/ranged/reagent_sprayer/spray_bottle
	name = "spray bottle"
	reagents = /reagent_container/beaker/large
	reagent_per_shot = 5
	icon = 'icons/obj/item/container/spray_bottle.dmi'

	value = 50