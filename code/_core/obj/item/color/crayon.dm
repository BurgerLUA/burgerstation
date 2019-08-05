/obj/item/color/crayon/
	name = "crayon"
	icon = 'icons/obj/items/color/crayons.dmi'
	icon_state = "crayon"
	uses = 20

/obj/item/color/crayon/New(var/desired_loc)
	..()
	update_icon()

/obj/item/color/crayon/update_icon()
	..()
	color = selected_color

/obj/item/color/crayon/blue
	name = "blue crayon"
	color = "#0000FF"

/obj/item/color/crayon/red
	name = "red crayon"
	color = "#FF0000"

/obj/item/color/crayon/orange
	name = "orange crayon"
	color = "#FF8800"

/obj/item/color/crayon/brown
	name = "brown crayon"
	color = "#7F4A00"

/obj/item/color/crayon/dev
	name = "dev crayon"
	uses = 99999

/obj/item/color/crayon/green
	name = "green crayon"
	color = "#00FF00"

/obj/item/color/crayon/dev/get_selected_color(var/mob/caller)
	return input(caller,"What would you like the color to be?","Choose a color","#FFFFFF")