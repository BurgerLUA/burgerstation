/obj/item/clothing/head/helmet/hardsuit/

	hidden_organs = list(
		BODY_HEAD = TRUE,
		BODY_HAIR_HEAD = TRUE,
		BODY_HAIR_FACE = TRUE,
		BODY_EYES = TRUE
	)

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD | SLOT_FACE

/obj/item/clothing/head/helmet/hardsuit/engineering
	name = "engineering rig helmet"
	desc = "The SM is at 9% health? Eh, it's probably gonna be fine"
	desc_extended = "A hardsuit worn by engineers. Able to withstand incredible heat in order to work with engines."
	icon = 'icons/obj/item/clothing/hats/engineering_rig_helmet.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		MAGIC = -100,
		HEAT = 75,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 80


/obj/item/clothing/head/helmet/hardsuit/syndie
	name = "mauler helmet mk1"
	desc = "GET DAT FUKKEN DISK!"
	desc_extended = "The first model of mauler hardsuit, and a common sight during the Nuclear Operatives era. Today it's mostly surplus worn by Syndicate grunts."
	icon = 'icons/obj/item/clothing/hats/syndie_basic.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_4
	weight = WEIGHT_5

	value = 200

/obj/item/clothing/head/helmet/hardsuit/syndie/advanced
	name = "mauler helmet mk2"
	desc = "Perimeter Secured."
	desc_extended = "The current model in service by medium to high level Syndicate operatives. People wearing this are not to be treated lightly."
	icon = 'icons/obj/item/clothing/hats/syndie_advanced.dmi'
	rarity = RARITY_RARE

	defense_rating = list(
		BLADE = 50,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 300

/obj/item/clothing/head/helmet/hardsuit/syndie/elite
	name = "mauler helmet mk3"
	desc = "May I make a suggestion? Run."
	desc_extended = "A prototype suit in use by the best of the best of Syndicate Operatives. Lightweight and agile but still heavily armored. Don't attempt to face someone wearing this alone."
	icon = 'icons/obj/item/clothing/hats/syndie_elite.dmi'
	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 25,
		BLUNT = 100,
		PIERCE = 100,
		LASER = 50,
		MAGIC = -100,
		HEAT = 75,
		COLD = 75,
		BOMB = 75,
		BIO = 75,
		RAD = 25
	)

	size = SIZE_3
	weight = WEIGHT_4

	slowdown_mul_worn = 0.75

	value = 500

/obj/item/clothing/head/helmet/hardsuit/mining
	name = "mining hardsuit helmet"
	desc = "MIIIIINIIIIING DIAAAAMOOOOOONDS!"
	desc_extended = "A hardsuit worn by miners to protect against a variety of hazards, such as rock falls, black lungs, and cave monsters."
	icon = 'icons/obj/item/clothing/hats/hardsuit_mining.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		HEAT = 100,
		COLD = 75,
		BOMB = 25,
		BIO = 75,
		RAD = 75
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 300


/obj/item/clothing/head/helmet/hardsuit/medical
	name = "medical voidsuit"
	desc = "Out the fucking way!"
	desc_extended = "A hardsuit worn by medics while retrieving corpses to avoid becoming a corpse themselves."
	icon = 'icons/obj/item/clothing/hats/hardsuit_medical.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		DARK = -25,
		HOLY = 25,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 100,
		RAD = 100
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 300

/obj/item/clothing/head/helmet/hardsuit/seva
	name = "SEVA suit"
	desc = "Idi ko mne"
	desc_extended = "An eastern european model of Hazardous Enviroments Suit, favored by scientists, scavengers and anomaly worshipping fanatics alike!"
	icon = 'icons/obj/item/clothing/hats/seva_suit.dmi'
	rarity = RARITY_UNCOMMON

	defense_rating = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 25,
		MAGIC = -50,
		DARK = 25,
		HOLY = -25,
		HEAT = 75,
		COLD = 75,
		BOMB = 25,
		BIO = 100,
		RAD = 100
	)

	size = SIZE_3
	weight = WEIGHT_4

	value = 300

/obj/item/clothing/head/helmet/hardsuit/seva/mono
	icon = 'icons/obj/item/clothing/hats/sevamono_suit.dmi'