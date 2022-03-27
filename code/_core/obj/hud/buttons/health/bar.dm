/obj/hud/button/health/bar/
	name = "health bar"
	icon = 'icons/obj/health/base.dmi'
	icon_state = ""
	color = "#FFFFFF"
	var/min = 0
	var/max = 100
	var/current = 0
	var/desired = 0

	var/max_state = 28

	var/should_think = FALSE

/obj/hud/button/health/bar/special_think()

	if(desired > current)
		current = min(current+2,desired,max_state)
		. = TRUE
	else if(desired < current)
		current = max(current-2,desired,0)
		. = TRUE
	else
		. = FALSE

	icon_state = "bar_[current]"

/obj/hud/button/health/bar/update_underlays()
	. = ..()
	var/icon/base = new/icon(initial(icon),"base")
	swap_colors(base)
	var/image/I = new/image(base)
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	add_underlay(I)

/obj/hud/button/health/bar/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	desc_extended = "Your health. When this reaches 0, you die. This value can be raised by increasing your vitality."
	min = 0
	color = "#FF0000"

	screen_loc = "RIGHT-0.25,BOTTOM:12+6"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/hp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] health.")

/obj/hud/button/health/bar/hp/update_stats(var/mob/living/M)

	if(!M || !istype(M.health))
		return ..()

	min = 0
	max = M.health.health_max

	var/mod = (M.health.health_current - M.health.get_loss(PAIN))/max
	desired = FLOOR(mod*max_state, 1)

	. = ..()

/obj/hud/button/health/bar/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close your are to physical fatigue."
	desc_extended = "Your stamina. If this value is too low, some actions can't be performed. When it is 0, you will likely collapse from exhaution. This value can be raised by increasing your endurance."
	min = 0
	color = "#00ff00"

	screen_loc = "RIGHT,BOTTOM:12+6"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/sp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] stamina.")

/obj/hud/button/health/bar/sp/update_stats(var/mob/living/M)

	if(!M || !istype(M.health))
		return ..()

	min = 0
	max = M.health.stamina_max

	var/mod = M.health.stamina_current/max
	desired = FLOOR(mod*max_state, 1)

	. = ..()

/obj/hud/button/health/bar/mp
	name = "mana"
	id = "mana"
	desc = "Approximately how close you are to mental fatigue."
	desc_extended = "Your mana. Determines which spells you can cast and how often. When it is 0, you will likely collapse from mental exhaution. This value can be raised by increasing your willpower."
	min = 0
	color = "#0000ff"

	screen_loc = "RIGHT+0.25,BOTTOM:12+6"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/mp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] mana.")

/obj/hud/button/health/bar/mp/update_stats(var/mob/living/M)

	if(!M || !istype(M.health))
		return ..()

	min = 0
	max = M.health.mana_max

	var/mod = M.health.mana_current/max
	desired = FLOOR(mod*max_state, 1)

	. = ..()