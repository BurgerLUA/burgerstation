/obj/item/weapon/ranged/spellgem/crystal
	name = "crystal spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a burst of arcane crystals at a rapid rate that penetrates several targets."
	icon_state = "damage"

	rarity = RARITY_MYTHICAL

	burst_delay = 15
	max_bursts = 4

	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/crystal
	ranged_damage_type = /damagetype/ranged/magic/crystal

	shoot_sounds = list('sound/weapons/magic/zap.ogg')

	color = "#FF7FED"
	color_2 = "#7F006E"
	color_3 = "#FFAEB6"

	value = 600

