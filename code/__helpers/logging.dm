#define LOG_SERVER(x) world.log << x
#define LOG_DEBUG(x) world.log << x
#define LOG_ERROR(x) world.log << "<span class='error'>[x]</span>"
#define LOG_ADMIN(x) world.log << x
#define LOG_BYOND_ERROR(x) world.log << "<span class='error'>[x]</span>"


/proc/log_subsystem(var/subsystem_id,var/log_text)
	world.log << "<span class='subsystem'><b><u>[subsystem_id]:</u></b>[log_text]</span>"