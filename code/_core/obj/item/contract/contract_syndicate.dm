/obj/item/contract/syndicate
	name = "contract: Kill Syndicate"
	desc = "Kill Syndicate."
	type_to_check = /mob/living/advanced/npc/syndicate
	objective_text = "Syndicate killed"

/obj/item/contract/syndicate/low
	value_max = 10
	burgerbux_reward = 1
	reward = /obj/item/currency/credits{amount=10*50}

/obj/item/contract/syndicate/mid
	value_max = 25
	burgerbux_reward = 5
	reward = /obj/item/currency/credits{amount=25*50*1.5}

/obj/item/contract/syndicate/high
	value_max = 50
	burgerbux_reward = 10
	reward = /obj/item/currency/credits{amount=50*50*2}