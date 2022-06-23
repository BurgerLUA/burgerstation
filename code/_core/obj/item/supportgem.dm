/obj/item/supportgem
	name = "support gem"
	desc = "Not ripping off another game, I swear."
	desc_extended = "A magical gem that supports socketed skills in wands."

	icon = 'icons/obj/item/spellgem.dmi'
	icon_state = "support"

	var/support_category
	var/support_desc
	var/mana_multiplier = 1

	var/power_base = 1
	var/power_per_quality = 0 //Above 100.

	var/math_type = "addition" //addition, multiplication, division, or subtraction
	//Div is a misnomer. The math is value = value - (value*p)

	quality = 100

	value = 0

/obj/item/supportgem/proc/get_power()
	return power_base + (quality-100)*power_per_quality

/obj/item/supportgem/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice",support_desc)


/obj/item/supportgem/damage
	support_category = "damage"

/obj/item/supportgem/damage/addition
	name = "support gem - additional damage"
	mana_multiplier = 2
	math_type = "addition"
	support_desc = "Increases impact damage dealt by %p."
	power_base = 5
	power_per_quality = 0.1
	value = 250


/obj/item/supportgem/damage/multiplication
	name = "support gem - multiplicative damage"
	mana_multiplier = 2
	math_type = "multiplication"
	support_desc = "Multiplies impact damage dealt by %p_cent."
	power_base = 1.2
	power_per_quality = 0.01
	value = 250

/obj/item/supportgem/cost
	support_category = "cost"

/obj/item/supportgem/cost/subtraction
	name = "support gem - subtracted cost"
	mana_multiplier = 1
	math_type = "subtraction"
	support_desc = "Decreases the casting cost by %p."
	power_base = 4
	power_per_quality = 0.5
	value = 250

/obj/item/supportgem/cost/division
	name = "support gem - divided cost"
	mana_multiplier = 1
	math_type = "division"
	support_desc = "Decreases the casting cost by %p_cent."
	power_base = 0.25
	power_per_quality = 0.01
	value = 250

/obj/item/supportgem/projectiles
	support_category = "projectiles"

/obj/item/supportgem/projectiles/addition
	name = "support gem - increased projectile count"
	mana_multiplier = 3
	math_type = "addition"
	support_desc = "Increases the amount of projectiles created by %p."
	power_base = 1
	power_per_quality = 0.2
	value = 250

/obj/item/supportgem/spread
	support_category = "spread"

/obj/item/supportgem/spread/division
	name = "support gem - reduced spread"
	mana_multiplier = 1.25
	math_type = "division"
	support_desc = "Decreases base spread by %p_cent."
	power_base = 0.5
	power_per_quality = 0.1
	value = 250
