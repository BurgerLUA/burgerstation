/obj/item/container/beaker/cake_tin
	name = "cake tin"
	desc = "For making cake."
	desc_extended = "A stainless steel cake tin for baking cake. Fill it with pastry and then stick it in the oven."

	icon = 'icons/obj/items/container/cake_tins.dmi'
	icon_state = "cake_tin"

	icon_count = 7

/obj/item/container/beaker/cake_tin/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[initial(icon_state)]_underlay")
	underlays += I
	