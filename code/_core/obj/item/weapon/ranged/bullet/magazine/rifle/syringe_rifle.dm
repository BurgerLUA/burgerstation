/obj/item/weapon/ranged/bullet/magazine/rifle/syringe
	name = "\improper syringe rifle"
	icon = 'icons/obj/item/weapons/ranged/misc/syringe.dmi'
	desc = "Long distance Poisoning"
	desc_extended = "In the older days, poisoners had to rely on clever tricks, distraction and sleight-of-hand in order to poison their enemies. Luckily, we live in gentler times, so now you can just shoot em with poison syringes."
	icon_state = "inventory"
	value = 1200

	company_type = "Syndicate"

	tier = 2

	shoot_delay = 8

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/rifle/syringe/shoot.ogg')

	can_wield = FALSE

	size = SIZE_3
	weight = 8

	override_icon_state = TRUE

	heat_max = 0.03

	bullet_length_min = 18.5
	bullet_length_best = 18.5
	bullet_length_max = 18.5

	bullet_diameter_min = 18.5
	bullet_diameter_best = 18.5
	bullet_diameter_max = 18.5

	ai_heat_sensitivity = 2

	shoot_alert = ALERT_LEVEL_NONE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 30 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 28 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.03

	var/reagent_per_shot = 5

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/get_base_value()
	. = ..()
	. += 1000

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/stored_bullets = M.get_ammo_count()
		if(stored_bullets == 1)
			icon_state = "[initial(icon_state)]_[round(stored_bullets,1)]"
		else
			icon_state = "[initial(icon_state)]_[round(stored_bullets,2)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/shoot_projectile(var/atom/caller,var/atom/target,location,params,var/obj/projectile/projectile_to_use,var/damagetype/damage_type_to_use,var/icon_pos_x=0,var/icon_pos_y=0,var/accuracy_loss=0,var/projectile_speed_to_use=0,var/bullet_count_to_use=1,var/bullet_color="#FFFFFF",var/view_punch=0,var/damage_multiplier=1,var/desired_iff_tag,var/desired_loyalty_tag,var/desired_inaccuracy_modifier=1,var/base_spread = get_base_spread(),var/penetrations_left=0)

	. = ..()

	if(. && stored_magazine && stored_magazine.reagents)
		for(var/k in .)
			var/obj/projectile/P = k
			if(P.reagents)
				stored_magazine.reagents.transfer_reagents_to(P.reagents,reagent_per_shot, caller = caller)
				if(P.reagents && P.reagents.volume_current > 0 && !P.reagents.contains_lethal) //I love race conditions!
					P.hostile = FALSE
					P.damage_type = null

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))
