/obj/hud/button/cash_money
	name = "telecrystals"
	desc = "Favorite currency of the syndicate."

	var/amount = 0

	screen_loc = "RIGHT,TOP-1"

	icon_state = "currency"

	flags = FLAGS_HUD_MOB | FLAGS_HUD_SPECIAL

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
		play_sound('sounds/ui/tap-metallic.ogg',caller)
		update_sprite()

	return TRUE

/obj/hud/button/toggle_cash_money
	name = "toggle telecrystal display"
	screen_loc = "RIGHT-1,TOP-1"
	icon_state = "telecrystal"

	flags = FLAGS_HUD_MOB

	mouse_opacity = 1

	has_quick_function = FALSE

/obj/hud/button/toggle_cash_money/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	if(screen_loc == "RIGHT,TOP-1")
		screen_loc = "RIGHT-1,TOP-1" //Visible
	else
		screen_loc = "RIGHT,TOP-1" //Hidden

	var/mob/living/advanced/A = caller

	var/is_visible = screen_loc == "RIGHT-1,TOP-1"

	for(var/obj/hud/button/cash_money/B in A.buttons)
		animate(B,alpha = is_visible ? 255 : 0, time = is_visible ? 4 : 1)
		B.mouse_opacity = is_visible

	return ..()