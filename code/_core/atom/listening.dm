#define CHAT_TYPE_INFO 0x1
#define CHAT_TYPE_INFO 0x2

/atom/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)
	return

/mob/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(!src.client)
		return

	switch(chat_type)
		if(CHAT_TYPE_INFO)
			src << output(text,"chat_looc.output")

	src << text

