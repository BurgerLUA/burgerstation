/mob/living/advanced/player/
	var/list/known_debug_messages = list()


/obj/trigger/debug_message
	name = "debug message trigger"
	id = null

	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "dev"

	var/message = "Hello. This is a debug message trigger."

	invisibility = 0
	mouse_opacity = 1

/obj/trigger/debug_message/clicked_on_by_object(var/mob/caller,object,location,control,params)
	if(is_player(caller))
		talk_to(caller)
	return TRUE

/obj/trigger/debug_message/proc/talk_to(var/mob/living/advanced/player/P)
	P.known_debug_messages[id] = TRUE
	return P.to_chat(span("debug_message",message))

/obj/trigger/debug_message/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(is_player(O) && id)
		var/mob/living/advanced/player/P = O
		if(!P.known_debug_messages[id])
			talk_to(P)

	return ..()

/obj/trigger/debug_message/greeting
	id = "greeting"
	message = "Hello. Welcome to Burgerstation, this is a highly work in progress space station 13 server from scratch. A lot of features you will see today may be buggy or outrigh might \
	not even work. To assist in gameplay mechanics, various messages like these will trigger when you walk over them for the first time. To play them a second time, just simply click on the icon again."

/obj/trigger/debug_message/starting_area
	id = "starting_area"
	message = "This area here is the starting area and isn't part of the main game. There will be a tutorial here in the future for explaining various gameplay mechanics, however \
	as you can guess, they are not implemented yet. For now, please head to the northeast of your screen and board the shuttle to head to the main area."

/obj/trigger/debug_message/bar
	id = "bar"
	message = "This is the bar. There is a test NPC located behind the counter that you can talk to in an RPG style dialogue option. So far there is no reward or benifit to speaking \
	to them, and only acts as a tech demo."

/obj/trigger/debug_message/lore
	id = "lore"
	message = "You're probably wondering what Burgerstation is. The reality is; not even the developer knows. Perhaps it is best to just find out on you own? \
	If you're still curious, the most accurate way to describe it is a PvE Team-Based NanoTrasen vs. Syndicate base-building exploration open world multiplayer RPG. \
	You're not obligated to do anything or go in teams, hell you can just land on the planet and do your own thing. Oh, did I mention that there is a planet that you land \
	on to do things? Yeah. There is a planet. If you need a goal or something, just go down on the planet via the hanger shuttles and go explore to kill some syndicate soldiers. \
	Another thing to note is that characters are persistent; everything you do in a previous round will contribute to the next round, and so on. If you die at any time, you will be \
	cloned again when you want to respawn, however you will lose all your items."

/obj/trigger/debug_message/shuttle
	id = "shuttle"
	message = "Don't see a shuttle? It's probably in transit carrying other players. Just wait a bit and explore until the shuttle lands again. You can check if it landed by looking \
	at the various screens near the starting area. Alternatively, if you're impatient, you can use the teleporter to the east."

/obj/trigger/debug_message/station
	id = "station"
	message = "Welcome to the station. You'll want to implant yourself with an IFF chip at the front desk of the station in order to gain that special implant and save your character. That way you can avoid friendly fire from other players, \
	and you can start your adventure. In the universe, IFF implants are standard for any security or private military corporation. They're extremely powerful nanites that prevent you \
	from being targeted by guns with the same IFF tag, act as an integrated ID access card, and sent your vitals, location, DNA, and brain data to the nearest NanoTrasen satalite. Once you have an IFF, you're linked with the system."

/obj/trigger/debug_message/science
	id = "science"
	message = "This is the science lobby. Further in the department, you can play minigames to earn credits to buy gear. So far there is only one minigame that I recommend \
	trying at least once."

/obj/trigger/debug_message/medical
	id = "medical"
	message = "This is the medical lobby. You don't go here to get treated, but rather you go here to buy things to treat yourself and others. It is recommended that you first \
	go to the armory to purchase armor and gear before you purchase medical supplies."

/obj/trigger/debug_message/armory
	id = "armory"
	message = "This is the armory. This is where you can buy weapons, ammo, and armor to defend yourself against the Syndicate. It is highly recommended that you do your shopping here first \
	before purchasing goods at the other departments unless you're absolutely sure you know what you're doing. The armory also has a built in firing range for you to test out your guns on target practice dummies."


/obj/trigger/debug_message/cryo
	id = "cryo"
	message = "This is the cryo room. The cryo room is where crew can go to enter stasis sleep and store their gear, DNA, and brainwave patterns safely. \
	If you die, you'll also end up here in a freshly cloned body of your most recent DNA backup, however without any of the items that you lost."


/obj/trigger/debug_message/engineering
	id = "engineering"
	message = "This is engineering. While science is incomplete, this department is the most heavily WIP department as construction still has not been completed yet. \
	While you can buy tools and other gear here, they mostly do nothing. Buyer beware! The engineering department also houses the cargo department, where excess supplies \
	and valuable artifacts are sent in order to be sold and researched by actually smart scientists. All crew will earn bonuses based on objects sent to Central Command this way."


/obj/trigger/debug_message/station_bar
	id = "station_bar"
	message = "Look familiar? This design is heavily based on /tg/'s pubbystation map as I believe it's the most pleasing to look at map currently. \
	While this Bar doesn't have much features, it's still a good place to hang out when you're bored."


/obj/trigger/debug_message/hanger
	id = "hanger"
	message = "This is the hanger. This is the only way to get to and from the planet that you will be exploring and defending from syndicate. \
	There are four shuttles here, and they all have their own purpose to the mission."


/obj/trigger/debug_message/alpha
	id = "alpha"
	message = "This is the Alpha Shuttle. The Alpha shuttle is meant for players who wish to fight Syndicate agents. It's the most reccomended shuttle for new players to use \
	as it is the most combat focused and doesn't have any complex mechanics or features. It lands in the primary LZ, next to the bravo shuttle."


/obj/trigger/debug_message/bravo
	id = "bravo"
	message = "This is the Bravo shuttle. The Bravo shuttle is meant for people who wish to construct things and learn about resource/cargo management. It is recommended for \
	players who just want to build or want to contribute to a high paycheck. It lands in the primary LZ, next to the alpha shuttle."

/obj/trigger/debug_message/charlie
	id = "charlie"
	message = "This is the Charlie shuttle. The Charlie shuttle is meant for those looking to those who wish to mine force resourses while also defending against syndicate. \
	This is usually a high paying job, however much equipment is required in order to play this role effectively. This shuttle lands far east of the primary LZ, past the caves, \
	and deep into unexplored territory."

/obj/trigger/debug_message/delta
	id = "delta"
	message = "This is the Delta shuttle. The Delta shuttle is meant for the best of the best, but we all know that this won't always be true. The Delta shuttle is meant for special \
	operatives wishing to explore the more north regions in harsh conditions in order to find artifacts and other objects for Research. The Delta shuttle lands to the north in the \
	Mountains."


/obj/trigger/debug_message/dyes
	id = "dyes"
	message = "In the future, all finacial transactions are made using a three factor authorization system consisting of facial recognition, fingerprint hash, and a DNA hash. \
	This has the benifit of being more secure as well as no need for physical items that can get misplaced or stolen. Currency is persistent across shifts, and is saved on a per \
	character basis. For these vendors, you can buy clothing or dyes to customize your character in the starting area. Note that you do not have infinite credits, so shop wisely!"


/obj/trigger/debug_message/giftshop
	id = "giftshop"
	message = "This is the gift shop. The gift shop currently sells very useful items that can help new players guide themselves around the station. It is strongly recommended \
	that anyone new to the station heads inside and buys some pinpointers."