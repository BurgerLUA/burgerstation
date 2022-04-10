/obj/item/clothing/overwear/hardsuit/syndie
	name = "mauler hardsuit mk1"
	desc = "GET DAT FUKKEN DISK!"
	desc_extended = "The first model of mauler hardsuit, and a common sight during the Nuclear Operatives era. Today it's mostly surplus worn by Syndicate grunts."
	icon = 'icons/obj/item/clothing/suit/syndie_basic.dmi'


	armor = /armor/hardsuit/combat/syndicate

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/syndie)

	value = 400

/obj/item/clothing/overwear/hardsuit/syndie/advanced
	name = "mauler hardsuit mk2"
	desc = "Perimeter Secured."
	desc_extended = "The current model in service by medium to high level Syndicate operatives. People wearing this are not to be treated lightly."
	icon = 'icons/obj/item/clothing/suit/syndie_advanced.dmi'


	armor = /armor/hardsuit/combat/syndicate/plus

	size = SIZE_6


	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/syndie/advanced)

	value = 600

/obj/item/clothing/overwear/hardsuit/syndie/elite
	name = "mauler hardsuit mk3"
	desc = "May I make a suggestion? Run."
	desc_extended = "A prototype suit in use by the best of the best of Syndicate Operatives. Lightweight and agile but still heavily armored. Don't attempt to face someone wearing this alone."
	icon = 'icons/obj/item/clothing/suit/syndie_elite.dmi'


	armor = /armor/hardsuit/combat/syndicate/fast

	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/syndie/elite)

	size = SIZE_6
	weight = 10 //Now the suit actually speeds you up.

	value = 1200

	speed_bonus = 0.1
