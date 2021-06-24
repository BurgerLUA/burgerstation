/obj/item/weapon/ranged/spellgem/blackflame
	name = "blackflame spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a single high-damage unholy fireball."
	icon_state = "damage"

	cost_mana = 40
	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.9 - 1

	projectile = /obj/projectile/magic/blackflame
	ranged_damage_type = /damagetype/ranged/magic/blackflame

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#404040"
	color_2 = "#FFFFFF"
	color_3 = "#000000"

	value = 800