/obj/item/clothing/uniform/utility
	name = "utility uniform"
	desc = "Sleek and efficient."
	desc_extended = "Black jumpsuit worn by low-ranking crewmembers. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_gen.dmi'

	item_slot = SLOT_TORSO

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	defense_rating = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		COLD = 40,
		HEAT = -20
	)

	value = 50

/obj/item/clothing/uniform/utility/engineering
	name = "engineering utility uniform"
	desc = "3.6 Roentgen, not great, not terrible."
	desc_extended = "Black jumpsuit with color marking denoting its wearer as engineering personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_engi.dmi'

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		COLD = 20,
		HEAT = 40,
		RAD = 40
	)

	value = 50

/obj/item/clothing/uniform/utility/medical
	name = "medical utility uniform"
	desc = "Hehe monke organ farming."
	desc_extended = "Black jumpsuit with color marking denoting its wearer as medical personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_med.dmi'

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		COLD = 10,
		HEAT = 10,
		RAD = 10,
		BIO = 20
	)

	value = 50

/obj/item/clothing/uniform/utility/science
	name = "science utility uniform"
	desc = "MAXCAPING LAVALAND LES GO."
	desc_extended = "Black jumpsuit with color marking denoting its wearer as research personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_sci.dmi'

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		COLD = 15,
		HEAT = 15,
		BOMB = 30,
		BIO = 20
	)

	value = 50

/obj/item/clothing/uniform/utility/supply
	name = "supply utility uniform"
	desc = "*orders weapons with malicious intent.*"
	desc_extended = "Black jumpsuit with color marking denoting its wearer as supply personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_sup.dmi' //yo

	defense_rating = list(
		BLADE = 20,
		BLUNT = 5,
		PIERCE = 5,
		COLD = 10,
		HEAT = 10,
		BOMB = 10,
		PAIN = 30
	)

	value = 50

/obj/item/clothing/uniform/utility/security
	name = "security utility uniform"
	desc = "HALP SHITCURITY BEATING ME!1!!1"
	desc_extended = "Black jumpsuit with color marking denoting its wearer as security personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_sec.dmi'

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		COLD = 10,
		HEAT = 10,
		BOMB = 20,
		PAIN = 25
	)

	value = 50

/obj/item/clothing/uniform/utility/command
	name = "command utility uniform"
	desc = "Hm, today I will call shuttle for no reisin."
	desc_extended = "Black jumpsuit with color marking denoting its wearer as command personnel. Looks cool."
	icon = 'icons/obj/item/clothing/uniforms/util_cmd.dmi'

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		COLD = 10,
		HEAT = 10,
		BOMB = 20,
		PAIN = 25
	)

	value = 50

