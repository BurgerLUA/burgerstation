/obj/item/weapon/ranged/spellgem/magic_missile
	name = "magic missile spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a target seeking magic missile ."
	icon_state = "damage"

	cost_mana = 18
	shoot_delay = 10

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/magic_missile
	ranged_damage_type = /damagetype/ranged/magic/magic_missile

	color = "#BAE4FF"
	color_2 = "#FFFFFF"
	color_3 = "#87AAC1"

	shoot_sounds = list('sound/weapons/magic/magic_missile.ogg')
	value = 800