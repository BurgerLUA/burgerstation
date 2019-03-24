/obj/button/health/
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

	layer = LAYER_HUD
	plane = PLANE_HUD

/obj/button/health/proc/update_stats(var/mob/living/M)
	update_icon()

/obj/button/health/update_owner(var/mob/desired_owner)

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_health_element(src)

	owner = desired_owner
	owner.add_health_element(src)
	update_stats(owner)

	return TRUE

/obj/button/health/update_icon()

	if(max == 0)
		return

	var/icon/base = icon(initial(icon),icon_state = icon_state)
	var/icon/bar = icon(initial(icon),icon_state = "bar")
	var/start_x = 0
	var/end_x = 32
	var/start_y = 0
	var/end_y = 1 + (current/max)*(28)

	bar.Blend(bar_color,ICON_MULTIPLY)
	bar.Crop(start_x,start_y,end_x,end_y)

	base.Blend(bar,ICON_OVERLAY)

	icon = base

	..()

/obj/button/health/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	desc_extended = "Your health. When this reaches 0, you die. This value can be raised by increasing your vitality."
	min = 0
	bar_color = "#ff0000"

	screen_loc = "RIGHT-0.25,BOTTOM+1.1"

/obj/button/health/hp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.health_max)
	current = floor(M.health_current)
	..()

/obj/button/health/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close your are to physical fatigue."
	desc_extended = "Your stamina. If this value is too low, some actions can't be performed. When it is 0, you will likely collapse from exhaution. This value can be raised by increasing your endurance."
	min = 0
	bar_color = "#00ff00"

	screen_loc = "RIGHT,BOTTOM+1.1"

/obj/button/health/sp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.stamina_max)
	current = floor(M.stamina_current)
	..()

/obj/button/health/mp
	name = "mana"
	id = "mana"
	desc = "Approximately how close you are to mental fatigue."
	desc_extended = "Your mana. Determines which spells you can cast and how often. When it is 0, you will likely collapse from mental exhaution. This value can be raised by increasing your willpower."
	min = 0
	bar_color = "#0000ff"

	screen_loc = "RIGHT+0.25,BOTTOM+1.1"

/obj/button/health/mp/update_stats(var/mob/living/M)
	min = 0
	max = floor(M.mana_max)
	current = floor(M.mana_current)
	..()