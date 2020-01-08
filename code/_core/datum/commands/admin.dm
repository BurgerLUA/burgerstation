/command/fun/verb/announce(var/source = "Central Command" as text, var/title = "Message Title" as text, var/message_text = "Message Text" as message)
	set name = "Make IC Announcement"
	set category = "Fun"
	announce(source,title,message_text)