/obj/item/container/spray/silver_sulfadiazine
	name = "medical spray (silver sulfadiazine)"
	base_color = "#FFBD7F"
	glass_color = "#FFFF00"

/obj/item/container/spray/silver_sulfadiazine/on_spawn()
	reagents.add_reagent("silver_sulfadiazine",60)

/obj/item/container/spray/styptic_powder
	name = "medical spray (styptic powder)"
	base_color = "#FF7F7F"
	glass_color = "#FF0000"

/obj/item/container/spray/styptic_powder/on_spawn()
	reagents.add_reagent("styptic_powder",60)