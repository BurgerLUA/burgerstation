/obj/item/weapon/ranged/bullet/pump/hunting_rifle
	name = "\improper 7.62mm hunting rifle"
	desc = "Originally Russian, now exploited and sold by proud Space Americans for use in space hunting."
	icon = 'icons/obj/items/weapons/ranged/bolt_action.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 5

	bullet_type = "7.62"

	shoot_sounds = list('sounds/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE

	view_punch = 12

	pump_sound = 'sounds/weapons/gun_slide3.ogg'

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_5
	weight = WEIGHT_4

/obj/item/weapon/ranged/bullet/pump/hunting_rifle/get_static_spread() //Base spread
	if(!wielded)
		return 0.01
	return 0

/obj/item/weapon/ranged/bullet/pump/hunting_rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.01 - (0.01 * L.get_skill_power(SKILL_RANGED))