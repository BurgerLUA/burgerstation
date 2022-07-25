/obj/hud/button/stat/
	name = "stat element"
	desc = "Stat information."
	var/id

	screen_loc = "CENTER,CENTER"

	layer = LAYER_HUD
	plane = PLANE_HUD
	flags_hud = FLAG_HUD_MOB

/obj/hud/button/stat/proc/update()
	return FALSE //Returning false means remove it from update. Returning true means keep it updating.


/obj/hud/button/stat/update_owner(var/mob/desired_owner)

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.remove_stat_element(src)

	. = ..()

	if(owner && is_living(owner))
		var/mob/living/L = owner
		L.add_stat_element(src)

	if(.)
		update_sprite()