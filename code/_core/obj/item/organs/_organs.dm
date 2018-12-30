/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."

	var/worn_layer = 0
	var/damage_icon = 'icons/mob/living/advanced/overlays/dam_mob.dmi'
	var/damage_tag = "human"

/obj/item/organ/update_icon()
	. = ..()

	icon = initial(icon)

	var/brute_loss = get_brute_loss()
	var/burn_loss = get_burn_loss()

	var/brute_mod = clamp(round((brute_loss/health_max) * 3),0,3)
	var/burn_mod = clamp(round((burn_loss/health_max) * 3),0,3)

	if(!brute_mod && !burn_mod)
		return TRUE

	//Brute is first var, burn is second
	var/icon/brute_overlay = new /icon(damage_icon,"[damage_tag]_[id]_[brute_mod]0")
	//brute_overlay.Blend("#FF0000",ICON_MULTIPLY)

	var/icon/burn_overlay = new /icon(damage_icon,"[damage_tag]_[id]_0[burn_mod]")
	//burn_overlay.Blend("#666666",ICON_SUBTRACT)

	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(burn_overlay,ICON_OVERLAY)
	base_icon.Blend(brute_overlay,ICON_OVERLAY)


	icon = base_icon

	return TRUE


