/obj/item/supportgem
	name = "support gem"
	desc = "Not ripping off another game, I swear."
	desc_extended = "A magical gem that supports socketed skills in wands."

	icon = 'icons/obj/item/spellgem.dmi'
	icon_state = "support"

	var/support_desc

	var/power_base = 1
	var/power_per_quality = 0 //Above 100.

	quality = 100

	value = 0

	color = "#FFFFFF"
	var/color_2 = "#FFFFFF"
	var/color_3 = "#FFFFFF"

	var/list/support_stats = list()

	tier_type = "support gem"

	rarity = RARITY_UNCOMMON

/obj/item/supportgem/get_base_value()

	if(!length(support_stats))
		return 0

	. = ..()


/obj/item/supportgem/proc/update_support_stats()
	return TRUE

/obj/item/supportgem/proc/get_power()
	return power_base + (quality-100)*power_per_quality


/obj/item/supportgem/update_overlays()
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


/obj/item/supportgem/Finalize()
	. = ..()
	update_support_stats()
	update_sprite()

/obj/item/supportgem/adjust_quality(var/quality_to_add=0)
	. = ..()
	if(.)
		update_support_stats()

/obj/item/supportgem/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice",support_desc)
	. += div("notice","Bolded values above indicate that value scales with quality.")


/obj/item/supportgem/damage
	name = "deadly impact support gem"
	power_base = 0.2 //20%
	power_per_quality = 1/100 //100% more damage per 100 quality
	value = 350

	color = COLOR_RED
	color_2 = COLOR_ORANGE
	color_3 = COLOR_GOLD


/obj/item/supportgem/damage/update_support_stats()
	var/damage_mul = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"damage_multiplier" = 1 + damage_mul,
		"mana_cost_multiplier" = 2,
		"shoot_delay" = 1.5
	)
	support_desc = "Increases damage dealt by <b>[(damage_mul)*100]</b>%.\nIncreases mana cost by 100%.\nIncreases shoot delay by 50%."

/obj/item/supportgem/cost
	name = "cheaper casting support gem"
	power_base = 0.10 //10%
	power_per_quality = 0.5/100 //50% reduced mana cost per 100 quality
	value = 100

	color = COLOR_BLUE
	color_2 = COLOR_WHITE
	color_3 = COLOR_GREEN

/obj/item/supportgem/cost/update_support_stats()
	var/mana_mul = min(0.75,power_base + (quality-100)*power_per_quality)
	support_stats = list(
		"mana_cost_multiplier" = 1 - mana_mul,
		"projectile_speed" = 0.75,
		"inaccuracy_modifier" = 1.25
	)
	support_desc = "Decreases mana cost by <b>[mana_mul*100]</b>%.\nDecreases projectile speed by 25%.\nDecreases projectile accuracy by 25%."

/*
/obj/item/supportgem/projectiles
	name = "spliting shots support gem"
	power_base = 1 //1 extra projectile
	power_per_quality = 5/100 //5 extra projectiles per 100 quality
	value = 300

	color = COLOR_GREEN
	color_2 = COLOR_GREEN_DARK
	color_3 = COLOR_GOLD

/obj/item/supportgem/projectiles/update_support_stats()
	var/projectile_count = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"bullet_count" = projectile_count,
		"mana_cost_multiplier" = 3,
		"bullet_spread" = 3
	)
	support_desc = "Increases projectile count by <b>[projectile_count]</b>.\nIncreases mana cost by 200%.\nIncreases projectile spread by 200%."
*/


/obj/item/supportgem/spread
	name = "focused shots support gem"
	power_base = 0.5 //50%
	power_per_quality = 0.2 / 100 //20% less spread per 100 quality
	value = 150

	color = COLOR_GREEN
	color_2 = COLOR_BLUE
	color_3 = COLOR_RED

/obj/item/supportgem/spread/update_support_stats()
	var/bullet_spread = min(0.75,power_base + (quality-100)*power_per_quality)
	support_stats = list(
		"bullet_spread" = 1 - bullet_spread,
		"inaccuracy_modifier" = 0.75,
		"projectile_speed" = 1.25,
		"shoot_delay" = 2
	)
	support_desc = "Decreases projectile spread by <b>[bullet_spread*100]</b>%.\nIncreases projectile accuracy by 25%.\nIncreases projectile speed by 25%.\nIncreases shoot delay by 100%."

/obj/item/supportgem/penetrations
	name = "penetrator support gem"
	power_base = 1 //1 extra penetration
	power_per_quality = 3/100 //3 extra penetrations per 100 quality
	value = 400

	color = COLOR_PINK
	color_2 = COLOR_PURPLE
	color_3 = COLOR_WHITE

/obj/item/supportgem/penetrations/update_support_stats()
	var/penetration_count = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"penetrations" = 1 + penetration_count,
		"mana_cost_multiplier" = 1.5
	)
	support_desc = "Increases penetration multiplier by <b>[penetration_count*100]%</b>.\nIncreases mana cost by 50%."

/obj/item/supportgem/overkill
	name = "overkill support gem"
	power_base = 0.4 //1.4x dmg
	power_per_quality = 1/100 //100% more damage per 100% qual
	value = 400

	color = COLOR_PINK
	color_2 = COLOR_PURPLE
	color_3 = COLOR_WHITE

/obj/item/supportgem/overkill/update_support_stats()
	var/damagemult = power_base + (quality-100)*power_per_quality
	var/manamult = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"damage_multiplier" = 1 + damagemult,
		"inaccuracy_modifier" = 1.25,
		"projectile_speed" = 1.25,
		"mana_cost_multiplier" = manamult + 2.5,
		"shoot_delay" = 2
	)
	support_desc = "Increases damage by <b>[damagemult*100]%</b>.\nIncreases mana cost by <b>[(manamult + 1.5)*100]%</b>.\nIncreases projectile speed by 25%.\nIncreases shoot delay by 100%."


/obj/item/supportgem/speed
	name = "speed support gem"
	power_base = 0.2 //20% increased speed.
	power_per_quality = 0.4/100 //40% increased speed per 100 quality.
	value = 200

	color = COLOR_GOLD
	color_2 = COLOR_RED
	color_3 = COLOR_WHITE

/obj/item/supportgem/speed/update_support_stats()
	var/projectile_speed = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"projectile_speed" = 1 + projectile_speed,
		"mana_cost_multiplier" = 1.5
	)
	support_desc = "Increases projectile speed by <b>[projectile_speed*100]%</b>.\nIncreases mana cost by 50%.\nNote: Projectile speed is capped to a certain amount."


/obj/item/supportgem/precision
	name = "precision support gem"
	power_base = 0.2 //20% increased accuracy.
	power_per_quality = 0.4/100 //40% increased accuracy per 100 quality.
	value = 100

	color = COLOR_GREEN
	color_2 = COLOR_RED
	color_3 = COLOR_RED

/obj/item/supportgem/precision/update_support_stats()
	var/precision = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"inaccuracy_modifier" = 1 - precision,
		"mana_cost_multiplier" = 1.3
	)
	support_desc = "Increases accuracy by <b>[precision*100]%</b>.\nIncreases mana cost by 30%."