/enchantment/fire
	name = "Blaze"
	desc = "Sets targets on fire."
	enchanting_phrase = "Woah Momma, That's a spicy meatball!"

/enchantment/fire/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.ignite(strength*5*(total_damage_dealt/80))
	return ..()


/enchantment/stagger
	name = "Stagger"
	desc = "Has a chance to stagger opponents."
	enchanting_phrase = "Oh fuck I slipped! Fucking nerf soap!"

/enchantment/stagger/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim) && prob(strength*10*(total_damage_dealt/50)))
		var/mob/living/L = victim
		L.add_status_effect(STAGGER,5*(total_damage_dealt/80),5*(total_damage_dealt/80))
	return ..()


/enchantment/stun
	name = "Stun"
	desc = "Has a chance to stun opponents."
	enchanting_phrase = "Fucking stunlockers are fucking noobs, I'm tired of this shit!"

/enchantment/stun/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim) && prob(strength*5*(total_damage_dealt/50)))
		var/mob/living/L = victim
		L.add_status_effect(STUN,10*(total_damage_dealt/80),10*(total_damage_dealt/80))
	return ..()


/enchantment/disarm
	name = "Disarm"
	desc = "Has a chance to disarm opponents."
	enchanting_phrase = "Why are my fucking hands made of butter?"

/enchantment/disarm/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_advanced(victim) && prob(strength*5*(total_damage_dealt/50)))
		var/mob/living/advanced/L = victim
		L.add_status_effect(DISARM,50,50)
	return ..()

/enchantment/blood_leech
	name = "Blood Leech"
	desc = "Restores blood relative to damage dealt. Only works on living targets."
	enchanting_phrase = "Why are my fucking hands made of butter?"

/enchantment/blood_leech/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(attacker) && is_living(victim))
		var/mob/living/L1 = victim
		var/mob/living/L2 = victim
		if(!L1.dead && !L2.dead)
			L1.blood_volume = clamp(L1.blood_volume+total_damage_dealt*0.1*strength,0,L1.blood_volume_max)
	return ..()