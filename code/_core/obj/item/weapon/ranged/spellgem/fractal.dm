/obj/item/weapon/ranged/spellgem/fractal
	name = "fractal spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a fractal firebrand that forks when it hits living creatures."
	icon_state = "damage"

	cost_mana = 20
	shoot_delay = 2
	burst_delay = 10
	max_bursts = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.25 - 1

	projectile = /obj/projectile/magic/fractal
	ranged_damage_type = /damagetype/ranged/magic/fractal

	shoot_sounds = list('sound/weapons/magic/fractal.ogg')

	color = "#E55B00"
	color_2 = "#303030"
	color_3 = "#FFFFFF"

	value = 800