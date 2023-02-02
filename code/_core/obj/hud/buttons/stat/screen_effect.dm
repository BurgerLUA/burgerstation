/obj/hud/button/stat/screen_effect
	name = "screen blood"
	desc = "This does something, I think."
	id = "screen"

	icon = 'icons/hud/injury.dmi'
	icon_state = "corner"

	plane = PLANE_HUD
	layer = LAYER_SCREEN_BLOOD

	screen_loc = "CENTER:-144,CENTER:-144"

	mouse_opacity = 0

	user_colors = FALSE

	maptext_height = 160
	maptext_width = 160

	flags_hud = FLAG_HUD_SPECIAL

/obj/hud/button/stat/screen_effect/update_owner(var/mob/desired_owner)
	alpha = 0
	switch(dir)
		if(NORTHWEST)
			screen_loc = "LEFT,TOP to RIGHT,BOTTOM:12"
			id = "screen_nw"
		if(NORTHEAST)
			screen_loc = "RIGHT,TOP to LEFT,BOTTOM:12"
			id = "screen_ne"
		if(SOUTHEAST)
			screen_loc = "RIGHT,BOTTOM:12 to LEFT,TOP"
			id = "screen_se"
		if(SOUTHWEST)
			screen_loc = "LEFT,BOTTOM:12 to RIGHT,TOP"
			id = "screen_sw"
		if(SOUTH)
			screen_loc = "CENTER:-64,CENTER:-64"
			id = "screen_c"
	. = ..()

/obj/hud/button/stat/screen_effect/update()

	if(!owner.health)
		alpha = 0 //Hidden.
		return FALSE

	var/mob/living/L = owner

	var/max_health = L.health.health_max
	var/health = L.health.health_current

	if(dir==SOUTH) //Master screen blood
		color = "#FFFFFF"

		if(L.dead)
			alpha = 200
			maptext = "<center>You have died.</center>"
			health = 0
		else
			alpha = clamp(100 - (100*(1/0.4))*(health/max_health),0,100)
			maptext = null

	else if(dir in DIRECTIONS_INTERCARDINAL)

		var/max_pain = L.health.health_max*L.health.health_regen_cooef
		var/pain = max(0,L.health.damage[PAIN] + -L.pain_regen_buffer)

		var/max_stamina = L.health.stamina_max*L.health.stamina_regen_cooef
		var/stamina = L.health.stamina_current

		var/max_mana = L.health.mana_max*L.health.mana_regen_cooef
		var/mana = L.health.mana_current

		var/pain_mod = clamp(pain/max_pain,0,1)
		var/health_mod = clamp(health/max_health,0,1)
		var/stamina_mod = clamp(stamina/max_stamina,0,1)
		var/mana_mod = clamp(mana/max_mana,0,1)

		alpha = max(
			1 - health_mod,
			1 - stamina_mod,
			1 - mana_mod,
			pain_mod
		)*255
		color = rgb(
			max(0,255*(1 - pain_mod) - health_mod*255),
			max(0,255*(1 - pain_mod) - stamina_mod*255),
			max(0,255*(1 - pain_mod) - mana_mod*255)
		)

	return FALSE



