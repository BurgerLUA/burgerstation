var/global/next_announcement = 0


/obj/item/announcement/
	name = "broadcast announcement device"
	desc = "One day while..."
	desc_extended = "A one time use announcement system."
	icon = 'icons/obj/item/pda.dmi'
	icon_state = "captain"

	value = 3000
	value_burgerbux = 10

	var/sound_to_play = 'sound/alert/announcement.ogg'

	var/sender
	var/title
	var/print_owner = TRUE

	weight = 3

	var/stored_message

/obj/item/announcement/proc/can_use(var/mob/caller)
	return TRUE

/obj/item/announcement/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(!caller.client)
		return FALSE

	if(!can_use(caller))
		return FALSE

	if(next_announcement > world.time)
		caller.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	var/message = input("What should the message be?", "Message", stored_message) as message | null

	INTERACT_CHECK_OTHER(src) //Hacky

	stored_message = message

	if(!message)
		caller.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	message = police_input(caller.client,message)

	if(!message)
		caller.to_chat(span("notice","You decide not to use the device."))
		return FALSE

	if(get_turf(caller) != get_turf(src))
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(qdeleting)
		return FALSE

	if(!sender)
		sender = "Central Command Portable Announcement System."

	if(!title)
		title = "Message from [caller.name]"

	if(print_owner)
		message = "[message]<br> -[caller.name]"

	if(next_announcement > world.time)
		caller.to_chat(span("warning","Please wait [DECISECONDS_TO_SECONDS(CEILING(next_announcement - world.time,10))] seconds before sending an announcement!"))
		return FALSE

	announce(sender,title,message,ANNOUNCEMENT_STATION,sound_to_play)

	next_announcement = world.time + SECONDS_TO_DECISECONDS(60)

	stored_message = null

	qdel(src)

	return TRUE

/obj/item/announcement/syndicate
	desc_extended = "A one time use announcement system that sends a taunt to the crew. This one is for syndicate. Automatically signs your name in the message."
	icon_state = "syndicate"
	title = "Declaration of War"
	sender = "The Syndicate"
	value = 500
	sound_to_play = 'sound/alert/warning.ogg'

/obj/item/announcement/syndicate/can_use(var/mob/caller)

	if(!istype(caller,/mob/living/advanced/player/antagonist))
		caller.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	return TRUE