/obj/item/weapon/ranged/spellgem/f50cal
	name = ".357 spell gem"
	desc = "The source of all... lead?"
	desc_extended = "Shoots two homing .357 bullets at a time. Wicked."
	icon_state = "damage"

	rarity = RARITY_LEGENDARY

	shoot_delay = 1

	bullet_count = 1
	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	burst_delay = 2
	max_bursts = 2

	projectile = /obj/projectile/bullet/firearm/pistol/smart/ignore_requirements
	ranged_damage_type = /damagetype/ranged/bullet/revolver_357

	shoot_sounds = list('sound/weapons/ranged/pistol/357_traitor/shoot.ogg')

	color = "#FDDFCC"
	color_2 = "#2333FF"
	color_3 = "#F38C22"

	value = 2700

