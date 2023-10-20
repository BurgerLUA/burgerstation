/obj/item/storage/pillbottle/consumer
	icon = 'icons/obj/item/storage/consumer_pillbottle.dmi'
	desc_extended = "An unlabelled consumer pill bottle that can hold up to 30 pills."
	fill_icon_count = 0
	color_lid = COLOR_WHITE
	color_label = COLOR_WHITE
	color_canister = COLOR_WHITE

/obj/item/storage/pillbottle/consumer/chlorine
	name = "chlorine tablet bottle"
	desc = "A favorite of pool owners, war criminals and unsupervised children alike."
	desc_extended = "Labelled to contain 20 5u chlorine tablets, for use in chemistry. Not fit for human consumption."
	color_lid = COLOR_WHITE
	color_label = COLOR_CYAN
	color_canister = COLOR_WHITE


/obj/item/storage/pillbottle/consumer/chlorine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/chlorine(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/carbon
	name = "carbon tablet bottle"
	desc = "Forget water, this is actually the stuff of life."
	desc_extended = "Labelled to contain 20 5u carbon tablets, for use in chemistry. Not fit for human consumption."
	color_lid = COLOR_GREY
	color_label = COLOR_GREY_LIGHT
	color_canister = COLOR_GREY_DARK


/obj/item/storage/pillbottle/consumer/carbon/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/carbon(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/painkillers
	name = "assprin pill bottle"
	desc = "To remove that pain in your ass!"
	desc_extended = "Labelled to contain 20 10u assprin pills, a basic painkiller and for treating feelings of tenderness. Can hold up to 30 pills."
	color_lid = COLOR_RED
	color_label = COLOR_YELLOW
	color_canister = COLOR_BLUE


/obj/item/storage/pillbottle/consumer/painkillers/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/assprin(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/charcoal
	name = "charcoal tablet bottle"
	desc = "Bad and naughty Chemists get their meth flushed out of their system!"
	desc_extended = "Labelled to contain contain 20 5u charcoal tablets, a basic reagent to flush the bloodstream. Can hold up to 30 tablets."
	color_lid = COLOR_YELLOW
	color_label = COLOR_GREY_LIGHT
	color_canister = COLOR_BLACK


/obj/item/storage/pillbottle/consumer/charcoal/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/charcoal(src)
	. = ..()