/obj/item/contract/ashwalker
	name = "contract: Kill Ashwalkers"
	desc = "Kill Ashwalkers."
	type_to_check = /mob/living/advanced/npc/ashwalker
	objective_text = "Ashwalkers killed"

/obj/item/contract/ashwalker/low
	amount_max = 10
	burgerbux_reward = 1
	reward = /obj/item/currency/credits{item_count_current=10*50}

/obj/item/contract/ashwalker/mid
	amount_max = 25
	burgerbux_reward = 5
	reward = /obj/item/currency/credits{item_count_current=25*50*1.5}

/obj/item/contract/ashwalker/high
	amount_max = 50
	burgerbux_reward = 10
	reward = /obj/item/currency/credits{item_count_current=50*50*2}

/obj/item/contract/syndicate
	name = "contract: Kill Syndicate"
	desc = "Kill Syndicate."
	type_to_check = /mob/living/advanced/npc/syndicate
	objective_text = "Syndicate killed"

/obj/item/contract/syndicate/low
	amount_max = 10
	burgerbux_reward = 1
	reward = /obj/item/currency/credits{item_count_current=10*50}

/obj/item/contract/syndicate/mid
	amount_max = 25
	burgerbux_reward = 5
	reward = /obj/item/currency/credits{item_count_current=25*50*1.5}

/obj/item/contract/syndicate/high
	amount_max = 50
	burgerbux_reward = 10
	reward = /obj/item/currency/credits{item_count_current=50*50*2}




//Arachnids
/obj/item/contract/arachnids
	name = "Kill Arachnids"
	desc = "Kill Arachnids."
	type_to_check = /mob/living/simple/arachnid
	objective_text = "Arachnids killed"

/obj/item/contract/arachnids/low
	amount_max = 5
	reward = /obj/item/currency/credits{item_count_current=5*200}
	burgerbux_reward = 1

/obj/item/contract/arachnids/mid
	amount_max = 10
	reward = /obj/item/currency/credits{item_count_current=10*200*1.5}
	burgerbux_reward = 5

/obj/item/contract/arachnids/high
	amount_max = 25
	reward = /obj/item/currency/credits{item_count_current=25*200*2}
	burgerbux_reward = 10

//Bosses
/obj/item/contract/ash_drake
	name = "Kill Ash Drake"
	desc = "Kill Ash Drake."
	type_to_check = /mob/living/simple/ash_drake
	objective_text = "Ash Drakes killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/bubblegum
	name = "Kill Bubblegum"
	desc = "Kill Bubblegum."
	type_to_check = /mob/living/simple/bubblegum
	objective_text = "Bubblegums killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/can_man
	name = "Kill Can Man"
	desc = "Kill Can Man."
	type_to_check = /mob/living/simple/can_man
	objective_text = "Can Men killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/colossus
	name = "Kill Colossus"
	desc = "Kill Colossus."
	type_to_check = /mob/living/simple/colossus
	objective_text = "Colossus killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/goblin_king
	name = "Kill the Goblin King"
	desc = "Kill the Goblin King."
	type_to_check = /mob/living/simple/goblin_king
	objective_text = "Goblin Kings killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/herald
	name = "Kill the Herald"
	desc = "Kill the Herald."
	type_to_check = /mob/living/simple/herald
	objective_text = "Heralds killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/hierophant
	name = "Kill the Hierophant"
	desc = "Kill the Hierophant."
	type_to_check = /mob/living/simple/hierophant
	objective_text = "Hierophants killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/leaper
	name = "Kill the Leaper"
	desc = "Kill the Leaper."
	type_to_check = /mob/living/simple/leaper
	objective_text = "Leapers killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/queen
	name = "Kill the Xeno Queen"
	desc = "Kill the Xeno Queen."
	type_to_check = /mob/living/simple/xeno/queen
	objective_text = "Xeno Queens killed"
	amount_max = 1
	burgerbux_reward = 5

/obj/item/contract/broodmother
	name = "Kill the Broodmother"
	desc = "Kill the Broodmother."
	type_to_check = /mob/living/simple/goliath/broodmother
	objective_text = "XBroodmothers killed"
	amount_max = 1
	burgerbux_reward = 5