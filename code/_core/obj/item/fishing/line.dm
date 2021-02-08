/obj/item/fishing/line
	name = "fishing line"
	icon = 'icons/obj/item/fishing/line.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 0.5
	var/lavaproof = FALSE
	var/break_on_failure = 0
	var/break_on_success = 0
	color = "#FFFFFF"

/obj/item/fishing/line/t1
	name = "basic fishing line"
	desc = "Yep. A line at its most basic."
	desc_extended = "A very flimsy and basic fishing line. You get these at the 1 credit store. Very flimsy."
	value = 40
	break_on_failure = 20
	break_on_success = 10
	color = "#7F3300"

/obj/item/fishing/line/t2
	name = "commercial fishing line"
	desc = "For serious fishers."
	desc_extended = "A name-brand fishing line. Decently reliable and doesn't break too often."
	value = 250
	break_on_failure = 8
	break_on_success = 4
	color = "#C0C0C0"

/obj/item/fishing/line/t3
	name = "high durability fishing line"
	desc = "For EXTREME FISHING."
	desc_extended = "A durable fishing line. Assured not to break, unless you're bad at fishing."
	value = 1000
	break_on_failure = 5
	break_on_success = 0
	color = "#404040"

/obj/item/fishing/line/t4
	name = "robust 'fishing line'"
	desc = "Sponsored by the greytide."
	desc_extended = "A very robust fishing line. Absolutely cannot break."
	value = 2000
	icon = 'icons/obj/item/cable.dmi'
	color = "#FF0000"

/obj/item/fishing/line/t5
	name = "lavaproof fishing line"
	desc = "Not as rare as it is in Terraria!"
	desc_extended = "A rare, durable lavaproof fishing line. Allows to fish in lava and does not break."
	value = 4000
	color = "#FF6A00"
	lavaproof = TRUE