/obj/health/
	name = "Health Element"
	desc = "This is an element for health."
	id = "none"

	icon = 'icons/obj/health/base.dmi'
	icon_state = "base"

	screen_loc = "CENTER,CENTER"

	var/bar_color = "#ffffff"
	var/min = 0
	var/max = 100
	var/current = 0
	var/offset = 2

	var/mob/living/owner

/obj/health/proc/update_stats(var/mob/living/M)
	return

/obj/health/proc/update_owner(var/mob/living/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_health_element(src)

	owner = desired_owner
	owner.add_health_element(src)

	update_icon()

	return TRUE

/obj/health/update_icon()

	var/icon/base = icon(initial(icon),icon_state = icon_state)
	var/icon/bar = icon(initial(icon),icon_state = "bar")
	var/start_x = 0
	var/end_x = 32
	var/start_y = 0

	if(max == 0)
		return

	var/end_y = offset + (current/max)*(32-offset)

	bar.Blend(bar_color,ICON_MULTIPLY)
	bar.Crop(start_x,start_y,end_x,end_y)

	base.Blend(bar,ICON_OVERLAY)

	icon = base

	..()

/obj/health/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	min = 0
	bar_color = "#ff0000"

	screen_loc = "RIGHT-0.25,BOTTOM"

/obj/health/hp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.health_max)
	current = floor(M.health_current)
	name = "Health Bar ([current]/[max])"

/obj/health/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close you are to death."
	min = 0
	bar_color = "#00ff00"

	screen_loc = "RIGHT,BOTTOM"

/obj/health/sp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.stamina_max)
	current = floor(M.stamina_current)
	name = "Stamina Bar ([current]/[max])"

/obj/health/mp
	name = "mana"
	id = "mana"
	desc = "Approximately how close you are to death."
	min = 0
	bar_color = "#0000ff"

	screen_loc = "RIGHT+0.25,BOTTOM"

/obj/health/mp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.mana_max)
	current = floor(M.mana_current)
	name = "Mana Bar ([current]/[max])"