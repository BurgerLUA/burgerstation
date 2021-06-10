/ticket/
	var/list/message_log = list()
	var/list/involved_ckeys = list()
	var/password //Random password in case someone manages to be clever. Then again, only admins can join new tickets. Just in case.
	var/ticket_number = 1
	var/creator //The creator of the ticket. The person basically getting bwoinked or the person who ahelped.

/ticket/New(var/desired_loc)
	password = rand(1,1000000)
	. = ..()

/ticket/proc/open(var/desired_creator)

	if(!desired_creator)
		CRASH_SAFE("Tried to create a ticket without a creator!")
		qdel(src)
		return FALSE

	var/client/C = CLIENT(desired_creator)
	join(C)

	for(var/k in involved_ckeys)
		var/client/C2 = CLIENT(k)
		C2?.to_chat(span("ahelp","Ticket (#[ticket_number]) has been opened."))

	log_admin("A new <a href='?ticket=\ref[src];password=[password]'>ticket (#[ticket_number])</a> has been opened.")

/ticket/proc/close()
	for(var/k in involved_ckeys)
		var/client/C = CLIENT(k)
		C?.to_chat(span("ahelp","Ticket #[ticket_number] has been closed."))

/ticket/proc/send_message(var/sender,var/message)

	if(!sender || !message)
		return FALSE

	if(!(sender in involved_ckeys))
		return FALSE

	for(var/k in involved_ckeys)
		var/client/C = CLIENT(k)
		C?.to_chat(span("ahelp","<a href='?ticket=\ref[src];password=[password]'>Ticket: #[ticket_number],  [C]</a>: [message]"))

	var/client/C = CLIENT(sender)

	log_admin("[C]: [message]")

	message_log += "[C]: [message]"

/ticket/proc/join(var/client/C)

	if(C.ckey in involved_ckeys)
		return FALSE

	var/message_creator = length(involved_ckeys) == 1

	involved_ckeys += C.ckey

	if(message_creator)
		var/client/C2 = CLIENT(creator)
		C2?.to_chat(span("ahelp","An administrator has joined your ticket. They will respond shortly."))

	return TRUE