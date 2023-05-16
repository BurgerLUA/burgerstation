var/global/list/valid_bedsheets = list(
	"grey",
	"red",
	"orange",
	"yellow",
	"green",
	"blue",
	"purple",
	"brown",
	"black",
	"white"
)

/obj/item/bedsheet
	name = "bedsheet"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "sheet"
	value = 10

	plane = PLANE_MOVABLE_DEAD
	layer = LAYER_MOB_ABOVE

	pixel_y = 4

/obj/item/bedsheet/Finalize()
	. = ..()
	update_sprite()

/obj/item/bedsheet/update_icon()
	. = ..()
	if(icon_state == "sheet")
		icon_state = "sheet[pick(valid_bedsheets)]"