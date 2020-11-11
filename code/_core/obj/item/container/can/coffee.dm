/obj/item/container/beaker/can/coffee/
	name = "\improper empty coffee cup"
	icon_state = "coffee"
	open = TRUE

/obj/item/container/beaker/can/coffee/black
	name = "\improper Robusto Black Coffee"
	desc = "Pure coffee."

/obj/item/container/beaker/can/coffee/black/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee,reagents.volume_max,T0C + 96)
	open = FALSE
	return ..()


//Regular expresso isn't here as that's a proper drink

/obj/item/container/beaker/can/coffee/americano
	name = "\improper Robusto Spaceo Americano"
	desc = "Expresso with some hot water poured inside."

/obj/item/container/beaker/can/coffee/americano/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee/expresso,reagents.volume_max*0.25,T0C + 96)
	reagents.add_reagent(/reagent/nutrition/water,reagents.volume_max*0.75,T0C + 96)
	open = FALSE
	return ..()


/obj/item/container/beaker/can/coffee/latte
	name = "\improper Robusto Little Latte"
	desc = "Expresso with hot cream."

/obj/item/container/beaker/can/coffee/latte/Generate()
	reagents.add_reagent(/reagent/nutrition/energy/coffee/expresso,reagents.volume_max*0.25,T0C + 96)
	reagents.add_reagent(/reagent/nutrition/cream,reagents.volume_max*0.75,T0C + 96)
	open = FALSE
	return ..()