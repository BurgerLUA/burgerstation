/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O)
	src << O.name
	organs.Remove(O)
	update_organs()
	O = null
	del(O)
	update_icon()

/mob/living/advanced/proc/update_organs()
	labeled_organs = list()
	for(var/obj/item/organ/O in organs)
		if(O.id)
			labeled_organs[O.id] = O
