/obj/item/weapon/ranged/bullet/revolver/
	open = FALSE

/obj/item/weapon/ranged/bullet/revolver/click_self(var/atom/caller)
	open = !open

	if(open)
		eject_spent_casings(caller, caller.loc)
		caller.to_chat(span("notice","You open \the [src]. It contains [get_ammo_count()] bullet\s."))
	else
		caller.to_chat(span("notice","You close \the [src]."))

	update_icon()

/obj/item/weapon/ranged/bullet/revolver/detective
	name = "\improper .38 revolver"
	desc = "The detective's trusty sidearm. Uses .38 revolver rounds."
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/revolver/
	ranged_damage_type = /damagetype/ranged/revolver_38
	damage_type = /damagetype/sword/

	bullet_speed = 31
	shoot_delay = 10

	automatic = FALSE

	bullet_capacity = 6

	bullet_type = ".38"
	icon_state_open = "inventory_open"

	shoot_sounds = list('sounds/weapon/ranged/gunshot_strong.ogg')



