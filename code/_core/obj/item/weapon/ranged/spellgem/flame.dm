/obj/item/weapon/ranged/spellgem/flame
	name = "flame stream spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a stream of igniting flames."
	icon_state = "damage"

	rarity = RARITY_RARE

	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/lesser_fire
	ranged_damage_type = /damagetype/ranged/magic/flame

	shoot_sounds = list('sound/weapons/magic/firestream.ogg')

	color = "#FF934A"
	color_2 = "#FF521F"
	color_3 = "#FF521F"

	value = 800

	spread_per_shot = 16