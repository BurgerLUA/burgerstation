/obj/item/broom
	name = "broom"
	icon = 'icons/obj/item/broom.dmi'
	desc = "Make large sweeping statements with this broom."
	desc_extended = "Sweeps all items around the user into a nice tidy tile. Good for garbage collection. Also good for beating people over the head with."

	damage_type = /damagetype/melee/club/broom

	size = SIZE_3

	value = 200

	var/broom_range = 1

/obj/item/broom/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)


	if(object.plane >= PLANE_HUD)
		return ..()

	var/turf/T = get_turf(object)

	if(T)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/broom_limit = 10
		for(var/obj/item/I in oview(T,broom_range))
			CHECK_TICK(50,FPS_SERVER)
			broom_limit--
			if(I.anchored)
				continue
			I.Move(get_step(I,get_dir(I,T)))
			if(broom_limit <= 0)
				break
		return TRUE

	return ..()

/obj/item/broom/magic
	name = "magic broom"
	broom_range = 4
	value = 800
	rarity = RARITY_RARE