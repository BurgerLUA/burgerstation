/obj/item/weapon/ranged/spellgem/crystal
	name = "crystal spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots arcane crystals at a rapid rate."
	icon_state = "damage"

	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.8 - 1

	projectile = /obj/projectile/magic/crystal
	ranged_damage_type = /damagetype/ranged/magic/crystal

	shoot_sounds = list('sound/weapons/magic/zap.ogg')

	color = "#FF7FED"
	color_2 = "#7F006E"
	color_3 = "#FFAEB6"

	value = 600