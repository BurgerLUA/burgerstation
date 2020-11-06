/obj/hud/button/boss_health
	name = "Boss Health"
	desc = "Health bar for bosses"
	//id = "boss_health"

	icon = 'icons/hud/boss_bar.dmi'
	icon_state = "frame"

	screen_loc = "CENTER-0.5,TOP-1.5"

	var/bar_color = "#ffffff"
	var/min = 0
	var/max = 100
	var/current = 0

	layer = LAYER_HUD
	plane = PLANE_HUD

	var/list/mob/living/target_bosses = list()
	var/mob/living/current_boss

	var/current_boss_music

	alpha = 0
	mouse_opacity = 0

	user_colors = FALSE

	has_quick_function = FALSE

/obj/hud/button/boss_health/Destroy()
	target_bosses.Cut()
	target_bosses = null
	return ..()

/obj/hud/button/boss_health/proc/update_current_boss()

	if(length(target_bosses) == 1)
		current_boss = target_bosses[1]
		return TRUE

	var/mob/living/best_boss
	for(var/k in target_bosses)
		var/mob/living/L = k
		if(!L.health)
			continue
		if(best_boss && L.health.health_current >= best_boss.health.health_current)
			continue
		best_boss = L
	current_boss = best_boss

	return TRUE

/obj/hud/button/boss_health/proc/update_stats()

	update_current_boss()

	if(!current_boss || !current_boss.health)
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(4))
		if(current_boss_music && owner)
			var/client/C = owner.client
			if(C) stop_music_track(C)
		return FALSE
	else
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(2))
		if(current_boss.boss_music && owner)
			var/client/C = owner.client
			if(C && C.current_music_track != current_boss.boss_music)
				play_music_track(current_boss.boss_music,C)
				current_boss_music = current_boss.boss_music

	min = 0
	max = current_boss.health.health_max
	current = max - current_boss.health.get_total_loss()
	update_sprite()

	return TRUE

/obj/hud/button/boss_health/update_icon()

	if(max == 0)
		return

	icon = initial(icon)

	var/icon/base = new /icon(icon,icon_state = icon_state)
	var/icon/bar = new /icon(icon,icon_state = "bar")
	if(current_boss && current_boss.boss_icon_state)
		var/icon/name = new /icon(icon,icon_state = current_boss.boss_icon_state)
		base.Blend(name,ICON_OVERLAY)

	var/start_x = 4
	var/end_x = 4 + (current/max)*(89)
	var/start_y = 1
	var/end_y = 32

	bar.Blend(bar_color,ICON_MULTIPLY)
	bar.Crop(start_x,start_y,end_x,end_y)
	bar.Shift(EAST,start_x)

	base.Blend(bar,ICON_OVERLAY)

	icon = base

	..()

