/client/verb/announce(var/source = "Central Command" as text, var/title = "Message Title" as text, var/message_text = "Message Text" as message)
	set name = "Make IC Announcement"
	set category = "Fun"
	announce(source,title,message_text)


/mob/living/advanced/player/verb/give_dosh(var/dosh_amount as num)
	set category = "Fun"
	set name = "Give Dosh"
	var/added_currency = adjust_currency(dosh_amount)
	to_chat("You gave yourself [added_currency] credits.")

/mob/verb/spawn_syndicate()
	var/mob/living/advanced/npc/syndicate/S = new(get_turf(usr))
	INITIALIZE(S)
	return TRUE