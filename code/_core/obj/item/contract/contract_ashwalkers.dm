/obj/item/contract/ashwalker
	name = "contract: Kill Ashwalkers"
	type_to_check = /mob/living/advanced/npc/ashwalker
	objective_text = "Ashwalkers killed"
	value = 0

/obj/item/contract/ashwalker/low
	value_max = 10
	burgerbux_reward = 1
	reward = /obj/item/currency/credits{amount=10*50}
	value = 1

/obj/item/contract/ashwalker/mid
	value_max = 25
	burgerbux_reward = 5
	reward = /obj/item/currency/credits{amount=25*50*1.5}
	value = 1

/obj/item/contract/ashwalker/high
	value_max = 50
	burgerbux_reward = 10
	reward = /obj/item/currency/credits{amount=50*50*2}
	value = 1








