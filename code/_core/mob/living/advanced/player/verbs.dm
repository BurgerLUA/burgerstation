/*
mob/living/advanced/player/verb/heal_self()
	set name = "Heal Self"
	set category = "Cheat"

	for(var/obj/item/organ/O in organs)
		O.health.adjust_brute_loss(-5)
		//O.health.adjust_burn_loss(-1000)
		//O.health.adjust_tox_loss(-1000)
		//O.health.adjust_oxy_loss(-1000)
		O.health.update_health()


mob/living/advanced/player/verb/damage_self()
	set name = "Damage Self"
	set category = "Cheat"

	for(var/obj/item/organ/O in organs)
		O.health.adjust_brute_loss(5)
		//O.health.adjust_burn_loss(10)
		//O.health.adjust_tox_loss(10)
		//O.health.adjust_oxy_loss(10)
		O.health.update_health()
*/