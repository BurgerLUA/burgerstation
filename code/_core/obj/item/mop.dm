/obj/item/mop
	name = "mop"
	icon = 'icons/obj/item/mop.dmi'
	desc = "Finally, something to clean with."
	desc_extended = "A very robust mop designed to wash away spills."

	damage_type = /damagetype/melee/club/broom

	size = SIZE_3

	reagents = /reagent_container/mop

	value = 150

	weight = 2


/obj/item/mop/click_on_object(mob/caller as mob,atom/object,location,control,params)

	if(is_container(object) && object.reagents)
		var/obj/item/container/C = object
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(C.reagents.volume_current <= 0)
			caller.to_chat(span("warning","\The [object.name] is empty!"))
			return TRUE
		var/turf/T = get_turf(C)
		var/space_left = C.reagents.volume_max - C.reagents.volume_current
		var/overflow = src.reagents.volume_current - space_left
		if(overflow > 0)
			C.reagents.splash(caller,T,overflow,1)
		src.reagents.transfer_reagents_to(C.reagents,min(space_left,src.reagents.volume_current),should_update = FALSE, caller = caller)
		C.reagents.transfer_reagents_to(src.reagents,src.reagents.volume_max, caller = caller)
		play_sound('sound/effects/watersplash.ogg',T,range_max=VIEW_RANGE)
		return TRUE

	if(object.plane >= PLANE_HUD)
		return ..()

	var/turf/T = get_turf(object)

	if(T)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(4)
		caller.set_dir(get_dir(caller,T))
		var/damagetype/DT = SSdamagetype.all_damage_types[damage_type]
		DT.do_attack_visuals(caller,get_turf(caller),T,T,0)
		if(src.reagents.volume_current <= 0)
			caller.to_chat(span("warning","\The [src.name] is dry!"))
			return TRUE
		var/list/valid_sounds = list(
			'sound/effects/water_wade1.ogg',
			'sound/effects/water_wade2.ogg',
			'sound/effects/water_wade3.ogg',
			'sound/effects/water_wade4.ogg'
		)
		play_sound(pick(valid_sounds),T,range_max=VIEW_RANGE)
		src.reagents.splash(caller,T,5,TRUE,1)
		return TRUE

	return ..()