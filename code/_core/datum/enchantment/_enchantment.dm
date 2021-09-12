/enchantment/
	var/name = "Enchantment Name"
	var/desc = "Enchantment Description"
	var/enchanting_phrase = "Memes"

	var/charge = 0
	var/cost = 100
	var/strength = 1

/enchantment/proc/generate_stats(var/mob/living/caller,var/obj/item/weapon/desired_weapon,var/obj/item/soulgem/desired_soulgem)
	charge = desired_soulgem.total_charge
	cost = initial(cost) * strength * (1 - caller.get_skill_power(SKILL_MAGIC_ENCHANTING,0,1,1)*0.5)
	strength = (1 + caller.get_skill_power(SKILL_MAGIC_ENCHANTING,0,1,2)) * (charge/SOUL_SIZE_MYSTIC)*10
	strength = CEILING(strength,1)
	name = "[initial(name)] \Roman[strength]"
	return strength * cost

/enchantment/proc/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	return TRUE