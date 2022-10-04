/obj/hud/button/boss_health
	name = "Boss Health"
	desc = "Health bar for bosses"

	icon = 'icons/hud/boss_bar.dmi'
	icon_state = "frame"

	screen_loc = "CENTER-0.5,TOP-1.5"

	var/bar_color = "#ffffff"
	var/max = 100
	var/current = 50

	layer = LAYER_HUD
	plane = PLANE_HUD

	var/list/mob/living/target_bosses = list()
	var/mob/living/current_boss

	var/current_boss_music

	user_colors = FALSE

	has_quick_function = FALSE

	var/image/bar


/obj/hud/button/boss_health/New(var/desired_loc)
	. = ..()
	alpha = 0
	mouse_opacity = 0

	var/icon/bar_mask = new/icon(icon,"bar_mask")

	bar = new/image(icon,"bar")
	bar.filters += filter(type="alpha",icon=bar_mask)

/obj/hud/button/boss_health/Destroy()
	target_bosses.Cut()
	target_bosses = null
	return ..()

/obj/hud/button/boss_health/proc/update_current_boss()

	if(current_boss)
		if(current_boss.dead || current_boss.qdeleting)
			current_boss = null
		else if(get_dist(current_boss,owner) > BOSS_RANGE)
			current_boss = null

	if(!current_boss && length(target_bosses))
		var/mob/living/best_boss
		var/best_boss_dist = INFINITY
		for(var/k in target_bosses)
			var/mob/living/L = k
			if(!best_boss)
				best_boss = L
				best_boss_dist = get_dist(owner,L)
				continue
			var/found_dist = get_dist(owner,L)
			if(found_dist < best_boss_dist)
				best_boss_dist = found_dist
				best_boss = L
		current_boss = best_boss
		return TRUE

	return FALSE

/obj/hud/button/boss_health/proc/update_stats()

	var/boss_changed = update_current_boss()

	if(!current_boss)
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

	if(current_boss.health)
		max = current_boss.health.health_max
		max = max(max,1)
		current = current_boss.health.health_current
		current = min(current,max)
	else
		max = 1
		current = 0

	if(boss_changed)
		update_sprite()

	var/ratio = (current/max)*90

	animate(bar.filters[1],x=CEILING(ratio,1),time=1)

	return TRUE

/obj/hud/button/boss_health/update_overlays()
	. = ..()
	if(current_boss && current_boss.boss_icon_state)
		var/image/I = new/image(icon,current_boss.boss_icon_state)
		add_overlay(I)
	add_overlay(bar)

