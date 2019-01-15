/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

/obj/item/weapon/ranged/bullet/magazine/click_self(var/atom/caller)
	caller.to_chat(span("notice","You cock \the [src]."))
	eject_stored_bullets(caller,caller.loc)
	load_bullet_from_magazine()
	var/area/A = get_area(caller.loc)
	play_sound('sounds/weapon/misc/sawclose.ogg',all_mobs,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	return TRUE

/obj/item/weapon/ranged/bullet/magazine/handle_ammo(var/mob/caller)
	..()
	eject_spent_casings(caller,caller.loc)