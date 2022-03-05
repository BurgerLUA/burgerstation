/obj/item/container/simple/can/coffee/
	name = "\improper empty coffee cup"
	icon_state = "coffee"
	open = TRUE

/obj/item/container/simple/can/coffee/black
	name = "\improper Robusto Black Coffee"
	desc = "Pure coffee."

/obj/item/container/simple/can/coffee/black/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee,reagents.volume_max,T0C + 96)
	open = FALSE
	return ..()


//Regular espresso isn't here as that's a proper drink

/obj/item/container/simple/can/coffee/freedomno
	name = "\improper Robusto Spaceo freedomno"
	desc = "Expresso with some hot water poured inside."

/obj/item/container/simple/can/coffee/freedomno/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee/espresso,reagents.volume_max*0.25,T0C + 96)
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max*0.75,T0C + 96)
	open = FALSE
	return ..()


/obj/item/container/simple/can/coffee/latte
	name = "\improper Robusto Little Latte"
	desc = "Expresso with hot cream."

/obj/item/container/simple/can/coffee/latte/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee/espresso,reagents.volume_max*0.25,T0C + 96)
	reagents.add_reagent(/reagent/nutrition/cream,reagents.volume_max*0.75,T0C + 96)
	open = FALSE
	return ..()