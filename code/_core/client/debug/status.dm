/client/verb/debug_stun()
	set category = "Debug"
	var/mob/living/L = mob
	var/amount = input("Stun amount?") as num|null
	if(amount)
		L.add_stun(amount)
