/client/verb/give_dosh(var/dosh_amount as num)
	set name = "Give Dosh"
	set category = "Cheat"

	var/mob/living/advanced/player/P = input("Who do you want to give money to?") in all_players as mob|null

	if(!P)
		return FALSE

	var/added_currency = P.adjust_currency(dosh_amount)
	to_chat("You [P.name] [added_currency] credits.")

/client/verb/set_attribute(var/mob/mob as mob)

	set name = "Set Attribute Level"
	set category = "Cheat"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.attributes)
		valid_choices += k

	var/chosen_attribute = input("Which attribute do you wish to modify?","Modify Attribute") as null|anything in valid_choices

	if(!chosen_attribute)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_attribute] to?","Modify Attribute") as num|null

	if(!chosen_value)
		return

	chosen_value = chosen_value

	L.set_attribute_level(chosen_attribute,chosen_value)

	L << "Your [chosen_attribute] is now [L.get_attribute_level(chosen_attribute)]."


/client/verb/set_skill(var/mob/mob as mob)

	set name = "Set Skill Level"
	set category = "Cheat"

	if(!is_living(mob))
		return
	var/mob/living/L = mob

	var/list/valid_choices = list()

	for(var/k in L.skills)
		valid_choices += k

	var/chosen_skill = input("Which skill do you wish to modify?","Modify Skill") as null|anything in valid_choices

	if(!chosen_skill)
		return

	var/chosen_value = input("Which value do you wish to set [chosen_skill] to?","Modify Skill") as num|null

	if(!chosen_value)
		return

	chosen_value = chosen_value

	L.set_skill_level(chosen_skill,chosen_value)

	L << "Your [chosen_skill] is now [L.get_skill_level(chosen_skill)]."


/client/verb/rtv()
	set name = "Rock the Vote"
	set category = "Admin"
	SShorde.round_time = 1000000


/client/verb/rejuvenate_player(var/dosh_amount as num)
	set name = "Rejuvenate Player"
	set category = "Cheat"

	var/mob/living/advanced/player/P = input("Who do you want to rejuvenate?") in all_players as mob|null

	if(!P)
		return FALSE

	P.resurrect()
	to_chat("You rejuvenated [P.name].")