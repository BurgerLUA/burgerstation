var/global/list/ckey_to_tickets = list() //For use in printing active tickets when logging in after a disconnect.
var/global/ticket_number_counter = 1


/ticket/
	var/list/message_log = list()
	var/list/involved_ckeys = list() //Assoc list (ckey = TRUE)
	var/password //Random password in case someone manages to be clever. Then again, only admins can join new tickets. Just in case.
	var/ticket_number = 1
	var/attacker //The person who opened the ticket (ckey). The person who activated the ticket (either an admin bwoinking a player, or a player asking for help)
	var/victim //The creator of the ticket (ckey). The person basically getting bwoinked or the person who ahelped.
	var/status = null

/ticket/Topic(href,href_list[])

	if(href_list["password"] && usr.client)
		if(!involved_ckeys[usr.client.ckey])
			src.join(usr.client)
		var/desired_message = input("Adminhelp") as message
		if(desired_message)
			desired_message = police_text(usr.client,desired_message,check_characters=TRUE)
			if(desired_message)
				send_message(usr.client,desired_message)

	. = ..()

/ticket/New(var/desired_loc)
	ticket_number = ticket_number_counter
	ticket_number_counter++
	password = rand(1,1000000)
	. = ..()

/ticket/proc/open(var/client/C,var/desired_message,var/is_victim)

	for(var/k in involved_ckeys)
		var/client/C2 = CLIENT(k)
		C2?.to_chat(span("ahelp","Ticket (#[ticket_number]) has been [isnull(status) ? "opened" : "re-opened"] by [C.ckey]."))

	log_admin("[C.ckey] opened ticket (#[ticket_number]).")

	attacker = C.ckey

	status = TRUE

	if(!involved_ckeys[C.ckey])
		join(C,is_victim) //If you opened it, you must join it.

	var/fresh = length(message_log) <= 0

	if(desired_message)
		send_message(C,desired_message)

	if(fresh)
		message_log += "[C.ckey] has opened the ticket."
	else
		message_log += "[C.ckey] has reopened the ticket."

/ticket/proc/close(var/client/C)
	for(var/k in involved_ckeys)
		var/client/C2 = CLIENT(k)
		C2.to_chat(span("ahelp bold","Ticket (#[ticket_number]) has been closed by [C.ckey]."))
	status = FALSE
	message_log += "[C.ckey] has closed the ticket."
	log_admin("[C.ckey] closed ticket (#[ticket_number]).")

/ticket/proc/send_message(var/client/C,var/message)

	if(!involved_ckeys[C.ckey])
		return FALSE

	for(var/k in involved_ckeys)
		var/client/C2 = CLIENT(k)
		if(!C2)
			C.to_chat(span("ahelp","Notice: [k] was not able to recieve the message due to being offline."))
			continue
		play_sound_target('sound/effects/bwoink.ogg',C2.mob)
		if(C2 == C) //We're the person that sent the message.
			if(C2.permissions & FLAG_PERMISSION_MODERATOR) //We're a moderator who sent the message.
				C2?.to_chat(span("ahelp","[ICON_TO_HTML(chat_tags.icon,"PM_OUT",32,10)]Admin PM sent-<a class='bold' href='?src=\ref[src];password=[password]'>[C.ckey]</a>: [message]"))
			else //We're not a moderator who sent the message.
				C2?.to_chat(span("blue","[ICON_TO_HTML(chat_tags.icon,"PM_OUT",32,10)]PM to-Admins-<a class='bold' href='?src=\ref[src];password=[password]'>[C.ckey]</a>: [message]"))
		else if(C2.ckey == victim) //We're the victim and getting an admin PM from an admin.
			C2?.to_chat(span("ahelp","[ICON_TO_HTML(chat_tags.icon,"PM_IN",32,10)]Admin PM from-<a class='bold' href='?src=\ref[src];password=[password]'>[C.ckey]</a>: [message]"))
		else //We're just a spectator.
			C2?.to_chat(span("ahelp","<a class='bold' href='?src=\ref[src];password=[password]'>(Ticket #[ticket_number]) [C.ckey]</a>: [message]"))

	if(attacker == victim && !length(message_log)) //Gotta send the message to all moderators if its the first message from a player who needs help.
		var/notified_admins = 0
		for(var/k in all_clients)
			var/client/C2 = CLIENT(k)
			if(C2.permissions & FLAG_PERMISSION_MODERATOR)
				C2.to_chat(span("ahelp","[ICON_TO_HTML(chat_tags.icon,"HELP",32,10)]New ticket (#[ticket_number]) message from <a href='?src=\ref[src];password=[password]'>[victim]</a>: [message]"))
				play_sound_target('sound/effects/bwoink.ogg',C2.mob)
				notified_admins++
		log_admin("[notified_admins] admins were notified of ticket #[ticket_number].")
		if(!notified_admins)
			C.to_chat(span("ahelp","No admins are currently online. Please ping them in the discord if you are in need of assistance."))

	message_log += "[C.ckey]: [message]"

/ticket/proc/join(var/client/C,var/is_victim=FALSE)

	if(involved_ckeys[C.ckey])
		C.to_chat(span("ahelp bold","You are already in this ticket (#[ticket_number])!"))
		return FALSE

	if(!is_victim && !(C.permissions & FLAG_PERMISSION_MODERATOR))
		C.to_chat(span("ahelp bold","You do not have permission to join this ticket (#[ticket_number]). If this is in error, please contact Burger on discord."))
		return FALSE

	if(is_victim)
		victim = C.ckey

	involved_ckeys[C.ckey] = TRUE

	if(!ckey_to_tickets[C.ckey])
		ckey_to_tickets[C.ckey] = list()
	ckey_to_tickets[C.ckey] += src

	var/client/VC = CLIENT(victim)
	if(victim == attacker) //Victim called for the ahelp and someone has joined the ticket.
		if(VC != C)
			VC.to_chat(span("ahelp bold","An administrator has joined your ticket. They will respond shortly."))
		else
			VC.to_chat(span("ahelp bold","You have created a ticket (#[ticket_number]). Please wait until an administrator handles your ticket."))
	else if(victim && VC == C) //Victim did not call for the ahelp and is just tuning in.
		VC.to_chat(span("ahelp big bold center","--Adminstrator Private Message--"))
		VC.to_chat(span("ahelp center","Ticket #[ticket_number]"))
		VC.to_chat(span("ahelp","Admin PM from-<a class='bold' href='?src=\ref[src];password=[password]'>[attacker]</a>: [message_log[1]]"))
		VC.to_chat(span("ahelp italic","Click on the administrator's name to reply."))

	log_admin("[C.ckey] joined ticket (#[ticket_number]).")

	return TRUE