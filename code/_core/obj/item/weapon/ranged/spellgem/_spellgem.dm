/obj/item/weapon/ranged/spellgem
	name = "spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands."
	icon = 'icons/obj/item/spellgem.dmi'
	icon_state = null

	var/color_2 = null //Gradient
	var/color_3 = null //Outline

	var/cost_mana = 0

	var/spread_per_shot = 1 //Angle to add per shot.

	automatic = TRUE

/obj/item/weapon/ranged/spellgem/Finalize()
	. = ..()
	update_sprite()

/obj/item/weapon/ranged/spellgem/get_heat_spread()
	return 0

/obj/item/weapon/ranged/spellgem/get_static_spread()
	return 0

/obj/item/weapon/ranged/spellgem/get_skill_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/spellgem/get_movement_spread(var/mob/living/L)
	return 0

/obj/item/weapon/ranged/spellgem/update_overlays()
	. = ..()

	if(color_2)
		var/image/I = new(icon,"[icon_state]_grad")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.alpha = 200
		I.color = color_2
		add_overlay(I)

	if(color_3)
		var/image/I = new(icon,"[icon_state]_outline")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.alpha = 200
		I.color = color_3
		add_overlay(I)


/obj/item/weapon/ranged/spellgem/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	if(bullet_num_max <= 1)
		return list(initial_offset_x,initial_offset_y)

	var/angle = ATAN2(initial_offset_x,initial_offset_y)

	angle += ((bullet_num-1) - (bullet_num_max-1)*0.5)*spread_per_shot

	return list(cos(angle),sin(angle))