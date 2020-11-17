/enchantment/
	var/name = "Enchantment Name"
	var/desc = "Enchantment Description"
	var/strength = 1
	var/enchanting_phrase = "Memes"

/enchantment/proc/generate_stats(var/obj/item/weapon/desired_weapon,var/obj/item/soulgem/desired_soulgem)

	strength = CEILING(desired_soulgem.total_charge/1000,1)
	name = "[initial(name)] \Roman[strength]"

	return TRUE

/enchantment/proc/on_hit(var/atom/attacker,var/atom/victim,var/obj/item/weapon/weapon,var/atom/hit_object,var/atom/blamed,var/total_damage_dealt=0)
	return TRUE