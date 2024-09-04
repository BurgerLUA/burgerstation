/obj/item/weapon/ranged/spellgem
	name = "spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells."
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

	var/casting_type = SKILL_MAGIC //What skill to use.

	var/base_mana_cost = 0 //The base mana cost for this item. Calculated on Initialize().

	requires_bullets = FALSE

	recommended_value_mod = 1.5

/obj/item/weapon/ranged/spellgem/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","This spellgem has a base mana cost of [base_mana_cost*(max_bursts ? max_bursts : 1)]. Can be augmented into wands to alter the spellgem's stats.")

/obj/item/weapon/ranged/spellgem/proc/calculate_mana_cost() //Don't actually use this. Use src.base_mana_cost instead.
	. = (get_damage_per_hit(0) + get_damage_per_hit(50) + get_damage_per_hit(100)) / 3
	if(bullet_count > 1)
		. *= 0.5 + bullet_count*0.5
		if((bullet_count % 2) != 1) //Even number of shots means it's not going to be accurate.
			. *= 0.5
		. *= max(0.125,1 - (spread_per_shot/90))
	. *= 0.5 + (projectile_speed / (TILE_SIZE-1))*0.5
	. *= 0.5 + min(1,10/shoot_delay)*0.5
	. *= 0.125
	. = CEILING(.,1)

/obj/item/weapon/ranged/spellgem/update_attachment_stats()

	attachment_stats = list()

	if(!istype(src.loc,/obj/item/weapon/ranged/wand))
		return FALSE

	attachment_stats["mana_cost_multiplier"] = 1

	var/obj/item/weapon/ranged/wand/W = src.loc

	for(var/g in W.socketed_supportgems)
		var/obj/item/supportgem/G = g
		for(var/support_type in G.support_stats)
			var/support_value = G.support_stats[support_type]
			if(!attachment_stats[support_type] || !isnum(support_value))
				attachment_stats[support_type] = support_value
			else
				attachment_stats[support_type] *= support_value

	if(attachment_stats["mana_cost_multiplier"] < 0.25)
		attachment_stats["mana_cost_multiplier"] = 0.25

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
	base_mana_cost = calculate_mana_cost()

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

/obj/item/weapon/ranged/spellgem/pre_shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)

	. = ..()

	if(. && caller.health)

		var/final_mana_cost = base_mana_cost

		if(length(attachment_stats) && attachment_stats["mana_cost_multiplier"])
			final_mana_cost *= attachment_stats["mana_cost_multiplier"]

		if(is_living(caller))
			var/mob/living/L = caller
			final_mana_cost *= 1 - L.get_skill_power(casting_type,0,1,2)*0.25 //Up to 25% reduction at level 100. Level 200 is 50%

		final_mana_cost = max(final_mana_cost,base_mana_cost*0.25)

		if(final_mana_cost > caller.health.mana_current)
			caller.to_chat(span("warning","You try to push with all your mana, but the spell fizzles!"))
			return FALSE //Fail

		caller.health.adjust_mana(-final_mana_cost)

/obj/item/weapon/ranged/spellgem/update_overlays()
	. = ..()

	if(color_2)
		var/image/I = new(icon,"[icon_state]_grad")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.alpha = min(100 + base_mana_cost,255)
		I.color = color_2
		add_overlay(I)

	if(color_3)
		var/image/I = new(icon,"[icon_state]_outline")
		I.appearance_flags = appearance_flags | RESET_COLOR
		I.alpha = min(100 + base_mana_cost,255)
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
