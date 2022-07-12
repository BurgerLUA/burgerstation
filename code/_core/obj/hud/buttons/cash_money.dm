/obj/hud/button/cash_money
	name = "credits"
	desc = "Currency of the universe."
	desc_extended = "The amount of credits your character has in their intergalatic NanoTrasen bank account. Credits can be earned by completing objectives or by selling items."

	var/amount = 0

	screen_loc = "RIGHT,TOP-1"

	icon_state = "currency"

	flags = FLAG_HUD_MOB

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

/obj/hud/button/cash_money/proc/update_stats(var/new_value=0,var/silent=FALSE)

	new_value = max(new_value,0)

	if(amount != new_value)
		amount = new_value
		if(!silent) play_sound_target('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
		update_sprite()

	return TRUE


/obj/hud/button/microstransactions
	name = "burgerbux"
	desc_extended = "The amount of burgerbux your account has. Burgerbux is bound to your ckey, and cannot be traded. You can gain burgerbux by playing the game, and spend it on (almost) useless cosmetics in the theatre."
	screen_loc = "RIGHT,TOP-1:-16"
	icon_state = "currency"

	flags = FLAG_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

	var/amount = 0

	maptext_x = -2

/obj/hud/button/microstransactions/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		if(P.client)
			var/savedata/client/globals/GD = GLOBALDATA(P.client.ckey)
			if(GD) update_stats(GD.loaded_data["burgerbux"])

	return TRUE


/obj/hud/button/microstransactions/proc/update_stats(var/new_value=0,var/silent=FALSE)

	new_value = max(new_value,0)

	if(amount != new_value)
		amount = new_value
		if(!silent) play_sound_target('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
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

	flags = FLAG_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE


/obj/hud/button/toggle_microtransactions
	name = "burger bux"
	screen_loc = "RIGHT-1,TOP-1:-16"
	icon_state = "burger"

	flags = FLAG_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

