/proc/is_safe_to_remove(var/atom/A)

	if(istype(A,/obj/overlay/)) //Ignore overlays.
		return TRUE

	if(A.qdeleting)
		return FALSE

	if(is_living(A))
		var/mob/living/L = A
		if(L.client || (L.ckey_last && !L.dead))
			return FALSE
	else if(ismob(A))
		return FALSE

	if(!(istype(A,/obj/item/) || istype(A,/obj/structure/) || istype(A,/obj/hud/inventory)))
		return FALSE

	for(var/atom/A2 in A.contents)
		if(!is_safe_to_remove(A2))
			return FALSE

	return TRUE