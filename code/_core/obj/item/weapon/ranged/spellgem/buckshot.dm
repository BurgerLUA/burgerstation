/obj/item/weapon/ranged/spellgem/buckshot
	name = "buckshot spell gem"
	desc = "The source of all... lead?"
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots buckshot. Is this just a shotgun? Wait hold on....."
	icon_state = "damage"

	cost_mana = 9
	shoot_delay = 12

	bullet_count = 5
	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE
	spread_per_shot = 8

	projectile = /obj/projectile/bullet/firearm/shotgun_pellet
	ranged_damage_type = /damagetype/ranged/bullet/shotgun_12

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	color = "#B0B0CC"
	color_2 = "#CCB0B0"
	color_3 = "#000000"

	value = 2700
