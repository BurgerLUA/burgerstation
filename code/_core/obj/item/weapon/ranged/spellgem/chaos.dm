/obj/item/weapon/ranged/spellgem/chaos
	name = "chaos spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots chaotic energy in a circle."
	icon_state = "damage"

	cost_mana = 7
	shoot_delay = 14

	bullet_count = 7
	projectile_speed = TILE_SIZE*0.2 - 1
	spread_per_shot = 20

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	color = "#9733FF"
	color_2 = "#B297FF"
	color_3 = "#000000"

	value = 200
