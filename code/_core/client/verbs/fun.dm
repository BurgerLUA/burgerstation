/client/verb/make_announcement()

	set category = "Fun"
	set name = "Make Announcement"

	var/sender = input("Who should the sender be?","Message Sender") as text | null
	if(!sender)
		return FALSE

	var/message = input("What should the message be?", "Message") as message | null
	if(!message)
		return FALSE

	var/header = input("What should the header be?", "Message Header") as text | null
	if(!header)
		return FALSE

	announce(sender,header,message,ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	return TRUE