/contract/
	var/name = "Contract Name"
	var/desc = "Contract Description"
	var/atom/type_to_check
	var/amount = 0
	var/obj/item/reward
	var/objective_text = "objectives completed"




//Ashwalkers
/contract/ashwalkers
	name = "Kill Ashwalkers"
	desc = "Kill Ashwalkers."
	type_to_check = /mob/living/advanced/npc/ashwalker
	objective_text = "Ashwalkers killed"

/contract/ashwalkers/low
	amount = 10
	reward = /obj/item/currency/gold{amount=10*5}

/contract/ashwalkers/mid
	amount = 20
	reward = /obj/item/currency/gold{amount=10*5*1.5}

/contract/ashwalkers/high
	amount = 30
	reward = /obj/item/currency/gold{amount=10*5*3}

//Arachnids
/contract/arachnids
	name = "Kill Arachnids"
	desc = "Kill Arachnids."
	type_to_check = /mob/living/simple/arachnid
	objective_text = "Arachnids killed"

/contract/arachnids/low
	amount = 5
	reward = /obj/item/currency/gold{amount=5*5}

/contract/arachnids/mid
	amount = 10
	reward = /obj/item/coin/antag_token{amount=1}

/contract/arachnids/high
	amount = 25
	reward = /obj/item/currency/gold{amount=25*5*2}

//Bosses
/contract/ash_drake
	name = "Kill Ash Drake"
	desc = "Kill Ash Drake."
	type_to_check = /mob/living/simple/ash_drake
	objective_text = "Ash Drakes killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=2}

/contract/bubblegum
	name = "Kill Bubblegum"
	desc = "Kill Bubblegum."
	type_to_check = /mob/living/simple/bubblegum
	objective_text = "Bubblegums killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=2}

/contract/can_man
	name = "Kill Can Man"
	desc = "Kill Can Man."
	type_to_check = /mob/living/simple/can_man
	objective_text = "Can Men killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=2}

/contract/colossus
	name = "Kill Colossus"
	desc = "Kill Colossus."
	type_to_check = /mob/living/simple/colossus
	objective_text = "Colossus killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=1}

/contract/goblin_king
	name = "Kill the Goblin King"
	desc = "Kill the Goblin King."
	type_to_check = /mob/living/simple/goblin_king
	objective_text = "Goblin Kings killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=1}

/contract/herald
	name = "Kill the Herald"
	desc = "Kill the Herald."
	type_to_check = /mob/living/simple/herald
	objective_text = "Heralds killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=1}

/contract/hierophant
	name = "Kill the Hierophant"
	desc = "Kill the Hierophant."
	type_to_check = /mob/living/simple/hierophant
	objective_text = "Hierophants killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=1}

/contract/leaper
	name = "Kill the Leaper"
	desc = "Kill the Leaper."
	type_to_check = /mob/living/simple/leaper
	objective_text = "Leapers killed"
	amount = 1
	reward = /obj/item/coin/antag_token{amount=1}

/contract/queen
	name = "Kill the Xeno Queen"
	desc = "Kill the Xeno Queen."
	type_to_check = /mob/living/simple/xeno/queen
	objective_text = "Xeno Queens killed"
	amount = 1
	reward = /obj/item/currency/gold{amount=100}
