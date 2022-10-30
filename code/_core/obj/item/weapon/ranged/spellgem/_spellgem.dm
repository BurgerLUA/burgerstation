/obj/item/weapon/ranged/spellgem
	name = "spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands."
	icon = 'icons/obj/item/spellgem.dmi'
	icon_state = null

	var/color_2 = null //Gradient
	var/color_3 = null //Outline

	var/spread_per_shot = 5 //Angle to add per shot.

	automatic = TRUE

	use_loyalty_tag = TRUE
	use_iff_tag = FALSE
	has_quick_function = TRUE

	company_type = "Wizard Federation"

	var/cost_mana = 0 //generated on Initialize()

/obj/item/weapon/ranged/spellgem/get_base_value()
	. = ..()
	. *= 1 - (spread_per_shot/360)

/obj/item/weapon/ranged/spellgem/proc/get_base_mana_cost()
	. = get_damage_per_hit(100)
	. *= bullet_count
	. *= projectile_speed/TILE_SIZE
	. *= 1 - (spread_per_shot/360)
	. *= 0.25
	. = CEILING(.,1)




/obj/item/weapon/ranged/spellgem/proc/get_mana_cost(var/mob/living/caller)
	. = cost_mana
	if(attachment_stats["mana_cost_multiplier"])
		. *= attachment_stats["mana_cost_multiplier"]


/obj/item/weapon/ranged/spellgem/update_attachment_stats()

	attachment_stats = list()

	if(!istype(src.loc,/obj/item/weapon/ranged/wand))
		return FALSE

	var/obj/item/weapon/ranged/wand/W = src.loc

	var/list/modifier_count = list()

	for(var/g in W.socketed_supportgems)
		var/obj/item/supportgem/G = g
		for(var/support_type in G.support_stats)
			var/support_value = G.support_stats[support_type]
			if(isnum(support_value))
				attachment_stats[support_type] += support_value
				modifier_count[support_type] += 1
			else
				attachment_stats[support_type] = support_value

	for(var/support_type in modifier_count)
		var/support_value = modifier_count[support_type]
		if(!support_value)
			log_error("Warning: Support value of [support_type] was [isnum(support_value) ? 0 : "NULL"] for [src.get_debug_name()].")
			continue
		if(!isnum(support_value))
			continue
		attachment_stats[support_type] *= (1/support_value)

	if(attachment_stats["mana_cost_multiplier"])
		attachment_stats["mana_cost_multiplier"] *= W.wand_mana_multiplier
	else
		attachment_stats["mana_cost_multiplier"] = W.wand_mana_multiplier

	if(attachment_stats["damage_multiplier"])
		attachment_stats["damage_multiplier"] *= W.wand_damage_multiplier
	else
		attachment_stats["damage_multiplier"] = W.wand_damage_multiplier

	return TRUE



/obj/item/weapon/ranged/spellgem/get_owner()

	if(istype(src.loc,/obj/item/weapon/ranged/wand/))
		var/obj/item/weapon/ranged/wand/W = src.loc
		return W.get_owner()

	. = ..()

/obj/item/weapon/ranged/spellgem/Initialize()
	. = ..()
	cost_mana = get_base_mana_cost()

/obj/item/weapon/ranged/spellgem/Finalize()
	. = ..()
	update_sprite()

/obj/item/weapon/ranged/spellgem/can_gun_shoot(var/mob/caller,var/atom/object,location,params,var/check_time=TRUE,var/messages=TRUE)

	if(get_ammo_count() < 1)
		return FALSE

	return ..()

/obj/item/weapon/ranged/spellgem/get_ammo_count()

	var/mob/living/owner = get_owner()

	if(!owner)
		return 0

	if(!owner.health)
		return 1

	var/final_cost = get_mana_cost(owner)

	if(final_cost <= 0)
		return 1

	return owner && cost_mana ? FLOOR(owner.health.mana_current / final_cost, 1) : 0

/obj/item/weapon/ranged/spellgem/handle_ammo(var/mob/caller,var/bullet_position=1)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	if(!A.health)
		return ..()

	var/final_cost = get_mana_cost(A)

	if(final_cost != 0)
		A.health.adjust_mana(-final_cost)

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