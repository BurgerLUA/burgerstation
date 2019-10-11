/obj/hud/button/cash_money
	name = "telecrystals"
	desc = "Favorite currency of the syndicate."

	var/amount = 0

	screen_loc = "RIGHT,CENTER"

	icon_state = "currency"

	flags = FLAGS_HUD_MOB | FLAGS_HUD_SPECIAL

/obj/hud/button/cash_money/New(var/desired_loc)
	alpha = 0
	mouse_opacity = 0
	return ..()

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

	var/x_pos_mod = 32 - 8

	var/num_to_text = num2text(amount)

	var/the_length = length(num_to_text)

	for(var/i=the_length,i>=1,i--)
		var/letter = copytext(num_to_text,i,i+1)
		var/icon/I2 = new/icon('icons/hud/numbers.dmi',letter)
		I2.Shift(EAST,x_pos_mod)
		I2.Shift(SOUTH,3)
		I.Blend(I2,ICON_OVERLAY)
		x_pos_mod -= 5

	icon = I

/obj/hud/button/cash_money/proc/update_stats(var/new_value=0)

	new_value = Clamp(new_value,0,99999)

	if(amount != new_value)
		amount = new_value
		play_sound('sounds/ui/tap-metallic.ogg',list(owner),vector(owner.x,owner.y,owner.z),environment = ENVIRONMENT_GENERIC)
		update_icon()

	return TRUE


/obj/hud/button/toggle_cash_money
	name = "toggle telecrystal display"
	screen_loc = "RIGHT,CENTER"
	icon_state = "telecrystal"

	flags = FLAGS_HUD_MOB



/obj/hud/button/toggle_cash_money/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	for(var/obj/hud/button/cash_money/B in A.buttons)
		animate(B,alpha = B.alpha ? 0 : 255, time = B.alpha ? 1 : 4)
		B.mouse_opacity = B.alpha ? 1 : 0

	if(screen_loc == "RIGHT,CENTER")
		screen_loc = "RIGHT-1,CENTER"
	else
		screen_loc = "RIGHT,CENTER"

	return ..()