/mob/living/advanced/proc/add_species_health_elements()
	for(var/k in mob_species.spawning_health)
		var/obj/health/v = mob_species.spawning_health[k]
		v = new v
		add_health_element(v)

mob/living/advanced/update_health()

	var/changed = FALSE

	var/new_health_max = 100 + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	var/new_mana_max = 100 + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400
	var/new_stamina_max = 100 + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400

	health_regeneration = get_attribute_power(ATTRIBUTE_VITALITY,0,100)*0.125
	stamina_regeneration = 0.2 + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*4
	mana_regeneration = 0.1 + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*2

	if(new_health_max != health_max)
		health_max = new_health_max
		changed = TRUE

	if(new_mana_max != mana_max)
		mana_max = new_mana_max
		changed = TRUE

	if(new_stamina_max != stamina_max)
		stamina_max = new_stamina_max
		changed = TRUE

	var/damage_current = 0
	for(var/obj/item/organ/O in organs)
		damage_current += O.get_total_loss()

	var/new_health_current = health_max - damage_current

	if(new_health_current != health_current)
		health_current = new_health_current
		changed = TRUE

	if(changed) //TODO: Do something here.
		changed = FALSE

	if(health_current <= 0)
		death()