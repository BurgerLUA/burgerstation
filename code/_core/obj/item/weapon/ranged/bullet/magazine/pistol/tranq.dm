/obj/item/weapon/ranged/bullet/magazine/pistol/tranq
	name = "\improper 11.43mm Tranq Pistol"
	desc = "For pacifists."
	desc_extended = "A versatile silenced tranquilver pistol that fires specialised subsonic 11.43mm chemical rounds. The weapon must be cycled manually after firing. The laser pointer attached makes it extremely precise."
	icon = 'icons/obj/item/weapons/ranged/pistol/tranq.dmi'
	icon_state = "inventory"
	value = 900

	tier = 3

	movement_spread_base = 0
	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/silenced/fire_alt.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 6

	heat_max = 0.01

	bullet_length_min = 23
	bullet_length_best = 25
	bullet_length_max = 26

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	shoot_alert = ALERT_LEVEL_NONE



/obj/item/weapon/ranged/bullet/magazine/pistol/tranq/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/tranq/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))