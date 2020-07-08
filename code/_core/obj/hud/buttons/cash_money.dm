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

/obj/hud/button/cash_money/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	amount = round(amount)

	maptext = "<div align='right'>[amount]</div>"

	swap_colors(I)

	icon = I

/obj/hud/button/cash_money/proc/update_stats(var/new_value=0)

	new_value = clamp(new_value,0,99999)

	if(amount != new_value)
		amount = new_value
		play('sound/ui/tap-metallic.ogg',owner, sound_setting = SOUND_SETTING_UI)
		update_sprite()

	return TRUE

/obj/hud/button/toggle_cash_money
	name = "credits"
	screen_loc = "RIGHT-1,TOP-1"
	icon_state = "telecrystal"

	flags = FLAGS_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE