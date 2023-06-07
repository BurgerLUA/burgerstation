/obj/item/paper/book/enchanting
	name = "enchanting book"
	desc = "No experience required!"
	desc_extended = "A magical book of enchanting that has the power to enchant weapons with special effects."
	icon = 'icons/obj/item/enchanting/books.dmi'
	icon_state = "normal"

	var/enchantment/stored_enchantment //Path

	var/enchanting_phrase = "Memes."

	value = 0

	editable = FALSE

	rarity = RARITY_RARE

/obj/item/paper/book/enchanting/New(var/desired_loc)

	data = list()

	if(stored_enchantment)
		enchanting_phrase = initial(stored_enchantment.enchanting_phrase)
		name = "[initial(name)]: [initial(stored_enchantment.name)]"

	var/language/L = SSlanguage.all_languages[LANGUAGE_LIZARD]
	var/enchanting_phrase_language = L.process_text(null,enchanting_phrase)

	data += "*[enchanting_phrase_language]*"

	return ..()


/obj/item/paper/book/enchanting/fire
	stored_enchantment = /enchantment/fire
	value = 2000

/obj/item/paper/book/enchanting/stagger
	stored_enchantment = /enchantment/stagger
	value = 3000

/obj/item/paper/book/enchanting/stun
	stored_enchantment = /enchantment/stun
	value = 4000

/obj/item/paper/book/enchanting/disarm
	stored_enchantment = /enchantment/disarm
	value = 3000

/obj/item/paper/book/enchanting/blood_leech
	stored_enchantment = /enchantment/blood_leech
	value = 4000

/obj/item/paper/book/enchanting/soul_trap
	stored_enchantment = /enchantment/soul_trap
	value = 1000
