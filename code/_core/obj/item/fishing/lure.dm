/obj/item/fishing/lure
	name = "fishing bob"
	desc = "goddamn maint dwellers"
	icon = 'icons/obj/item/fishing/bob.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 0.5
	value = 420
	var/bobsprite = null
	var/timemin = 3
	var/timemax = 9
	var/react = 9
	var/catchsound = "sound/ui/message_ping.ogg"


/obj/item/fishing/lure/proc/get_lure()
	return src



/obj/item/fishing/lure/generic
	name = "generic fishing bob"
	icon_state = "generic"
	desc = "cheap ho"
	desc_extended = "A basic fishing bob. Does the job but... Barely"
	bobsprite = "generic"
	value = 50
	timemin = 3
	timemax = 16
	react = 10

/obj/item/fishing/lure/easy
	name = "easy-going fishing bob"
	desc = "i just wanna fish for god's sake"
	desc_extended = "A comfy store-brand fishing bob. Takes longer to get the job done but is much easier to reel in."
	bobsprite = "easy"
	value = 250
	timemin = 3
	timemax = 12
	react = 14

/obj/item/fishing/lure/commercial
	name = "commercial fishing bob"
	icon_state = "commercial"
	desc = "fishin' purchases are necessity"
	desc_extended = "A premium fishing bob. Does the job well."
	bobsprite = "commercial"
	value = 1500
	timemin = 2
	timemax = 11
	react = 10

/obj/item/fishing/lure/gamble
	name = "robust gambler's fishing bob"
	desc = "hell yeah GAMBLIN"
	desc_extended = "A rare fishing bob. Can do very well like extremely horribly. Neat?"
	bobsprite = "robust"
	value = 2000
	timemin = 1
	timemax = 15
	react = 9

/obj/item/fishing/lure/gamble/clown
	name = "funny fishing bob"
	desc = "hjönk"
	desc_extended = "A clownish fishing bob. Can do very well like extremely horribly."
	bobsprite = "clown"
	catchsound = "sound/items/bikehorn.ogg"
	value = 4069

/obj/item/fishing/lure/gamble/cluwne
	name = "funny fishing bob?"
	desc = "smells funny"
	desc_extended = "A funny cluwnish fishing bob..? Can do very well like extremely horribly."
	bobsprite = "clown"
	catchsound = "sound/ui/rasp.ogg"
	value = 4420