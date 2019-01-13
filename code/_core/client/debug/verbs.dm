/client/verb/debug_all_clients()
	set category = "Debug"

	for(var/client/C in all_clients)
		src << C.ckey

/client/verb/debug_tracker()
	set category = "Debug"

	src << button_tracker.owner

/client/verb/debug_pressed()
	set category = "Debug"

	for(var/pressed_buttons in button_tracker.get_pressed())
		src << pressed_buttons

/client/verb/debug_macros()
	set category = "Debug"

	for(var/listed_macro in macros.macros)
		src << "[listed_macro] [macros.macros[listed_macro]]"

/client/verb/debug_curtime()
	set category = "Debug"
	src << curtime

client/verb/debug_active_subsystems()
	set category = "Debug"

	for(var/datum/subsystem/subsystem in active_subsystems)
		src << subsystem.name

client/verb/debug_movement()
	set category = "Debug"

	src << mob.move_dir

client/verb/debug_organs()
	set category = "Debug"
	var/mob/living/advanced/A = mob
	for(var/obj/item/organ/O in A.organs)
		src << O.name

	for(var/key in A.labeled_organs)
		var/obj/item/organ/O = A.labeled_organs[key]
		src << "[key] = [O.type]"

client/verb/debug_overlays()
	set category = "Debug"
	src << "Found [length(mob.overlays)] overlays."

client/verb/debug_species()
	set category = "Debug"
	var/mob/living/advanced/A = mob
	src << A.mob_species.name

client/verb/debug_images()
	set category = "Debug"
	src << "Found [length(src.images)] images."

client/verb/debug_inventory()
	set category = "Debug"
	var/mob/living/advanced/A = mob
	src << "Found [length(A.inventory)] inventory holders."

client/verb/debug_attack_flags()
	set category = "Debug"
	src << mob.attack_flags

client/verb/update_mob_icon()
	set category = "Debug"
	mob.update_icon()

client/verb/remove_head()
	set category = "Debug"
	var/mob/living/advanced/A = mob
	if(A.labeled_organs["head"])
		A.remove_organ(A.labeled_organs["head"])

client/verb/add_clothes()
	set category = "Debug"
	var/mob/living/advanced/A = mob
	if(A.mob_outfit)
		A.add_clothes(A.mob_outfit)

client/verb/debug_sounds()
	set category = "Debug"
	src << "Found [length(active_sounds)] active sounds."

client/verb/debug_turf_contents()
	set category = "Debug"
	var/turf/T = get_turf(mob.loc)
	for(var/atom/A in T.contents)
		src << A

client/verb/debug_skills()
	set category = "Debug"
	var/mob/living/L = mob
	src << "Found [length(L.skills)] skills in mob."
	src << "Found [length(all_skills)] skills in world."
	for(var/id in L.skills)
		var/experience/skill/S = L.skills[id]
		src << "[id] = [S.get_current_level()]"

client/verb/debug_attributes()
	set category = "Debug"
	var/mob/living/L = mob
	src << "Found [length(L.attributes)] attributes in mob."
	src << "Found [length(all_attributes)] attributes in world."
	for(var/id in L.attributes)
		var/experience/attribute/A = L.attributes[id]
		src << "[id] = [A.get_current_level()]"

client/verb/debug_attribute()
	set category = "Debug"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/text = input("What is the ID of the attribute?")

	text = text ? text : ATTRIBUTE_STRENGTH

	var/experience/attribute/A = L.get_attribute(text)
	src << "get_attribute([text]) = [A.type]"

	var/level = L.get_attribute_level(text)
	src << "get_attribute_level([text]) = [level]"

	var/power = L.get_attribute_power(text,0,100)
	src << "get_attribute_power([text],0,100) = [power]"


/client/verb/debug_other_attribute()
	set category = "Debug"

	var/list/valid_choices = list()

	for(var/mob/living/M in world)
		valid_choices[M.name] = M

	var/mob/living/chosen_mob = valid_choices[input("Which mob do you wish to debug?","Debug Mob") in valid_choices]

	var/text = input("What is the ID of the attribute?")

	text = text ? text : ATTRIBUTE_STRENGTH


	src << "Found [length(chosen_mob.attributes)] attributes."

	var/experience/attribute/A = chosen_mob.get_attribute(text)
	src << "get_attribute([text]) = [A.type]"

	var/level = chosen_mob.get_attribute_level(text)
	src << "get_attribute_level([text]) = [level]"

	var/power = chosen_mob.get_attribute_power(text,0,100)
	src << "get_attribute_power([text],0,100) = [power]"


/client/verb/set_attribute()
	set name = "Set Attribute"
	set category = "Cheat"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.attributes)
		valid_choices += k

	var/chosen_attribute = input("Which attribute do you wish to modify?","Modify Attribute") in valid_choices

	if(!chosen_attribute)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_attribute] to?","Modify Attribute")

	if(!chosen_value)
		return

	chosen_value = text2num(chosen_value)

	L.set_attribute_level(chosen_attribute,chosen_value)

	L << "Your [chosen_attribute] is now [L.get_attribute_level(chosen_attribute)]."


/client/verb/set_skill()
	set name = "Set Skill"
	set category = "Cheat"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.skills)
		valid_choices += k

	var/chosen_skill = input("Which skill do you wish to modify?","Modify Skill") in valid_choices

	if(!chosen_skill)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_skill] to?","Modify Skill")

	if(!chosen_value)
		return

	chosen_value = text2num(chosen_value)

	L.set_skill_level(chosen_skill,chosen_value)

	L << "Your [chosen_skill] is now [L.get_skill_level(chosen_skill)]."





/*
client/verb/debug_animations()
	set category = "Debug"

	src << "Found [length(mob.animations)] animations."
*/

/*
client/verb/debug_random()
	set category = "Debug"

	var/list/stored_values = list(0,0,0,0,0,0,0,0,0,0)

	for(var/i=1,i<=1000,i++)
		var/random_value = burger_rand_seed(1,10,i)
		stored_values[random_value] = stored_values[random_value] + 1

	src << "Random Filling Test:"
	for(var/i=1,i<=length(stored_values),i++)
		src << "[i]: [stored_values[i]] out of [1000/10]."


	src << "Random Randomness Test:"
	for(var/i=1,i<=10,i++)
		src << burger_rand_seed(1,1000,curtime + i,src)
*/


/client/verb/debug_buttons()
	set category = "Debug"
	src << "Found [length(known_buttons)] known buttons."

