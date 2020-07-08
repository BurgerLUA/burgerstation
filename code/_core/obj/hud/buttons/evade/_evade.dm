/obj/hud/button/evade
	name = "evade"
	desc = ""
	desc_extended = ""
	icon_state = "template"
	screen_loc = "RIGHT-4,BOTTOM"
	flags = FLAGS_HUD_MOB

/obj/hud/button/evade/proc/get_charge_level(var/mob/living/caller)
	return 0

/obj/hud/button/evade/update_owner()

	. = ..()

	update_sprite()

	return .

/obj/hud/button/evade/update_overlays()

	overlays.Cut()

	. = ..()

	if(!is_living(owner))
		return .

	var/mob/living/L = owner

	var/charge_icon = 0
	var/charge_level = get_charge_level(L)

	if(charge_level <= 100)
		charge_icon = FLOOR((charge_level/100)*5,1)
	else
		charge_icon = 4 + FLOOR(charge_level/100,1)

	charge_icon = clamp(charge_icon,0,9)

	desc = "[charge_level] and [charge_icon]"

	var/image/I = new/image(initial(icon),"[icon_state]_[charge_icon]")
	I.alpha = charge_level >= 100 ? 255 : charge_level

	add_overlay(I)

	return .

/obj/hud/button/evade/block
	name = "block"
	desc = "Easily blocked!"
	desc_extended = "A button that controls whether or not you block when holding down the space bar."
	icon_state = "block"

/obj/hud/button/evade/block/get_charge_level(var/mob/living/caller)
	return caller.charge_block

/obj/hud/button/evade/parry
	name = "parry"
	desc = "Easily blocked!"
	desc_extended = "A button that controls whether or not you parry when holding down the space bar."
	icon_state = "parry"

/obj/hud/button/evade/parry/get_charge_level(var/mob/living/caller)
	return caller.charge_parry

/obj/hud/button/evade/dodge
	name = "dodge"
	desc = "Easily blocked!"
	desc_extended = "A button that controls whether or not you dodge when holding down the space bar."
	icon_state = "dodge"

/obj/hud/button/evade/dodge/get_charge_level(var/mob/living/caller)
	return caller.charge_dodge




