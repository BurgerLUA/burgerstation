/mob/living/simple/gutlunch
	name = "gutlunch"
	desc = "Nature's vacuum cleaners."
	desc_extended = "A wild lavaland species whose diet consists of iron, carbon, and calcium from rocks and minerals. Known to eat just about anything, including corpses."
	icon = 'icons/mob/living/simple/gutlunch.dmi'
	icon_state = "1"

	loyalty_tag = "Gutshank"

/mob/living/simple/gutlunch/post_move(var/atom/old_loc)
	. = ..()
	if(!dead && loc && (!ai || !ai.objective_attack) && isturf(loc))
		consume_turf(loc)

/mob/living/simple/gutlunch/update_icon()
	icon = initial(icon)
	if(dead)
		icon_state = "dead"
	else
		var/eaten_length = length(contents)
		icon_state = "[clamp(CEILING(eaten_length/5,1),0,3)]"
	return TRUE

/mob/living/simple/gutlunch/post_death()
	. = ..()
	if(length(contents))
		var/turf/T = get_turf(src)
		if(T)
			T.visible_message(span("notice","The contents of \the [src.name] spill out!"))
			var/list/valid_turfs = list(T)
			for(var/k in DIRECTIONS_ALL)
				var/turf/GS = get_step(T,k)
				if(GS && GS != T)
					valid_turfs += GS
			for(var/k in contents)
				var/atom/movable/M = k
				var/turf/PT = pick(valid_turfs)
				M.force_move(PT)
	update_sprite()

/mob/living/simple/gutlunch/proc/consume_turf(var/turf/T)
	. = FALSE
	for(var/k in T.contents)
		if(is_item(k))
			var/obj/item/I = k
			if(I.qdeleting)
				continue
			if(I.get_value() < 100)
				qdel(I)
			else
				I.force_move(src)
			. = TRUE
		else if(is_living(k))
			var/mob/living/L = k
			if(!L.dead)
				continue
			if(L.is_player_controlled())
				continue
			if(!(L.override_butcher || length(L.butcher_contents)) || !L.can_be_butchered())
				continue
			L.on_butcher(src)
			. = TRUE
	if(.)
		play_sound(T,'sound/effects/gutlunch_eat.ogg')
		T.visible_message(span("warning","\The [src.name] eats up everything on \the [T.name]!"))
		update_sprite()




