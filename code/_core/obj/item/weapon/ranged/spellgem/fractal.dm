/obj/item/weapon/ranged/spellgem/fractal
	name = "fractal spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots four spiraling firebrands that homes in on a nearby enemy target."
	icon_state = "damage"

	rarity = RARITY_MYTHICAL

	shoot_delay = 5

	bullet_count = 2
	projectile_speed = TILE_SIZE*0.5 - 1

	spread_per_shot = 40

	burst_delay = SECONDS_TO_DECISECONDS(1)
	max_bursts = 2

	projectile = /obj/projectile/magic/fractal
	ranged_damage_type = /damagetype/ranged/magic/fractal

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	color = "#E55B00"
	color_2 = "#303030"
	color_3 = "#FFFFFF"

	value = 800
