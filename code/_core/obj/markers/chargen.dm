var/global/list/chargen_positions = list()

/obj/marker/chargen
	name = "chargen position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "chargen"

/obj/marker/chargen/New()
	..()
	chargen_positions += src