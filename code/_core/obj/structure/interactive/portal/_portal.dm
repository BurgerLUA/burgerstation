/obj/structure/interactive/portal
	name = "strange portal"
	id = null
	desc = "What is inside?"
	icon = 'icons/obj/effects/effects.dmi'
	icon_state = "anom"

/obj/structure/interactive/portal/Crossed(var/atom/movable/O)

	if(!id)
		return ..()

	for(var/obj/structure/interactive/portal/P in world)
		if(P == src)
			continue
		if(P.id == src.id)
			var/list/turf/valid_turfs = list()
			for(var/turf/simulated/floor/T in orange(1,P))
				valid_turfs += T
			O.force_move(pick(valid_turfs))
			if(is_living(O))
				var/mob/living/L = O
				L.add_stun(10)
			break

	return ..()


/obj/structure/interactive/portal/clown
	id = "clown"
