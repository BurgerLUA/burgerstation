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

	use_loyalty_tag = TRUE
	has_quick_function = TRUE

/obj/item/weapon/ranged/spellgem/get_owner()

	if(istype(src.loc,/obj/item/weapon/ranged/wand/))
		var/obj/item/weapon/ranged/wand/W = src.loc
		return W.get_owner()

	. = ..()

/obj/item/weapon/ranged/spellgem/Finalize()
	. = ..()
	update_sprite()

/obj/item/weapon/ranged/spellgem/can_gun_shoot(var/mob/caller)

	if(get_ammo_count() < 1)
		return FALSE

	return ..()

/obj/item/weapon/ranged/spellgem/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner)
		return 0

	if(!owner.health)
		return 1

	if(!cost_mana)
		return 1

	return owner && cost_mana ? FLOOR(owner.health.mana_current / cost_mana, 1) : 0

/obj/item/weapon/ranged/spellgem/handle_ammo(var/mob/caller,var/bullet_position=1)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	A.health.adjust_mana(-cost_mana)

	A.update_health_element_icons(mana=TRUE)

	A.mana_regen_delay = max(A.mana_regen_delay,30)

	return null


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

/obj/item/weapon/ranged/spellgem/quick(var/mob/caller,var/atom/object,location,params)
	return shoot(caller,object,location,params)