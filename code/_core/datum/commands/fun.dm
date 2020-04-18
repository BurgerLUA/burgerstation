/command/fun/

/command/fun/verb/announce(var/source = "Central Command" as text, var/title = "Message Title" as text, var/message_text = "Message Text" as message)
	set name = "Make IC Announcement"
	set category = "Fun"
	announce(source,title,message_text)


/command/fun/verb/give_dosh(var/dosh_amount as num)
	set category = "Fun"
	set name = "Give Dosh"
	var/added_currency = src.adjust_currency(dosh_amount)
	src.to_chat("You gave yourself [added_currency] credits.")


/command/fun/verb/spawn_syndicate()

	if(lowertext(ckey) != "burgerbb")
		src.to_chat("You're not an admin!")
		return FALSE

	var/mob/living/advanced/npc/syndicate/S = new(get_turf(src))
	INITIALIZE(S)

	return TRUE