/obj/item/weapon/ranged/energy/chronogun
	name = "chrono gun"
	desc = "Shoots timey wimey...stuff."
	desc_extended = "A gun that shoots beam that age the opponent's skin until it necrotizes. Somehow not a war crime to use."
	icon = 'icons/obj/item/weapons/ranged/laser/chronogun.dmi'

	projectile = /obj/projectile/bullet/laser/strong
	ranged_damage_type = /damagetype/ranged/laser/chronogun

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 20

	automatic = FALSE

	bullet_color = "#0000FF"

	charge_cost = CELL_SIZE_BASIC / 20

	view_punch = 31

	shoot_sounds = list('sound/weapons/chronogun/fire.ogg')

	heat_per_shot = 0.1
	heat_max = 0.2

	size = SIZE_3


	value = 2000

/obj/item/weapon/ranged/energy/chronogun/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/chronogun/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))