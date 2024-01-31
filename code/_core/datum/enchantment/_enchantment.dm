/enchantment/
	var/name = "Enchantment Name"
	var/desc = "Enchantment Description"
	var/enchanting_phrase = "Memes"
	var/max_charge = 0
	var/charge = 0
	var/cost = 100
	var/strength = 1

/enchantment/proc/generate_stats(mob/living/caller,obj/item/weapon/desired_weapon,obj/item/soulgem/desired_soulgem)
	charge = desired_soulgem.total_charge
	max_charge = desired_soulgem.total_charge
	cost = initial(cost) * strength * (1 - caller.get_skill_power(SKILL_SUMMONING,0,1,1)*0.5)
	strength = (1 + caller.get_skill_power(SKILL_SUMMONING,0,1,2)) * (charge/SOUL_SIZE_MYSTIC)*10
	strength = CEILING(strength,1)
	return strength * cost * 0.1

/enchantment/proc/on_hit(atom/attacker,atom/victim,obj/item/weapon/weapon,atom/hit_object,atom/blamed,total_damage_dealt=0)
	return TRUE