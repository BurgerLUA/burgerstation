/obj/item/container/edible/pill
	name = "pill"
	desc = "FLOORPILL"
	desc_extended = "Hope you remember what the pill is."

	icon = 'icons/obj/item/container/pills.dmi'
	icon_state = "rectangle"

	size = SIZE_0

	value = 1

	allow_reagent_transfer_from = FALSE

	weight = 0.01

	reagents = /reagent_container/pill

	has_quick_function = TRUE

	scale_sprite = FALSE

/obj/item/container/edible/pill/get_consume_size(var/mob/living/L)
	return reagents.volume_current

/obj/item/container/edible/pill/quick(var/mob/caller,var/atom/object,location,params)
	return try_transfer_reagents(caller,caller,location,null,params)

/obj/item/container/edible/pill/get_consume_verb()
	return "swallow"

/obj/item/container/edible/pill/get_consume_sound()
	return null

/obj/item/container/edible/pill/get_examine_list(var/mob/examiner)
	return ..() + div("notice",reagents.get_contents_english())

/obj/item/container/edible/pill/Finalize()
	. = ..()
	if(reagents && reagents.volume_current <= 0) //Pills can't contain nothing.
		qdel(src)
	else
		reagents.volume_max = reagents.volume_current
		update_sprite()

/obj/item/container/edible/pill/update_sprite()

	. = ..()

	if(reagents && length(reagents.stored_reagents) > 1)
		var/red_01
		var/green_01
		var/blue_01
		var/volume_01

		var/red_02
		var/green_02
		var/blue_02
		var/volume_02

		var/i=0
		for(var/k in reagents.stored_reagents)
			var/reagent/R = REAGENT(k)
			var/volume = reagents.volume_current
			i++
			if(i % 2)
				red_01 += GetRedPart(R.color) * volume
				green_01 += GetGreenPart(R.color) * volume
				blue_01 += GetBluePart(R.color) * volume
				volume_01 += volume
			else
				red_02 += GetRedPart(R.color) * volume
				green_02 += GetGreenPart(R.color) * volume
				blue_02 += GetBluePart(R.color) * volume
				volume_02 += volume

		var/image/I1 = new/image(icon,"[icon_state]_double_left")
		I1.color = rgb(red_01/volume_01,green_01/volume_01,blue_01/volume_01)
		add_overlay(I1)

		var/image/I2 = new/image(icon,"[icon_state]_double_right")
		I2.color = rgb(red_02/volume_02,green_02/volume_02,blue_02/volume_02)
		add_overlay(I2)
	else
		color = reagents.color

