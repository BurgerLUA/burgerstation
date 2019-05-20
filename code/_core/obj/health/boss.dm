/obj/button/boss_health
	name = "Boss Health"
	desc = "Health bar for bosses"
	id = "boss_health"

	icon = 'icons/hud/boss_bar.dmi'
	icon_state = "frame"

	screen_loc = "CENTER,TOP-0.5"

	var/bar_color = "#ffffff"
	var/min = 0
	var/max = 100
	var/current = 0

	layer = LAYER_HUD
	plane = PLANE_HUD

	var/mob/living/target_boss

	alpha = 0

/obj/button/boss_health/proc/clear_boss()
	target_boss = null
	update_stats()

/obj/button/boss_health/proc/update_stats()

	if(!target_boss)
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(4))
		mouse_opacity = 0
		return FALSE
	else
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(2))
		mouse_opacity = 2

	min = 0
	max = target_boss.health_max
	current = max - target_boss.get_total_loss()
	update_icon()

/obj/button/boss_health/update_icon()

	if(max == 0)
		return

	var/icon/base = new /icon(initial(icon),icon_state = icon_state)
	var/icon/bar = new /icon(initial(icon),icon_state = "bar")
	if(target_boss && target_boss.id)
		var/icon/name = new /icon(initial(icon),icon_state = target_boss.id)
		base.Blend(name,ICON_OVERLAY)

	var/start_x = 3
	var/end_x = 3 + (current/max)*(90)
	var/start_y = 1
	var/end_y = 32

	bar.Blend(bar_color,ICON_MULTIPLY)
	bar.Crop(start_x,start_y,end_x,end_y)

	base.Blend(bar,ICON_OVERLAY)

	icon = base

	..()

