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