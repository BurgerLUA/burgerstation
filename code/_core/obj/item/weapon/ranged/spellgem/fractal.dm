/obj/item/weapon/ranged/spellgem/fractal
	name = "fractal spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots two spiraling firebrands that homes in on a nearby enemy target."
	icon_state = "damage"

	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE - 1

	burst_delay = SECONDS_TO_DECISECONDS(1)
	max_bursts = 2

	projectile = /obj/projectile/magic/fractal
	ranged_damage_type = /damagetype/ranged/magic/fractal

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	color = "#E55B00"
	color_2 = "#303030"
	color_3 = "#FFFFFF"

	value = 800