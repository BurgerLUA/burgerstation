/obj/hud/button/cash_money
	name = "credits"
	desc = "Currency of the universe."

	var/amount = 0

	screen_loc = "RIGHT,TOP-1"

	icon_state = "currency"

	flags = FLAGS_HUD_MOB

	maptext_x = -2

/obj/hud/button/cash_money/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		update_stats(P.currency)

	return TRUE


/obj/hud/button/cash_money/update_sprite()
	amount = round(amount)


	maptext = "<div align='right'>[nice_number(amount)]</div>"
	return ..()

/obj/hud/button/cash_money/proc/update_stats(var/new_value=0)

	new_value = max(new_value,0)

	if(amount != new_value)
		amount = new_value
		play_sound_target('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
		update_sprite()

	return TRUE


/obj/hud/button/microstransactions
	name = "burger buxs"
	screen_loc = "RIGHT,TOP-1:-16"
	icon_state = "currency"

	flags = FLAGS_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

	var/amount = 0

	maptext_x = -2

/obj/hud/button/microstransactions/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		if(P.client)
			var/savedata/client/globals/globals = GLOBALDATA(P.client.ckey)
			update_stats(globals.loaded_data["burgerbux"])

	return TRUE


/obj/hud/button/microstransactions/proc/update_stats(var/new_value=0)

	new_value = max(new_value,0)

	if(amount != new_value)
		amount = new_value
		play_sound_target('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
		update_sprite()

	return TRUE

/obj/hud/button/microstransactions/update_sprite()
	amount = round(amount)
	maptext = "<div align='right'>[nice_number(amount)]</div>"
	return ..()

/obj/hud/button/toggle_cash_money
	name = "credits"
	screen_loc = "RIGHT-1,TOP-1"
	icon_state = "telecrystal"

	flags = FLAGS_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE


/obj/hud/button/toggle_microtransactions
	name = "burger bux"
	screen_loc = "RIGHT-1,TOP-1:-16"
	icon_state = "burger"

	flags = FLAGS_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

