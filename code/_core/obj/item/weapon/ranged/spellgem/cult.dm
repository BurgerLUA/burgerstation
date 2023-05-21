/obj/item/weapon/ranged/spellgem/cult
	name = "desecrated spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots unholy tendrils that spread desecrated ground."
	icon_state = "damage"
	color = "#7F0000"

	shoot_delay = 10

	bullet_count = 2
	projectile_speed = TILE_SIZE*0.3 - 1

	company_type = "Blood Cultists"

	projectile = /obj/projectile/magic/cultist
	ranged_damage_type = /damagetype/ranged/magic/cult

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	color = "#7F0000"
	color_2 = "#FF0000"
	color_3 = "#000000"

	value = 800

/obj/item/weapon/ranged/spellgem/cult/get_base_spread()
	return 0.07