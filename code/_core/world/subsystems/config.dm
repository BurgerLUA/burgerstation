SUBSYSTEM_DEF(config)
	name = "Config Subsystem"
	desc = "Controls config options."
	priority = SS_ORDER_CONFIG

	var/list/config = list()

/subsystem/config/Initialize()

	if(!fexists(CONFIG_DIR))
		log_subsystem(name,"Could not find a config file ([CONFIG_DIR]).")
		return ..()

	var/file_text = rustg_file_read(CONFIG_DIR)
	var/list/split_file = splittext(file_text,"\n")
	var/line_count = 0
	for(var/line in split_file)
		line_count++
		if(copytext(line,1,2) == "#")
			continue
		var/list/split_line = splittext(line," ")
		if(length(split_line) < 2)
			log_error("Invalid config format for [CONFIG_DIR] on line [line_count]: [line]")
			continue
		var/config_id = uppertext(split_line[1])
		var/list/config_options = split_line.Copy(2)
		if(length(config_options) == 1)
			var/value = config_options[1]
			var/config_num = text2num(value) //TODO Also do the other text2 values
			if(config_num)
				config[config_id] = config_num
				continue
			config[config_id] = value
		else
			config[config_id] = jointext(config_options," ")

	log_subsystem(name,"Found [length(config)] config options.")

	return ..()
