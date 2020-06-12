#define DEBUG_MESSAGES 1

#define LOG_SERVER(x) world.log << x
#define LOG_DEBUG(x) world.log << x
#define LOG_ADMIN(x) world.log << x
#define LOG_BYOND_ERROR(x) world.log << "<span class='error'>[x]</span>"
#define LOG_CHAT(x) SSlogging.log_chat(x)