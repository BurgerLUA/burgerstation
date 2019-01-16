/obj/item/weapon/ranged/bullet/revolver/dbarrel
	name = "\improper double barrel shotgun"
	desc = "The bartender's trusty double barrel shotgun"
	icon = 'icons/obj/items/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/shotgun/
	ranged_damage_type = /damagetype/ranged/shotgun
	damage_type = /damagetype/sword/

	bullet_speed = 31
	bullet_count = 8
	shoot_delay = 1
	accuracy_loss = 0.25

	automatic = FALSE

	bullet_capacity = 2

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapon/ranged/shotgun.ogg')