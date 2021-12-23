/obj/structure/interactive/vending/soda
	name = "soda vendor"
	icon_state = "soda"

/obj/structure/interactive/vending/soda/New(var/desired_loc)
	icon_state = pick("soda","sodablue","sodablack","sodapurple","sodaorange")
	return ..()

/obj/structure/interactive/vending/soda/full
	stored_types = list(
		/obj/item/container/simple/can/cola,
		/obj/item/container/simple/can/dr_gibb,
		/obj/item/container/simple/can/grape_soda,
		/obj/item/container/simple/can/grey_bull,
		/obj/item/container/simple/can/iced_tea,
		/obj/item/container/simple/can/mountain_wind,
		/obj/item/container/simple/can/orange_soda,
		/obj/item/container/simple/can/space_up
	)