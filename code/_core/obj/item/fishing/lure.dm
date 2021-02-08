/obj/item/fishing/lure
	icon = 'icons/obj/item/fishing/bob.dmi'
	drop_sound = 'sound/items/drop/scrap.ogg'
	size = SIZE_0
	weight = 1

	var/bob_icon_state = null

	var/chance_bonus = 0 //Chance for the lure to hook something.
	var/time_bonus = 0 //Time, in deciseconds, before the fish gets away.
	var/rarity_bonus = 0 //Bonus chance every decisecond to catch something.

	var/catchsound = "sound/ui/message_ping.ogg"

/obj/item/fishing/lure/t1
	name = "basic fishing lure"
	icon_state = "generic"
	desc = "Lure in some fish."
	desc_extended = "A basic fishing bob. It does the job."
	bob_icon_state = "generic"

	chance_bonus = 0
	time_bonus = 2
	rarity_bonus = 0

	value = 50

/obj/item/fishing/lure/t1_easy
	name = "easy-going fishing lure"
	icon_state = "easy"
	desc = "I just wanna fish for god's sake!"
	desc_extended = "A comfy store-brand fishing bob designed for novice fishers. A little more pricy, but it should be good for those who are slow to fish, such as kids or the Head of Security."
	bob_icon_state = "easy"

	chance_bonus = -2
	time_bonus = 10
	rarity_bonus = -10

	value = 250

/obj/item/fishing/lure/t2
	name = "commercial fishing lure"
	icon_state = "commercial"
	desc = "Commercialized fishing."
	desc_extended = "A premium fishing bob for the premium fisherman. Very pricy but can attract all sorts of rare fish with a better grip."
	bob_icon_state = "commercial"

	chance_bonus = 3
	time_bonus = 5
	rarity_bonus = 0

	value = 1000

/obj/item/fishing/lure/t3
	name = "McRobust's fishing lure"
	icon_state = "robust"
	desc = "Warning: Robust."
	desc_extended = "A very robust and very rare fishing lure for the most robust of fishermen. Can catch a lot of rare fish at an increased rate."
	bob_icon_state = "robust"

	chance_bonus = 5
	time_bonus = 0
	rarity_bonus = 10

	value = 1000

/obj/item/fishing/lure/t3_clown
	name = "funny fishing bob"
	icon_state = "clown"
	desc = "Funny how?"
	desc_extended = "A rather peculiar clownish fishing bob. Can catch a lot of rare fish, but at what cost?"
	bob_icon_state = "clown"
	catchsound = "sound/items/bikehorn.ogg"

	chance_bonus = 0
	time_bonus = -5
	rarity_bonus = 20

	value = 2000