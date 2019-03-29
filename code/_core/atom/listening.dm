#define CHAT_TYPE_SAY 0x1
#define CHAT_TYPE_OOC 0x2
#define CHAT_TYPE_LOOC 0x4
#define CHAT_TYPE_COMBAT 0x8


#define CHAT_TYPE_INFO CHAT_TYPE_SAY | CHAT_TYPE_COMBAT


/mob/proc/to_chat(var/text,var/chat_type = CHAT_TYPE_INFO)

	if(!src.client)
		return

	src << output(text,"chat_all.output")

	if(chat_type & CHAT_TYPE_SAY)
		src << output(text,"chat_say.output")

	if(chat_type & CHAT_TYPE_OOC)
		src << output(text,"chat_ooc.output")

	if(chat_type & CHAT_TYPE_LOOC)
		src << output(text,"chat_looc.output")

	if(chat_type & CHAT_TYPE_COMBAT)
		src << output(text,"chat_combat.output")