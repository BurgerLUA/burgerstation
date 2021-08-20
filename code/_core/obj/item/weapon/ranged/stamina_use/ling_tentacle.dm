/obj/item/weapon/ranged/stamina_use/tentacle
	name = "tentacle"
	rarity = RARITY_LEGENDARY
	desc = "HELP MAINT."
	desc_extended = "A grody tentacle. <br>Use in hand to change whether you appear next to your enemies, or if they're thrown to you."
	icon = 'icons/obj/item/weapons/ranged/ling_tentacle.dmi'

	cost_stamina = 10

	shoot_delay = 15

	projectile = /obj/projectile/bio/tentacle
	ranged_damage_type = /damagetype/ranged/ling_tentacle/warp
	var/alt_ranged_damage_type = /damagetype/ranged/ling_tentacle/pull

	value = -1
	value_burgerbux = 1

	drop_sound = 'sound/items/drop/axe.ogg'

	size = SIZE_4
	weight = 6
	var/toggle = FALSE

/obj/item/weapon/ranged/stamina_use/tentacle/update_icon()

	if(toggle)
		ranged_damage_type = alt_ranged_damage_type

	else
		ranged_damage_type = initial(ranged_damage_type)

	return ..()

/obj/item/weapon/ranged/stamina_use/tentacle/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	toggle = !toggle
	update_icon()
	if(toggle)
		caller.to_chat(span("notice","You will now drag your enemies."))
	else
		caller.to_chat(span("notice","You will now drag yourself to your enemies."))
	return TRUE
