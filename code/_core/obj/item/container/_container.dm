/obj/item/container
	name = "container"
	desc = "This holds something."
	desc_extended = "Holds things."

	can_rename = TRUE

	weight = 0.25

/obj/item/container/get_base_value()
	. = 1
	// https://www.desmos.com/calculator/okb8vlsrmu
	if(reagents)
		. += ((reagents.volume_max * 0.25) + (reagents.volume_max**1.5)) * 0.075 * (SIZE_2/size)
		. += size*10
		. *= 0.5
	. = CEILING(.,1)