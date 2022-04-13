/mob/living/proc/add_stat_element(var/obj/hud/button/stat/H)
	stat_elements[H.id] = H
	if(client)
		client.screen += H
	sync_stat_elements()

/mob/living/proc/remove_stat_element(var/obj/hud/button/stat/H)
	stat_elements -= H.id //H.id is important
	if(client)
		client.screen -= H
	sync_stat_elements()

/mob/living/proc/restore_stat_elements()

	if(!client)
		return

	for(var/k in stat_elements)
		var/obj/hud/button/H = stat_elements[k]
		client.screen += H

	sync_stat_elements()

/mob/living/proc/sync_stat_elements()
	if(client)
		client.known_stat_elements = stat_elements.Copy()