/obj/item/weapon/ranged/bullet/revolver/attack_self(var/atom/caller)
	caller << "HELLO!"
	open = !open
	update_icon()

/obj/item/weapon/ranged/bullet/revolver/detective
	name = ".38 revolver"
	desc = "The detective's trusty sidearm. Uses .38 revolver rounds."
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

	bullet_type = ".38"
	icon_state_open = "inventory_open"

	shoot_sounds = list('sounds/weapon/ranged/gunshot_strong.ogg')


	projectile = /obj/projectile/bullet/revolver/
