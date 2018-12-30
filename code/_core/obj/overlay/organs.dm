/obj/overlay/damage
	name = "damage overlay"
	desc = "Damage overlay for advanced mobs."
	icon = 'icons/mob/living/advanced/overlays/dam_human.dmi'
	icon_state = "30"
	layer = LAYER_MOB_DAMAGE

	var/mask_icon = 'icons/mob/living/advanced/overlays/dam_mask_human.dmi'

	var/mob/living/advanced/owning_mob

/obj/overlay/damage/update_icon()

	if(!owning_mob)
		return FALSE

	icon = initial(icon)

	var/icon/damage_overlay = icon(icon,icon_state)

	var/list/limb_masks = list()

	for(var/key in owning_mob.labeled_organs)
		limb_masks += key

	var/icon/I = icon(mask_icon,"head")
	damage_overlay.Blend(I,BLEND_MULTIPLY)

	/*
	for(var/value in limb_masks)
		var/icon/I = icon(mask_icon,value)
		damage_overlay.Blend(I,BLEND_MULTIPLY)
	*/

	icon = damage_overlay


	return TRUE
