/obj/effect/gabber_turf_destruction
	icon = 'icons/obj/effects/gabber_destruction.dmi'
	icon_state = "b1"
	blend_mode = BLEND_ADD

/obj/effect/gabber_turf_destruction/New(var/desired_loc,var/turf/force_turf=null)
	. = ..()
	icon_state = "b[rand(1,5)]"
	var/matrix/M = matrix()
	transform = M
	alpha=0
	animate(src,alpha=100,transform = matrix(),time=3)
	CALLBACK("\ref[src]_destroy_turf",5,src,.proc/destroy_turf,force_turf)

/obj/effect/gabber_turf_destruction/proc/destroy_turf(var/turf/force_turf=null)
	animate(src,alpha=255,time=5)
	animate(alpha=0,time=15)
	icon_state = "r[rand(1,5)]"
	CALLBACK("\ref[src]_destroy_self",20,src,.proc/destroy_self)
	if(is_simulated(loc))
		var/turf/simulated/T = loc
		if(force_turf)
			T.change_turf(force_turf)
		else
			var/turf/simulated/destruction_turf = T.destruction_turf
			if(destruction_turf)
				T.change_turf(destruction_turf)
		for(var/k in T.contents)
			var/atom/movable/M = k
			if(!M.health)
				continue
			if(!M.density)
				continue
			if(is_living(M))
				continue
			if(!M.is_safe_to_delete())
				continue
			M.gib()

/obj/effect/gabber_turf_destruction/proc/destroy_self()
	qdel(src)