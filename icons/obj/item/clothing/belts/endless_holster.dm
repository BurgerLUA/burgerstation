/obj/item/clothing/belt/endless_holster
	name = "endless revolver holster"
	desc = "Aleph-2 shots, enough to kill anything."
	desc_extended = "A fancy pair of holsters that holds as many revolvers as you can think of."
	icon = 'icons/obj/item/clothing/belts/white.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT

	dyeable = TRUE

	rarity = RARITY_RARE
	value = 1000
	size = SIZE_3
	var/list/created_gun = list() //it's not elegant, but...

/obj/item/clothing/belt/endless_holster/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	var/mob/living/self = caller
	if(istype(object,/obj/hud/inventory))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)
		if (self.health.mana_current < 10)
			caller.to_chat(span("danger","Your mind's too burnt out to think of a revolver!"))
			return FALSE
		var/obj/hud/inventory/I = object
		var/obj/item/weapon/ranged/temporary/revolver/G = pickweight(created_gun)
		G = new/obj/item/weapon/ranged/temporary/revolver(get_turf(src))
		INITIALIZE(G)
		GENERATE(G)
		FINALIZE(G)
		I.add_object(G)

		self.health.adjust_mana(-10)

		self.update_health_element_icons(mana=TRUE)

		self.mana_regen_delay = max(self.mana_regen_delay,30)

		update_sprite()
		return TRUE

	. = ..()
