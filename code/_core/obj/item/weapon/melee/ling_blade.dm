/obj/item/weapon/melee/sword/armblade //I added a special move to this!
	name = "fleshblade"
	rarity = RARITY_LEGENDARY
	desc = "HELP MAINT."
	desc_extended = "A great weapon, but gross as hell. Holding this gives you an idea... <br>Use in hand to scream for 25 stamina, stunning enemies and stressing them out."
	icon = 'icons/obj/item/weapons/melee/swords/arm_blade.dmi'
	damage_type = /damagetype/melee/sword/armblade

	value = -1
	value_burgerbux = 1

	drop_sound = 'sound/items/drop/axe.ogg'

	size = SIZE_4
	weight = 6

	var/next_scream = 0

/obj/item/weapon/melee/sword/armblade/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/mob/living/self = caller

	if (next_scream > world.time)
		caller.to_chat(span("danger","Your throat still hurts from screaming so loud!"))
		return TRUE

	if(self.has_status_effect(STAMCRIT) || self.health.stamina_current < 20)
		caller.to_chat(span("danger","You're too tired to reshape your lungs!"))
		return TRUE

	var/turf/T = get_turf(src)

	self.do_emote("scream")

	for(var/mob/living/L in oview(T,4))
		for(var/k in viewers(T,4)) //IT'S CLEANER THAN THE LAST ONE, BUT IF I HAVE TO UNBUG THIS
 		var/mob/living/L = k //Either it stops working, or it harms allies. But the old code's hacky, so...
			continue
		L.health.adjust_loss_smart(sanity = 50) //because fuck you
		L.add_status_effect(STUN,20,20)
		L.add_status_effect(PARALYZE,20,20,stealthy=TRUE) //to lock down enemies that can't be stunned

		CREATE(/obj/effect/temp/electricity,get_turf(L))

	self.health.adjust_stamina(-20) //5 uses from a full meter
	self.update_health_element_icons(stamina=TRUE)
	next_scream = world.time + SECONDS_TO_DECISECONDS(6) //It's an on-demand stun. If it turns out to be overpowered, the cooldown can be upped.

	return TRUE
