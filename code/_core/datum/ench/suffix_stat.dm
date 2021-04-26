/ench/suffix/stat/
	var/stat_id = HEALTH
	desc = "Increases your max %STAT by #M."
	magnitude_min = 1
	magnitude_max = 10

/ench/suffix/stat/on_equipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.add_mob_value("[stat_id]","ench:\ref[src]",magnitude)
	if(L.health)
		L.health.update_health_stats()

/ench/suffix/stat/on_unequipped(var/mob/living/L,var/obj/item/clothing/C)
	. = ..()
	L.remove_mob_value("[stat_id]","ench:\ref[src]")
	if(L.health)
		L.health.update_health_stats()

/ench/suffix/stat/get_description()
	. = ..()
	. = replacetextEx(.,"#STAT",stat_id)

/ench/suffix/stat/health
	name = "Health"
	stat_id = HEALTH

/ench/suffix/stat/stamina
	name = "Stamina"
	stat_id = STAMINA

/ench/suffix/stat/mana
	name = "Mana"
	stat_id = MANA