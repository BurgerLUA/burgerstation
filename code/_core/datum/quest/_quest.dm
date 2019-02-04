/quest/
	var/name = "Quest"
	var/id = null
	var/stage = 0

/quest/proc/set_stage(var/desired_stage)
	stage = desired_stage