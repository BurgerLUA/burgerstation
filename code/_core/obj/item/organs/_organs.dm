/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."

	icon = 'icons/mob/living/advanced/species/human.dmi'

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage_organs.dmi'
	var/damage_tag = "human"

	color = "#e0b19d"

	var/flags_organ = FLAG_ORGAN_NONE

	health_max = 10
	var/break_threshold = 0 //0 Means it doesn't break. Other values means it breaks.

	//appearance_flags = LONG_GLIDE | KEEP_TOGETHER | RESET_COLOR

/obj/item/organ/update_icon()
	. = ..()

	icon = initial(icon)

	var/brute_loss = get_brute_loss()
	var/burn_loss = get_burn_loss()

	var/brute_mod = clamp(round((brute_loss/health_max) * 5),0,5)
	var/burn_mod = clamp(round((burn_loss/health_max) * 5),0,5)

	var/icon/limb_mask = new /icon(icon,icon_state)
	limb_mask.Blend("#FFFFFF",ICON_SUBTRACT)

	var/icon/brute_overlay = new /icon(damage_icon,"[brute_mod]")
	brute_overlay.Blend(limb_mask,ICON_ADD)
	brute_overlay.Blend("#FF0000",ICON_MULTIPLY) //Blood color

	var/icon/burn_overlay = new /icon(damage_icon,"[burn_mod]")
	burn_overlay.Blend(limb_mask,ICON_ADD)
	burn_overlay.Blend("#666666",ICON_MULTIPLY) //Burn color

	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(brute_overlay,ICON_OVERLAY)
	//base_icon.Blend(burn_overlay,ICON_OVERLAY)

	icon = base_icon

	return TRUE

/obj/item/organ/update_health()

	if(break_threshold && src.loc)
		var/brute_loss = get_brute_loss()
		if(!(flags_organ & FLAG_ORGAN_BROKEN) && brute_loss >= break_threshold)
			src.loc.visible_message(\
				span("danger","You hear a cracking sound coming from \the [src.loc]'s [name]!"),\
				span("danger","You hear a cracking sound coming from your [name]!"),\
				span("danger","You hear a cracking sound!")\
			)
			flags_organ |= FLAG_ORGAN_BROKEN

	..()