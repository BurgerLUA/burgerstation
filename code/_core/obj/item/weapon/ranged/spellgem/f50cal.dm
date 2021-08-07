/obj/item/weapon/ranged/spellgem/f50cal
	name = ".50 caliber spell gem"
	desc = "The source of all... lead?"
	desc_extended = "After the Third Mage War, Desert Eagles were largely replaced with this particular shiny rock that acts just like one without needing bullets."
	icon_state = "damage"

	cost_mana = 12
	shoot_delay = 8

	bullet_count = 1
	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE
	spread_per_shot = 8

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/pistol_50

	shoot_sounds = list('sound/weapons/50/shoot.ogg')

	color = "#FDDFCC"
	color_2 = "#2333FF"
	color_3 = "#F38C22"

	value = 2700
