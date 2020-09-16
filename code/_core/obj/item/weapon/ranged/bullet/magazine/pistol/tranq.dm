/obj/item/weapon/ranged/bullet/magazine/pistol/tranq
	name = "\improper 11.43mm Tranq Pistol"
	desc = "For pacifists."
	desc_extended = "A versatile silenced tranquilver pistol that fires specialised subsonic 11.43mm chemical rounds. The weapon must be cycled manually after firing. The laser pointer attached makes it extremely precise."
	icon = 'icons/obj/item/weapons/ranged/pistol/tranq.dmi'
	icon_state = "inventory"
	value = 400

	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/silenced/fire_alt.ogg')

	can_wield = FALSE

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_PISTOL

	size = SIZE_2

	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 23
	bullet_length_best = 25
	bullet_length_max = 26

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	shoot_alert = ALERT_LEVEL_NONE

	inaccuracy_modifer = 0.25

/obj/item/weapon/ranged/bullet/magazine/pistol/tranq/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/tranq/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))