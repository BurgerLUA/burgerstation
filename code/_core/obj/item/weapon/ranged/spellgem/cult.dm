/obj/item/weapon/ranged/spellgem/cult
	name = "desecrated spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots an unholy hand that spread desecrated ground in a short distance."
	icon_state = "damage"
	color = "#7F0000"

	rarity = RARITY_RARE

	shoot_delay = 10

	bullet_count = 3
	projectile_speed = TILE_SIZE*0.6 - 1
	spread_per_shot = 20

	company_type = "Blood Cultists"

	projectile = /obj/projectile/magic/cultist
	ranged_damage_type = /damagetype/ranged/magic/cult

	shoot_sounds = list('sound/weapons/magic/repulse_fast.ogg')

	color = "#7F0000"
	color_2 = "#FF0000"
	color_3 = "#000000"

	value = 800
