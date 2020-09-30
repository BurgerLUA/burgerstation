/obj/item/mop
	name = "mop"
	icon = 'icons/obj/item/mop.dmi'
	desc = "Finally, something to clean with."
	desc_extended = "A very robust mop designed to wash away spills."

	damage_type = /damagetype/melee/club/broom

	size = SIZE_3

	reagents = /reagent_container/mop

	value = 150


/obj/item/mop/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(isobj(object) && object.reagents)
		SPAM_CHECK
		var/turf/T = get_turf(object)
		var/space_left = object.reagents.volume_max - object.reagents.volume_current
		var/overflow = src.reagents.volume_current - space_left
		if(overflow > 0)
			object.reagents.splash(caller,T,overflow)
		src.reagents.transfer_reagents_to(object.reagents,min(space_left,src.reagents.volume_current),should_update = FALSE)
		object.reagents.transfer_reagents_to(src.reagents,src.reagents.volume_max)
		play('sound/effects/watersplash.ogg',T)
		return TRUE

	if(isturf(object))
		caller.set_dir(get_dir(caller,object))
		var/damagetype/DT = all_damage_types[damage_type]
		DT.do_attack_visuals(caller,object,src,object,0)
		var/list/valid_sounds = list(
			'sound/effects/water_wade1.ogg',
			'sound/effects/water_wade2.ogg',
			'sound/effects/water_wade3.ogg',
			'sound/effects/water_wade4.ogg'
		)
		if(src.reagents.volume_current <= 0)
			caller.to_chat(span("warning","\The [src.name] is dry!"))
			return TRUE
		play(pick(valid_sounds),object)
		src.reagents.splash(caller,object,5,silent=TRUE)
		return TRUE

	return ..()