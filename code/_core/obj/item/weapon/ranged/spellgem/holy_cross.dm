/obj/item/weapon/ranged/spellgem/holy_cross
	name = "holy cross spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a holy cross. Always deals critical strikes against bosses."
	icon_state = "damage"

	rarity = RARITY_COMMON

	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.4 - 1

	projectile = /obj/projectile/magic/holy_cross
	ranged_damage_type = /damagetype/ranged/magic/holy_cross

	shoot_sounds = list('sound/weapons/magic/creation.ogg')

	color = "#FFD800"
	color_2 = "#917E1F"
	color_3 = "#7F0000"

	value = 800
