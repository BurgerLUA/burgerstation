/client/verb/pm(var/message as text)

	var/client/C = input("Who would you like to message?","Desired Client") in all_clients

	to_chat(format_speech(src,src,message,TEXT_PM),CHAT_TYPE_PM)
	C.to_chat(format_speech(src,src,message,TEXT_PM),CHAT_TYPE_PM)
