/contract/
	var/name = "Contract Name"
	var/desc = "Contract Description"
	var/atom/type_to_check
	var/amount_min = 0
	var/amount_max = 0
	var/reward_min = 0
	var/reward_max = 0
	var/reward_text = "objectives completed"

/contract/proc/get_random_reward()
	if(!reward_min)
		return reward_max
	if(!reward_max)
		return reward_min
	return rand(reward_min,reward_max)

/contract/proc/get_random_amount()
	if(!amount_min)
		return amount_max
	if(!amount_max)
		return amount_min
	return rand(amount_min,amount_max)

/contract/proc/on_scan(var/atom/A,var/obj/item/contract/C)
	return istype(A,type_to_check)

/contract/obtain/

/contract/obtain/on_scan(var/atom/A,var/obj/item/contract/C)
	. = ..()
	if(.)
		if(istype(A,/obj/item))
			var/obj/item/I = A
			var/amount_to_remove = min(C.amount_max - C.amount_current,I.item_count_current)
			I.item_count_current -= amount_to_remove
			C.amount_current += amount_to_remove
			if(I.item_count_current <= 0)
				qdel(I)
			return TRUE
		else
			qdel(A)
			C.amount_current += 1
			return TRUE

/contract/obtain/scroll
	name = "Obtain Experience Scrolls"
	desc = "Obtain experience scrolls of any type."
	type_to_check = /obj/item/experience_scroll
	amount_min = 10
	amount_max = 5
	reward_min = 5000
	reward_max = 10000
	reward_text = "experience scrolls obtained"


/contract/kill

/contract/kill/on_scan(var/atom/A,var/obj/item/contract/C)
	. = ..()
	if(.)
		if(istype(A,/mob/living/))
			var/mob/living/L = A
			if(!L.dead)
				return FALSE
			L.dust()
			C.amount_current += 1
			return TRUE
		else
			qdel(A)
			C.amount_current += 1
			return TRUE

/contract/kill/ashwalkers
	name = "Kill Ashwalkers"
	desc = "Kill Ashwalkers."
	type_to_check = /mob/living/advanced/npc/ashwalker
	amount_min = 20
	amount_max = 50
	reward_min = 5000
	reward_max = 10000
	reward_text = "Ashwalkers killed"