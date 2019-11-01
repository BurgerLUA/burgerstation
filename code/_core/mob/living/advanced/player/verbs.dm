client/verb/language_convert()
	var/text_to_convert = input("What is your text?")

	to_chat(convert_langage_to_lizard(text_to_convert))


mob/living/advanced/verb/make_explosion()
	explode(src.loc,10)