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

	var/mob/living/target_boss
	var/current_boss_music

	alpha = 0
	mouse_opacity = 0

	user_colors = FALSE

	has_quick_function = FALSE

/obj/hud/button/boss_health/Destroy()
	target_boss = null
	return ..()

/obj/hud/button/boss_health/proc/clear_boss()
	target_boss = null
	update_stats()

/obj/hud/button/boss_health/proc/update_stats()

	if(!target_boss || !target_boss.health)
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(4))
		if(current_boss_music && owner)
			var/client/C = owner.client
			if(C)
				stop_music_track(C)
		return FALSE
	else
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(2))
		if(target_boss.boss_music && owner)
			var/client/C = owner.client
			if(C && C.current_music_track != target_boss.boss_music)
				play_music_track(target_boss.boss_music,C)
				current_boss_music = target_boss.boss_music

	min = 0
	max = target_boss.health.health_max
	current = max - target_boss.health.get_total_loss()
	update_sprite()

	return TRUE

/obj/hud/button/boss_health/update_icon()

	if(max == 0)
		return

	var/icon/base = new /icon(initial(icon),icon_state = icon_state)
	var/icon/bar = new /icon(initial(icon),icon_state = "bar")
	if(target_boss && target_boss.id)
		var/icon/name = new /icon(initial(icon),icon_state = target_boss.id)
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

