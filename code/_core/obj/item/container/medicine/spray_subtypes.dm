/obj/item/container/spray/silver_sulfadiazine
	name = "medical spray (silver sulfadiazine)"
	base_color = "#FFBD7F"
	glass_color = "#FFFF00"

/obj/item/container/spray/silver_sulfadiazine/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,60)
	return ..()

/obj/item/container/spray/styptic_powder
	name = "medical spray (styptic powder)"
	base_color = "#FF7F7F"
	glass_color = "#FF0000"

/obj/item/container/spray/styptic_powder/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,60)
	return ..()


/obj/item/container/spray/synthflesh
	name = "medical spray (synthflesh)"
	base_color = "#FFEBEB"
	glass_color = "#FFFFFF"

/obj/item/container/spray/synthflesh/Generate()
	reagents.add_reagent(/reagent/medicine/synthflesh,60)
	return ..()