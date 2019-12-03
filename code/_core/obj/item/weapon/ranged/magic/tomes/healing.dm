/obj/item/weapon/ranged/magic/tome/heal
	name = "tome of healing"
	desc = "Wounds-B-Gone"
	desc_extended = "Costs mana to use. Those in a 3x3 area are affected by the heal, including the caster."
	cost_mana = 50

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/healing.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/bullet/mass_heal

	shoot_sounds = list('sounds/weapons/magic/heal.ogg')

	projectile_speed = 1

/obj/item/weapon/ranged/magic/tome/heal/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/magic/tome/heal/get_skill_spread(var/mob/living/L) //Base spread
	return 0