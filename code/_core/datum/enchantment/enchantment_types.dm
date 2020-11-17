/enchantment/fire
	name = "Blaze"
	desc = "Sets targets on fire."
	enchanting_phrase = "That's a spicy meatball!"

/enchantment/fire/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.ignite(strength*5)
	return ..()


/enchantment/stagger
	name = "Stagger"
	desc = "Has a chance to stagger opponents."
	enchanting_phrase = "That's a spicy meatball!"

/enchantment/fire/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	if(is_living(victim))
		var/mob/living/L = victim
		L.ignite(strength*5)
	return ..()