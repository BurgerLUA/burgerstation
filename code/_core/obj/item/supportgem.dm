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

	var/list/support_stats = list()


/obj/item/supportgem/proc/update_support_stats()
	return TRUE

/obj/item/supportgem/proc/get_power()
	return power_base + (quality-100)*power_per_quality


/obj/item/supportgem/Finalize()
	. = ..()
	update_support_stats()

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
	value = 250


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
	power_base = 0.05 //5%
	power_per_quality = 0.5/100 //50% reduced mana cost per 100 quality
	value = 250

/obj/item/supportgem/cost/update_support_stats()
	var/mana_mul = min(0.75,power_base + (quality-100)*power_per_quality)
	support_stats = list(
		"mana_cost_multiplier" = 1 - mana_mul,
		"projectile_speed" = 0.75,
		"inaccuracy_modifier" = 1.25
	)
	support_desc = "Decreases mana cost by <b>[mana_mul*100]</b>%.\nDecreases projectile speed by 25%.\nDecreases projectile accuracy by 25%."

/obj/item/supportgem/projectiles
	name = "spliting shots support gem"
	power_base = 1 //1 extra projectile
	power_per_quality = 5/100 //5 extra projectiles per 100 quality
	value = 250

/obj/item/supportgem/projectiles/update_support_stats()
	var/projectile_count = power_base + (quality-100)*power_per_quality
	support_stats = list(
		"additional_projectiles" = projectile_count,
		"mana_cost_multiplier" = 3,
		"bullet_spread" = 3
	)
	support_desc = "Increases projectile count by <b>[projectile_count]</b>.\nIncreases mana cost by 200%.\nIncreases projectile spread by 200%."


/obj/item/supportgem/spread
	name = "focused shots support gem"
	power_base = 0.5 //50%
	power_per_quality = 0.2 / 100 //20% less spread per 100 quality
	value = 250

/obj/item/supportgem/spread/update_support_stats()
	var/bullet_spread = min(0.75,power_base + (quality-100)*power_per_quality)
	support_stats = list(
		"bullet_spread" = 1 - bullet_spread,
		"inaccuracy_modifier" = 1.25,
		"projectile_speed" = 1.25,
		"shoot_delay" = 2
	)
	support_desc = "Decreases projectile spread by <b>[bullet_spread*100]</b>%.\nIncreases projectile accuracy by 25%.\nIncreases projectile speed by 25%.\nIncreases shoot delay by 100%."
