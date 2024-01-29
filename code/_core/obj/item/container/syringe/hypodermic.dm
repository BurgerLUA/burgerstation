/obj/item/container/syringe/hypodermic/
	name = "hypodermic syringe"
	value = 5
	injection_time = 2 SECONDS

	inject_amount_desired = 5
	inject_amount_precision = 5

	icon = 'icons/obj/item/container/syringe.dmi'
	icon_state = "syringe"
	var/icon_count = 7

	rarity = RARITY_UNCOMMON

	injecting = null //Auto generate.

/obj/item/container/syringe/hypodermic/update_icon()
	. = ..()
	//Plunger
	icon = initial(icon)
	icon_state = initial(icon_state)
	var/num_state = CEILING(clamp(reagents.volume_current/reagents.volume_max,0,1)*icon_count,1)
	icon_state = "[icon_state]_[num_state]"

/obj/item/container/syringe/hypodermic/update_underlays()
	. = ..()
	//Liquid
	if(reagents && reagents.volume_current)
		var/image/I = new/image(icon,"liquid")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = reagents.color
		add_underlay(I)

/obj/item/container/syringe/hypodermic/update_overlays()
	. = ..()
	//Action
	if(src.loc && is_inventory(src.loc))
		var/image/I = new/image(icon,"action_[injecting]")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		add_overlay(I)
	//Needle
	var/image/I = new/image(icon,"needle[quality <= 0 ? "_broken" : ""]")
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	add_overlay(I)


/obj/item/container/syringe/hypodermic/adjust_quality(quality_to_add=0)
	. = ..()
	if(. && finalized) update_sprite()


/obj/item/container/syringe/hypodermic/on_equip(atom/old_location,silent=FALSE) //When the item is picked up.
	. = ..()
	update_sprite()

/obj/item/container/syringe/hypodermic/drop_item(atom/desired_loc,pixel_x_offset = 0,pixel_y_offset = 0,silent=FALSE)
	. = ..()
	update_sprite()



/obj/item/container/syringe/hypodermic/epinephrine/
	name = "hypodermic syringe (epinephrine)"

/obj/item/container/syringe/hypodermic/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()

/obj/item/container/syringe/hypodermic/opium/
	name = "hypodermic syringe (opium)"

/obj/item/container/syringe/hypodermic/opium/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/opium,reagents.volume_max)
	return ..()

/obj/item/container/syringe/hypodermic/omnizine
	name = "hypodermic syringe (omnizine)"

/obj/item/container/syringe/hypodermic/omnizine/Generate()
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max)
	return ..()


/obj/item/container/syringe/hypodermic/auto
	name = "autosyringe"
	desc_extended = "A rare prototype to the medipen, the autosyringe uses pressurized air to quickly inhject chemicals into the bloodstream. The pressurized system cannot be tweaked and thus will always inject the full amount if possible."
	icon = 'icons/obj/item/container/syringe_advanced.dmi'
	rarity = RARITY_RARE
	quality_reduction_on_use = 5
	injection_time = 1.5 SECONDS
	icon_count = 11
	inject_amount_desired = INFINITY
	injection_sound = 'sound/effects/epi.ogg'
	value = 100
	reagents = /reagent_container/syringe/auto
