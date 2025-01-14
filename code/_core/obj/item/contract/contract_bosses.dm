//Bosses
/obj/item/contract/boss/Generate()

	if(!reward)
		var/loot/L = LOOT(/loot/lavaland/contract)
		if(L)
			var/list/spawned_loot = L.do_spawn(src)
			if(length(spawned_loot) > 1) //Hacky fallback.
				reward = null
				for(var/k in spawned_loot)
					var/obj/item/I = k
					if(!reward)
						reward = I
					else
						qdel(I)
			else if(length(spawned_loot) == 0)
				reward = /obj/item/coin/adamantium
			else
				reward = spawned_loot[1]
		else
			reward = /obj/item/coin/adamantium

	. = ..()


/obj/item/contract/boss/ash_drake
	name = "contract: Kill Ash Drake"
	type_to_check = /mob/living/simple/ash_drake
	objective_text = "Ash Drakes killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/bubblegum
	name = "contract: Kill Bubblegum"
	type_to_check = /mob/living/simple/bubblegum
	objective_text = "Bubblegums killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/can_man
	name = "contract: Kill Can Man"
	type_to_check = /mob/living/simple/can_man
	objective_text = "Can Men killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/colossus
	name = "contract: Kill Colossus"
	type_to_check = /mob/living/simple/colossus
	objective_text = "Colossus killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/herald
	name = "contract: Kill the Herald"
	type_to_check = /mob/living/simple/herald
	objective_text = "Heralds killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/hierophant
	name = "contract: Kill the Hierophant"
	type_to_check = /mob/living/simple/hierophant
	objective_text = "Hierophants killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/leaper
	name = "contract: Kill the Leaper"
	type_to_check = /mob/living/simple/leaper
	objective_text = "Leapers killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/obj/item/contract/boss/queen
	name = "contract: Kill the Xeno Queen"
	type_to_check = /mob/living/simple/xeno/queen
	objective_text = "Xeno Queens killed"
	value_max = 1
	burgerbux_reward = 5
	value = 0

/*
/obj/item/contract/boss/broodmother
	name = "Kill the Broodmother"
	desc = "Kill the Broodmother."
	type_to_check = /mob/living/simple/goliath/broodmother
	objective_text = "XBroodmothers killed"
	value_max = 1
	burgerbux_reward = 5
*/