/obj/hud/button/health/
	name = "Health Element"
	desc = "This is an element for health."
	id = "none"

	icon = 'icons/obj/health/base.dmi'
	icon_state = "base"

	screen_loc = "CENTER,CENTER"

	layer = LAYER_HUD
	plane = PLANE_HUD

	user_colors = FALSE //Custom code here.

/obj/hud/button/health/bar/
	var/bar_color = "#ffffff"
	var/min = 0
	var/max = 100
	var/current = 0
	var/overflow = 0

/obj/hud/button/health/proc/update_stats(var/mob/living/M)
	update_icon()
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

/obj/hud/button/health/bar/update_icon()

	if(max == 0)
		return

	icon = null

	var/icon/base = new/icon(initial(icon),icon_state = icon_state)
	var/icon/bar = new/icon(initial(icon),icon_state = "bar")
	var/start_x = 1
	var/end_x = 32
	var/start_y = 1
	var/end_y = 1 + floor(Clamp((current+min(0,overflow))/max,0,1)*29) //TODO: There is something wrong with this causing the icon to spaz out.

	bar.Blend(bar_color,ICON_MULTIPLY)
	bar.Crop(start_x,start_y,end_x,end_y)

	base.Blend(bar,ICON_OVERLAY)

	if(overflow < 0)
		var/icon/bar_changing = new/icon(initial(icon),icon_state = "bar")
		var/start_x_changing = 1
		var/end_x_changing = 32
		var/start_y_changing = end_y
		var/end_y_changing = end_y + floor(Clamp(-overflow/max,0,1)*28)

		bar_changing.Crop(start_x_changing,start_y_changing,end_x_changing,end_y_changing)
		bar_changing.Crop(1,1,32,32)
		bar_changing.Shift(NORTH,end_y)

		swap_colors(base)

		base.Blend(bar_changing,ICON_OVERLAY)

	icon = base

	..()

/obj/hud/button/health/bar/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	desc_extended = "Your health. When this reaches 0, you die. This value can be raised by increasing your vitality."
	min = 0
	bar_color = "#ff0000"

	screen_loc = "RIGHT-0.25,BOTTOM+1.1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/hp/get_examine_text(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] health.")

/obj/hud/button/health/bar/hp/update_stats(var/mob/living/M)

	if(!M.health)
		return FALSE

	min = 0
	max = floor(M.health.health_max)
	current = floor(M.health.health_current)
	overflow = -M.health.damage_soft_total
	return ..()

/obj/hud/button/health/bar/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close your are to physical fatigue."
	desc_extended = "Your stamina. If this value is too low, some actions can't be performed. When it is 0, you will likely collapse from exhaution. This value can be raised by increasing your endurance."
	min = 0
	bar_color = "#00ff00"

	screen_loc = "RIGHT,BOTTOM+1.1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/sp/get_examine_text(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] stamina.")

/obj/hud/button/health/bar/sp/update_stats(var/mob/living/M)

	if(!M.health)
		return ..()

	min = 0
	max = floor(M.health.stamina_max)
	current = floor(M.health.stamina_current)
	overflow = M.stamina_regen_buffer
	return ..()

/obj/hud/button/health/bar/mp
	name = "mana"
	id = "mana"
	desc = "Approximately how close you are to mental fatigue."
	desc_extended = "Your mana. Determines which spells you can cast and how often. When it is 0, you will likely collapse from mental exhaution. This value can be raised by increasing your willpower."
	min = 0
	bar_color = "#0000ff"

	screen_loc = "RIGHT+0.25,BOTTOM+1.1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/mp/get_examine_text(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] mana.")

/obj/hud/button/health/bar/mp/update_stats(var/mob/living/M)

	if(!M.health)
		return ..()

	min = 0
	max = floor(M.health.mana_max)
	current = floor(M.health.mana_current)
	overflow = M.mana_regen_buffer
	..()