#define HISTORY_TYPE_NOTE "note"
#define HISTORY_TYPE_WARN "warn"
#define HISTORY_TYPE_KICK "kick"
#define HISTORY_TYPE_BAN "ban"




/savedata/client/ban_history
	name = "Adminstrative History"
	loaded_data = list()

//Format:
//type: type of action, string
//length: length of ban, integer, if applicable
//start_date: start date of ban, integer
//start_time: start time of ban, integer

/savedata/client/ban_history/reset_data()
	loaded_data = list()


/savedata/client/ban_history/New(var/client/new_owner)

	var/file_found =



/savedata/client/ban_history/get_file()
	return "bans.json"