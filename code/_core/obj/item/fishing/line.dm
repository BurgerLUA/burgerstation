/obj/item/fishing/line
	name = "fishing line"
	desc = "damn bro go for the lottery today"
	icon = 'icons/obj/item/fishing/line.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 0.5
	value = 420
	var/lavaproof = 0
	var/break_on_failure = 0
	var/break_on_success = 0
	color = "#FFFFFF"



/obj/item/fishing/line/proc/get_line()
	return src

/obj/item/fishing/line/basic
	name = "basic fishing line"
	desc = "hobo style"
	desc_extended = "A flimsy fishing line. Breaks really fast."
	value = 30
	break_on_failure = 20
	break_on_success = 10

/obj/item/fishing/line/commercial
	name = "commercial fishing line"
	desc = "use money make fish get money"
	desc_extended = "A store-brand fishing line. Decently reliable, as they dont break often."
	value = 500
	break_on_failure = 2
	break_on_success = 1

/obj/item/fishing/line/expensive
	name = "high durability fishing line"
	desc = "got that bling"
	desc_extended = "A durable fishing line. Assured not to break."
	value = 3000

/obj/item/fishing/line/robust
	name = "robust 'fishing line'"
	desc = "the tide"
	desc_extended = "A really cool fishing line. It's durability is indeed robust."
	value = 2000
	icon = 'icons/obj/item/cable.dmi'
	color = "#FF0000"
/obj/item/fishing/line/lavaproof
	name = "lavaproof fishing line"
	desc = "revenge of the sunfish"
	desc_extended = "A rare, resistant lavaproof fishing line. Allows to fish in lava and does not break."
	value = 3000
	color = "#D44908"
	lavaproof = 1