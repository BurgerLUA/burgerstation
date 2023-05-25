//Arachnids
/obj/item/contract/arachnids
	name = "Kill Arachnids"
	desc = "Kill Arachnids."
	type_to_check = /mob/living/simple/arachnid
	objective_text = "Arachnids killed"

/obj/item/contract/arachnids/low
	value_max = 5
	reward = /obj/item/currency/credits{amount=5*200}
	burgerbux_reward = 1

/obj/item/contract/arachnids/mid
	value_max = 10
	reward = /obj/item/currency/credits{amount=10*200*1.5}
	burgerbux_reward = 5

/obj/item/contract/arachnids/high
	value_max = 25
	reward = /obj/item/currency/credits{amount=25*200*2}
	burgerbux_reward = 10