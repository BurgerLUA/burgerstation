/dialogue_controller/
	var/name = "Unga"
	var/id
	var/file = 'html/dialogue.html'

/dialogue_controller/proc/open()
	winset(src, "map.dialogue","is-visible=true")
	user << output(file, "map.dialogue")


/dialogue_controller/proc/close()
	winset(src, "map.dialogue","is-visible=false")