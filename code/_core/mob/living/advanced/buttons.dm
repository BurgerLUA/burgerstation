/mob/living/advanced/proc/add_species_buttons()
	for(var/v in mob_species.spawning_buttons)
		var/obj/button/B = new v
		B.update_owner(src)

//Inventory
/mob/living/advanced/proc/toggle_inventory(var/show_flags_whitelist=FLAGS_HUD_ALL,var/show_flags_blacklist=FLAGS_HUD_NONE,var/speed = 1)
	draw_inventory = !draw_inventory
	show_inventory(draw_inventory,show_flags_whitelist,show_flags_blacklist,speed)

/mob/living/advanced/proc/show_inventory(var/show=TRUE,var/show_flags_whitelist,var/show_flags_blacklist,var/speed)
	for(var/v in inventory)
		var/obj/inventory/O = v
		if(O.flags & show_flags_whitelist && !(O.flags & show_flags_blacklist))
			O.show(show,speed)