/obj/item/weapon/ranged/spellgem/chaos
	name = "chaos spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots 9 chaotic moving orbs."
	icon_state = "damage"

	rarity = RARITY_MYTHICAL

	shoot_delay = 2

	bullet_count = 9
	projectile_speed = TILE_SIZE*0.2 - 1
	spread_per_shot = 20

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	color = "#9733FF"
	color_2 = "#B297FF"
	color_3 = "#000000"

	value = 200