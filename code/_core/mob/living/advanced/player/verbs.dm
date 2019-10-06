client/verb/language_convert()
	var/text_to_convert = input("What is your text?")

	to_chat(convert_langage_to_lizard(text_to_convert))



mob/living/advanced/player/verb/logout()

	set name = "Save and Quit"
	set desc = "Saves and quits your character, returning you to the main menu."
	set category = "Menu"

	var/area/A = get_area(src)

	if(A && A.safe && client)
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && A && A.safe && client)
			return save_and_logout()

	return FALSE