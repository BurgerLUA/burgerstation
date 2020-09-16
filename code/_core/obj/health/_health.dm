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
	if(owner && caller.client)
		caller.client.examine(owner)
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

/obj/hud/button/health/bar/
	icon_state = "base"
	var/bar_color = "#ffffff"
	var/min = 0
	var/max = 100
	var/current = 0

/obj/hud/button/health/bar/update_overlays()

	if(max)
		var/math = FLOOR((current/max) * 28, 1)
		var/image/bar = new/image(initial(icon),icon_state = "bar_[math]")
		bar.color = bar_color
		add_overlay(bar)

	return ..()

/obj/hud/button/health/bar/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	desc_extended = "Your health. When this reaches 0, you die. This value can be raised by increasing your vitality."
	min = 0
	bar_color = "#ff0000"

	screen_loc = "RIGHT-0.25,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/hp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] health.")

/obj/hud/button/health/bar/hp/update_stats(var/mob/living/M)

	if(!M.health)
		return FALSE

	min = 0
	max = FLOOR(M.health.health_max, 1)
	current = FLOOR(M.health.health_current, 1)
	return ..()

/obj/hud/button/health/bar/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close your are to physical fatigue."
	desc_extended = "Your stamina. If this value is too low, some actions can't be performed. When it is 0, you will likely collapse from exhaution. This value can be raised by increasing your endurance."
	min = 0
	bar_color = "#00ff00"

	screen_loc = "RIGHT,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/sp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] stamina.")

/obj/hud/button/health/bar/sp/update_stats(var/mob/living/M)

	if(!M.health)
		return ..()

	min = 0
	max = FLOOR(M.health.stamina_max, 1)
	current = FLOOR(M.health.stamina_current, 1)
	return ..()

/obj/hud/button/health/bar/mp
	name = "mana"
	id = "mana"
	desc = "Approximately how close you are to mental fatigue."
	desc_extended = "Your mana. Determines which spells you can cast and how often. When it is 0, you will likely collapse from mental exhaution. This value can be raised by increasing your willpower."
	min = 0
	bar_color = "#0000ff"

	screen_loc = "RIGHT+0.25,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/mp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] mana.")

/obj/hud/button/health/bar/mp/update_stats(var/mob/living/M)

	if(!M.health)
		return ..()

	min = 0
	max = FLOOR(M.health.mana_max, 1)
	current = FLOOR(M.health.mana_current, 1)
	..()