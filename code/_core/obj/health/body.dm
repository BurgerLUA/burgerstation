/obj/hud/button/health/body
	name = "limb health"
	desc = "Health for your limbs."
	id = "body"

	icon = 'icons/obj/health/base.dmi'
	icon_state = "body_full"

	screen_loc = "RIGHT,BOTTOM+2.2"

/obj/hud/button/health/body/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	var/mob/living/advanced/A = owner

	for(var/obj/item/organ/O in A.organs)

		if(!O.hud_id)
			continue

		var/icon/IO = new/icon(icon,O.hud_id)

		var/health_mod = O.health_current / O.health_max
		var/color_mod = rgb(93 + (1-health_mod)*(255-93),150 * health_mod,160 * health_mod)

		IO.Blend(color_mod,ICON_MULTIPLY)
		I.Blend(IO,ICON_OVERLAY)

	icon = I