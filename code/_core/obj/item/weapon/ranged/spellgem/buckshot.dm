/obj/item/weapon/ranged/spellgem/buckshot
	name = "buckshot spell gem"
	desc = "The source of all... lead?"
	desc_extended = "Shoots buckshot. Wait, is this just a magic shotgun?"
	icon_state = "damage"

	rarity = RARITY_UNCOMMON

	shoot_delay = 12

	bullet_count = 6
	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE
	spread_per_shot = 5

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	ranged_damage_type = /damagetype/ranged/bullet/shotgun_12

	shoot_sounds = list('sound/weapons/ranged/shotgun/doom/shoot.ogg')

	color = "#B0B0CC"
	color_2 = "#CCB0B0"
	color_3 = "#000000"

	value = 2700
