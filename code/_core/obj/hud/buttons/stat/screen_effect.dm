/obj/hud/button/stat/screen_effect
	name = "screen blood"
	desc = "This does something, I think."
	id = "screen"

	icon = 'icons/hud/injury.dmi'
	icon_state = "corner"

	layer = 0
	plane = PLANE_HUD

	screen_loc = "CENTER:-144,CENTER:-144"

	mouse_opacity = 0

	user_colors = FALSE

	maptext_height = 160
	maptext_width = 160

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

	var/max_health = owner.health.health_max
	var/health = owner.health.health_current

	if(dir==SOUTH) //Master screen blood
		color = "#FFFFFF"

		var/mob/living/L = owner

		if(L.dead)
			alpha = 200
			maptext = "<center>You have died.</center>"
			health = 0
		else
			alpha = clamp(100 - (100*(1/0.4))*(health/max_health),0,100)
			maptext = null

		if(owner.client) //TODO: Move this somewhere else. Like in update health or something.

			var/health_loss = 1 - health/max_health
			var/greyscale_amount = clamp(( (health_loss**2) - 0.6)*3,0,0.9)

			var/light_mod = clamp(0.5 + (health/max_health),0.5,1)
			var/a = (1 - greyscale_amount)*light_mod
			var/b = greyscale_amount*light_mod

			var/list/desired_color = list(
				a,b,b,0,
				b,a,b,0,
				b,b,a,0,
				0,0,0,1,
				0,0,0,0
			)

			owner.add_color_mod("health",desired_color)

	else if(dir in DIRECTIONS_INTERCARDINAL)

		var/max_pain = owner.health.health_max*owner.health.health_regen_cooef
		var/pain = owner.health.get_loss(PAIN)

		var/max_stamina = owner.health.stamina_max*owner.health.stamina_regen_cooef
		var/stamina = owner.health.stamina_current

		var/max_mana = owner.health.mana_max*owner.health.mana_regen_cooef
		var/mana = owner.health.mana_current

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
			255*(1 - pain_mod) - health_mod*255,
			255*(1 - pain_mod) - stamina_mod*255,
			255*(1 - pain_mod) - mana_mod*255)

	return FALSE



