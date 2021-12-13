/obj/structure/interactive/vending/soda
	name = "soda vendor"
	icon_state = "soda"

/obj/structure/interactive/vending/soda/New(var/desired_loc)
	icon_state = pick("soda","sodablue","sodablack","sodapurple","sodaorange")
	return ..()

/obj/structure/interactive/vending/soda/full
	stored_types = list(
		/obj/item/container/beaker/can/cola,
		/obj/item/container/beaker/can/dr_gibb,
		/obj/item/container/beaker/can/grape_soda,
		/obj/item/container/beaker/can/grey_bull,
		/obj/item/container/beaker/can/iced_tea,
		/obj/item/container/beaker/can/mountain_wind,
		/obj/item/container/beaker/can/orange_soda,
		/obj/item/container/beaker/can/space_up
	)