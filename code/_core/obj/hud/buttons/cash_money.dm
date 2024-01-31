/obj/hud/button/cash_money
	name = "credits"
	desc = "Currency of the universe."
	desc_extended = "The amount of credits your character has in their intergalatic NanoTrasen bank account. Credits can be earned by completing objectives or by selling items."

	var/amount = 0

	screen_loc = "RIGHT,TOP-1:-16"

	icon_state = "currency"

	flags_hud = FLAG_HUD_MOB

	maptext_x = -2

/obj/hud/button/cash_money/update_owner(mob/desired_owner)

	. = ..()

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		update_stats(P.currency)

	return TRUE


/obj/hud/button/cash_money/update_sprite()
	amount = round(amount)
	maptext = "<div align='right'>[nice_number(amount)]</div>"
	return ..()

/obj/hud/button/cash_money/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"credits")
	I.pixel_x = -32
	I.mouse_opacity = 0
	add_overlay(I)

/obj/hud/button/cash_money/proc/update_stats(new_value=0,silent=FALSE)

	new_value = max(new_value,0)

	if(amount != new_value)
		amount = new_value
		if(!silent) play_sound_target('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
		update_sprite()

	return TRUE


/obj/hud/button/microstransactions
	name = "burgerbux"
	desc_extended = "The amount of burgerbux your account has. Burgerbux is bound to your ckey, and cannot be traded. You can gain burgerbux by playing the game, and spend it on (almost) useless cosmetics in the theatre."
	screen_loc = "RIGHT,TOP-1:-32"
	icon_state = "currency"

	flags_hud = FLAG_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

	var/amount = 0

	maptext_x = -2

/obj/hud/button/microstransactions/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"burger")
	I.pixel_x = -32
	I.mouse_opacity = 0
	add_overlay(I)

/obj/hud/button/microstransactions/update_owner(mob/desired_owner)

	. = ..()

	if(. && is_player(owner))
		var/mob/living/advanced/player/P = owner
		if(P.client)
			var/savedata/client/globals/GD = GLOBALDATA(P.client.ckey)
			if(GD) update_stats(GD.loaded_data["burgerbux"])

	return TRUE


/obj/hud/button/microstransactions/proc/update_stats(new_value=0,silent=FALSE)

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