//THIS IS FOR INPUTS
#define TEXT_TALK "talk"
#define TEXT_LOOC "looc"
#define TEXT_OOC "ooc"
#define TEXT_GHOST "ghost"
#define TEXT_BOT "bot"
#define TEXT_RADIO "radio"
#define TEXT_PM "pm"
#define TEXT_PM_ADMIN_IN "admin_in"
#define TEXT_PM_ADMIN_OUT "admin_out"
#define TEXT_RAW "raw"

#define CHAT_TYPE_SAY 0x1
#define CHAT_TYPE_OOC 0x2
#define CHAT_TYPE_LOOC 0x4
#define CHAT_TYPE_COMBAT 0x8
#define CHAT_TYPE_RADIO (CHAT_TYPE_SAY)
#define CHAT_TYPE_PM (CHAT_TYPE_OOC | CHAT_TYPE_LOOC)

#define CHAT_TYPE_INFO CHAT_TYPE_SAY

#define CHAT_TYPE_ALL 0xFFFFFF

#define CHAT_FONT_SIZE 0.25

#define TALK_TYPE_NONE 0
#define TALK_TYPE_NORMAL "normal"
#define TALK_TYPE_QUESTION "question"
#define TALK_TYPE_EXCLAIMATION "exclaim"