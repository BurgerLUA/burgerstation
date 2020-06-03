/client/verb/edit_macros()
	set hidden = TRUE


	var/list/unused_commands = list()
	var/list/building = QWERT_MACROS
	for(var/k in building)
		var/v = building[k]
		unused_commands += v

	var/html_to_send = "<h1>Controls</h1><h3>I unironically made this in like 2 hours so please be gentle.</h3>"

	for(var/key in macros.macros)
		var/command = macros.macros[key]
		html_to_send += "<a href='?change_key=[key]'>[key]: [command]</a><br>"
		unused_commands -= command
	html_to_send += "<hr>"
	html_to_send += "<p>Unused commands: [english_list(unused_commands)].</p>"
	html_to_send += "<hr>"
	html_to_send += "<a href='?change_key=new'>Add New Bind</a><br>"
	html_to_send += "<a href='?change_key=QWERTY'>Reset to Factory Default (QWERTY)</a><br>"
	html_to_send += "<a href='?change_key=AZERTY'>Reset to Factory Default (AZERTY)</a><br>"
	html_to_send += "<a href='?change_key=save'>Save Settings to Stored File</a><br>"
	html_to_send += "<a href='?change_key=load'>Load Settings from Stored File</a><br>"
	html_to_send += "<a href='?change_key=quit'>Quit</a><br>"

	var/id = "edit_macros"
	//winclone(src, "window", id)
	winset(src, "browser([id])", "parent=map;type=browser;size=0x0;anchor1=0,0;anchor2=100,100")
	winshow(src,"browser([id])",TRUE)
	src << output(html_to_send, "browser([id])")