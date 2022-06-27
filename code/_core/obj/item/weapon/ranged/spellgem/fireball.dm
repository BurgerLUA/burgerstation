/obj/item/weapon/ranged/spellgem/fireball
	name = "fireball spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a single high-damage explosive fireball."
	icon_state = "damage"

	cost_mana = 50
	shoot_delay = 30

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/fireball/explosive
	ranged_damage_type = /damagetype/ranged/magic/fireball

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#FF6A00"
	color_2 = "#FF0000"
	color_3 = "#FFD800"

	value = 800