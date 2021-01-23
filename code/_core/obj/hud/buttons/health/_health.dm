/obj/hud/button/health/
	name = "Health Element"
	desc = "This is an element for health."
	var/id = "none"

	icon = 'icons/obj/health/base.dmi'

	screen_loc = "CENTER,CENTER"

	layer = LAYER_HUD
	plane = PLANE_HUD

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_living(caller))
		var/mob/living/L = caller
		for(var/k in L.get_damage_description(caller,FALSE))
			caller.to_chat(k)

	return ..()

/obj/hud/button/health/proc/update_stats(var/mob/living/M)
	update_sprite()
	return TRUE

/obj/hud/button/health/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.remove_health_element(src)

	owner = desired_owner

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.add_health_element(src)
		update_stats(L)

	return TRUE