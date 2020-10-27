var/global/list/obj/structure/interactive/gateway/all_gateways = list()

/obj/structure/interactive/gateway
	name = "gateway"
	desc = "Brings you to places!"
	icon = 'icons/obj/structure/gateway.dmi'
	icon_state = "gateway"
	pixel_x = -32
	pixel_y = -32

	plane = PLANE_OBJ

	var/enabled = FALSE

/obj/structure/interactive/gateway/update_icon()
	icon_state = initial(icon_state)
	if(enabled)
		icon_state = "[icon_state]_on"

	return ..()