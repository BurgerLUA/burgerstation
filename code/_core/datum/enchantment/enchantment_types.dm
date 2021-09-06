/enchantment/fire
	name = "Blaze"
	desc = "Sets targets on fire."
	enchanting_phrase = "Woah Momma, That's a spicy meatball!"
	cost = 75

/enchantment/fire/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.ignite(strength*5*(total_damage_dealt/80),attacker)
	return ..()


/enchantment/stagger
	name = "Stagger"
	desc = "Has a chance to stagger opponents."
	enchanting_phrase = "Oh fuck I slipped! Fucking nerf soap!"
	cost = 100

/enchantment/stagger/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim) && prob(strength*5*min(1,total_damage_dealt/100)))
		var/mob/living/L = victim
		L.add_status_effect(STAGGER,3,3)
	return ..()


/enchantment/stun
	name = "Stun"
	desc = "Has a chance to stun opponents."
	enchanting_phrase = "Fucking stunlockers are fucking noobs, I'm tired of this shit!"
	cost = 200

/enchantment/stun/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim) && prob(strength*2.5*(total_damage_dealt/100)))
		var/mob/living/L = victim
		L.add_status_effect(STUN,10,10)
	return ..()


/enchantment/disarm
	name = "Disarm"
	desc = "Has a chance to disarm opponents."
	enchanting_phrase = "Why are my fucking hands made of butter?"
	cost = 150

/enchantment/disarm/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_advanced(victim) && prob(strength*5*(total_damage_dealt/50)))
		var/mob/living/advanced/L = victim
		L.add_status_effect(DISARM,50,50)
	return ..()

/enchantment/blood_leech
	name = "Blood Leech"
	desc = "Restores blood relative to damage dealt. Only works on living targets."
	enchanting_phrase = "Blood for the blood god!"
	cost = 125

/enchantment/blood_leech/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(attacker) && is_living(victim))
		var/mob/living/V = victim
		var/mob/living/A = attacker
		if(!A.dead && !V.dead)
			var/blood_to_steal = min(total_damage_dealt*0.1*strength,V.blood_volume,A.blood_volume_max - A.blood_volume)
			if(blood_to_steal > 0)
				V.blood_volume -= blood_to_steal
				A.blood_volume = clamp(A.blood_volume+blood_to_steal,0,A.blood_volume_max)

	return ..()

/enchantment/soul_trap
	name = "Soul Trap"
	desc = "Traps the soul of most living beings."
	enchanting_phrase = "Gingers have souls!"
	cost = 50

/enchantment/soul_trap/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.add_status_effect(SOULTRAP,10 + strength*30,10 + strength*30)
	return ..()