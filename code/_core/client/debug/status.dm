client/verb/debug_stun()
	set category = "Debug"
	var/mob/living/L = mob
	L.add_stun(text2num(input("Stun amount?")))
