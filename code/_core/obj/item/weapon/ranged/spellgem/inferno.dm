/obj/item/weapon/ranged/spellgem/inferno
	name = "inferno spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a wad of fire that spreads on hit."
	icon_state = "damage"

	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.4 - 1

	projectile = /obj/projectile/magic/inferno
	ranged_damage_type = /damagetype/ranged/magic/inferno

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#FF6A00"
	color_2 = "#FFD800"
	color_3 = "#FFB200"

	value = 800