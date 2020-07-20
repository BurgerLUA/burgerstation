/obj/item/announcement/
	name = "broadcast announcement device"
	desc = "One day while..."
	desc_extended = "A one time use announcement system."
	icon = 'icons/obj/item/pda.dmi'
	icon_state = "captain"

	value = 3000

	var/sound_to_play = 'sound/voice/station/attention.ogg'

	var/sender
	var/title
	var/print_owner = TRUE


/obj/item/announcement/proc/can_use(var/mob/caller)
	return TRUE

/obj/item/announcement/click_self(var/mob/caller)

	if(!caller.client)
		return FALSE

	if(!can_use(caller))
		return FALSE

	var/message = input("What should the message be?", "Message") as message | null

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
		sender = caller.name

	if(!title)
		title = caller.name

	if(print_owner)
		message = "[message]<br> -[caller.name]"

	announce(sender,title,message,ANNOUNCEMENT_STATION,sound_to_play)

	qdel(src)

	return TRUE

/obj/item/announcement/syndicate
	desc_extended = "A one time use announcement system that sends a taunt to the crew. This one is for syndicate. Automatically signs your name in the message."
	icon_state = "syndicate"
	title = "Declaration of War"
	sender = "The Syndicate"
	value = 500
	sound_to_play = 'sound/voice/station/enemy_communciation.ogg'

/obj/item/announcement/syndicate/can_use(var/mob/caller)

	if(!istype(caller,/mob/living/advanced/player/antagonist))
		caller.to_chat(span("warning","You don't seem to know how to use this..."))
		return FALSE

	return TRUE