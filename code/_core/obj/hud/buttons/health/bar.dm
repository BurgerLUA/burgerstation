/obj/hud/button/health/bar/
	name = "health bar"
	icon = 'icons/obj/health/base.dmi'
	icon_state = ""
	color = "#FFFFFF"
	var/min = 0
	var/max = 100
	var/current = 0

/obj/hud/button/health/New(var/desired_loc)
	update_sprite()
	. = ..()
	update_stats()
	return .

/obj/hud/button/health/bar/update_stats(var/mob/living/M)
	var/math = FLOOR((current/max) * 28, 1)
	icon_state = "bar_[clamp(math,0,28)]"
	return TRUE

/obj/hud/button/health/bar/update_underlays()
	var/icon/base = new/icon(initial(icon),"base")
	swap_colors(base)
	var/image/I = new/image(base)
	I.appearance_flags = RESET_COLOR
	add_underlay(I)
	return ..()

/obj/hud/button/health/bar/hp
	name = "health"
	id = "health"
	desc = "Approximately how close you are to death."
	desc_extended = "Your health. When this reaches 0, you die. This value can be raised by increasing your vitality."
	min = 0
	color = "#FF0000"

	screen_loc = "RIGHT-0.25,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/hp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] health.")

/obj/hud/button/health/bar/hp/update_stats(var/mob/living/M)

	if(!M || !M.health)
		return ..()

	min = 0
	max = FLOOR(M.health.health_max, 1)
	current = FLOOR(M.health.health_current - M.health.get_loss(PAIN), 1)

	return ..()

/obj/hud/button/health/bar/sp
	name = "stamina"
	id = "stamina"
	desc = "Approximately how close your are to physical fatigue."
	desc_extended = "Your stamina. If this value is too low, some actions can't be performed. When it is 0, you will likely collapse from exhaution. This value can be raised by increasing your endurance."
	min = 0
	color = "#00ff00"

	screen_loc = "RIGHT,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/sp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] stamina.")

/obj/hud/button/health/bar/sp/update_stats(var/mob/living/M)

	if(!M || !M.health)
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
	color = "#0000ff"

	screen_loc = "RIGHT+0.25,CENTER-1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/health/bar/mp/get_examine_list(var/mob/examiner)
	return ..() + div("notice","You have [current] out of [max] mana.")

/obj/hud/button/health/bar/mp/update_stats(var/mob/living/M)

	if(!M || !M.health)
		return ..()

	min = 0
	max = FLOOR(M.health.mana_max, 1)
	current = FLOOR(M.health.mana_current, 1)

	return ..()