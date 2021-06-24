/obj/item/weapon/ranged/spellgem/holy_cross
	name = "holy cross spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a holy cross that deals extra damage to unholy creatures and causes them to explode on death."
	icon_state = "damage"

	cost_mana = 30
	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.4 - 1

	projectile = /obj/projectile/magic/holy_cross
	ranged_damage_type = /damagetype/ranged/magic/holy_cross

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#FFD800"
	color_2 = "#917E1F"
	color_3 = "#7F0000"

	value = 800