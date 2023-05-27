/obj/item/container/edible/pill/bicaridine
	name = "bicaridine pill (5u)"

/obj/item/container/edible/pill/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,5)
	return ..()

/obj/item/container/edible/pill/kelotane
	name = "kelotane pill (5u)"

/obj/item/container/edible/pill/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,5)
	return ..()

/obj/item/container/edible/pill/dylovene
	name = "dylovene pill (5u)"

/obj/item/container/edible/pill/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,5)
	return ..()

/obj/item/container/edible/pill/calomel
	name = "calomel pill (10u)"

/obj/item/container/edible/pill/calomel/Generate()
	reagents.add_reagent(/reagent/medicine/purge,5)
	return ..()

/obj/item/container/edible/pill/charcoal
	name = "charcoal pill (10u)"

/obj/item/container/edible/pill/charcoal/Generate()
	reagents.add_reagent(/reagent/medicine/charcoal,5)
	return ..()

/obj/item/container/edible/pill/iron
	name = "iron pill (10u)"

/obj/item/container/edible/pill/iron/Generate()
	reagents.add_reagent(/reagent/iron,10)
	return ..()

/obj/item/container/edible/pill/space_drugs
	name = "space drugs (5u)"
	icon_state = "circle"

/obj/item/container/edible/pill/space_drugs/Generate()
	reagents.add_reagent(/reagent/drug/space,5)
	return ..()


/obj/item/container/edible/pill/space_dust
	name = "space dust (10u)"
	icon_state = "circle"

/obj/item/container/edible/pill/space_dust/Generate()
	reagents.add_reagent(/reagent/drug/liberty_dust,10)
	return ..()


/obj/item/container/edible/pill/omnizine
	name = "omnizine pill (10u)"

/obj/item/container/edible/pill/omnizine/Generate()
	reagents.add_reagent(/reagent/medicine/omnizine,10)
	return ..()

/obj/item/container/edible/pill/potassium_iodide
	name = "potassium iodide pill (10u)"

/obj/item/container/edible/pill/potassium_iodide/Generate()
	reagents.add_reagent(/reagent/medicine/potassium_iodide,10)
	return ..()

/obj/item/container/edible/pill/antihol
	name = "antihol pill (10u)"

/obj/item/container/edible/pill/antihol/Generate()
	reagents.add_reagent(/reagent/medicine/antihol,10)
	return ..()

/obj/item/container/edible/pill/assprin
	name = "assprin pill (5u)"

/obj/item/container/edible/pill/assprin/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/assprin,5)
	return ..()

/obj/item/container/edible/pill/space_prussian_blue
	name = "space prussian blue (10u)"

/obj/item/container/edible/pill/space_prussian_blue/Generate()
	reagents.add_reagent(/reagent/medicine/space_prussian_blue,10)
	return ..()

/obj/item/container/edible/pill/chlorine
	name = "chlorine tablet (10u)"
	icon_state = "circle"

/obj/item/container/edible/pill/chlorine/Generate()
	reagents.add_reagent(/reagent/chlorine,5)
	return ..()

/obj/item/container/edible/pill/carbon
	name = "carbon tablet (10u)"
	icon_state = "circle"

/obj/item/container/edible/pill/carbon/Generate()
	reagents.add_reagent(/reagent/carbon,5)
	return ..()