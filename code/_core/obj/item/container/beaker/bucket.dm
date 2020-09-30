/obj/item/container/beaker/bucket
	name = "bucket"
	desc = "A big bucket"
	desc_extended = "A very large bucket that can hold up to 500u of reagents."
	icon = 'icons/obj/item/container/bucket.dmi'
	icon_state = "bucket"
	icon_count = 9

	reagents = /reagent_container/beaker/bucket

	size = SIZE_3

	color = COLOR_GREY

/obj/item/container/beaker/bucket/update_overlays()

	. = ..()

	var/image/I = new/image(initial(icon),"handle")
	I.appearance_flags = RESET_COLOR
	I.color = COLOR_STEEL
	add_overlay(I)

	return .


/obj/item/container/beaker/bucket/water
	name = "water bucket"
	color = COLOR_BLUE

/obj/item/container/beaker/bucket/water/Generate()
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max)
	return ..()