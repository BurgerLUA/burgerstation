/obj/item/clothing/head/hat/crown
	name = "\improper royal winner's crown"
	icon = 'icons/obj/item/clothing/hats/crown.dmi'
	desc = "Fit for a King. Or Queen."
	desc_extended = "A very valuable crown meant to show off your status as royalty. Awarded to those who became the Last Man Standing."

	armor = /armor/reward

	size = SIZE_2

	value = 400

	value_burgerbux = 1

	var/winner_name

/obj/item/clothing/head/hat/crown/get_examine_details_list(var/mob/examiner)
	. = ..()
	if(winner_name)
		if(is_player(examiner))
			var/mob/living/advanced/player/P = examiner
			var/fucked_name = shift_vowels(winner_name)
			if(lowertext(P.real_name) == winner_name && fucked_name != winner_name)
				. += span("notice","The name \"[uppertext(fucked_name)]\" seems to be engraved on it. What the hell, they spelt my name wrong!")
			else
				. += span("notice","The name \"[uppertext(fucked_name)]\" seems to be engraved on it.")
	else
		. += span("warning","The crown seems to be a fake...")


/obj/item/clothing/head/hat/crown/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEVAR("winner_name")

/obj/item/clothing/head/hat/crown/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("winner_name")


var/list/vowel_shift = list("a","e","i","o","u")

/proc/shift_vowels(var/text)
	var/final_string = ""
	var/list/letters = splittext(text,"")
	for(var/letter in letters)
		var/index = vowel_shift.Find(letter)
		if(index)
			index = 1 + (vowel_shift % length(vowel_shift))
			letter = vowel_shift[index]
		final_string = "[final_string][letter]"
	return final_string