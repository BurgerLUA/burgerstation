/obj/item/weapon/ranged/spellgem/unholy_skull
	name = "unholy skull spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots an unholy skull that tracks targets."
	icon_state = "damage"

	cost_mana = 25
	shoot_delay = 10

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.3 - 1

	projectile = /obj/projectile/magic/unholy_skull
	ranged_damage_type = /damagetype/ranged/magic/unholy_skull

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#303030"
	color_2 = "#7F0000"
	color_3 = "#7F0000"

	value = 800