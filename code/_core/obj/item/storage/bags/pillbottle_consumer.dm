/obj/item/storage/pillbottle/consumer
	icon = 'icons/obj/item/storage/consumer_pillbottle.dmi'
	fill_icon_count = 0
	color_lid = COLOR_WHITE
	color_label = COLOR_WHITE
	color_canister = COLOR_WHITE

/obj/item/storage/pillbottle/consumer/chlorine
	name = "chlorine tablet bottle"
	desc_extended = "Contains 20 5u chlorine tablets, not for human consumption."
	color_lid = COLOR_WHITE
	color_label = COLOR_CYAN
	color_canister = COLOR_WHITE


/obj/item/storage/pillbottle/consumer/chlorine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/chlorine(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/carbon
	name = "carbon tablet bottle"
	desc_extended = "Contains 20 5u carbon tablets, not for human consumption."
	color_lid = COLOR_GREY
	color_label = COLOR_GREY_LIGHT
	color_canister = COLOR_GREY_DARK


/obj/item/storage/pillbottle/consumer/carbon/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/carbon(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/painkillers
	name = "assprin pill bottle"
	desc = "Contains 20 10u assprin painkiller pills. To remove that pain in your ass!"
	color_lid = COLOR_RED
	color_label = COLOR_YELLOW
	color_canister = COLOR_BLUE


/obj/item/storage/pillbottle/consumer/painkillers/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/assprin(src)
	. = ..()

/obj/item/storage/pillbottle/consumer/charcoal
	name = "charcoal tablet bottle"
	desc_extended = "Contains 20 5u charcoal tablets."
	color_lid = COLOR_YELLOW
	color_label = COLOR_GREY_LIGHT
	color_canister = COLOR_BLACK


/obj/item/storage/pillbottle/consumer/charcoal/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/charcoal(src)
	. = ..()