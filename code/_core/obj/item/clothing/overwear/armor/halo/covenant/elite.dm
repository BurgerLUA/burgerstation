/obj/item/clothing/overwear/armor/halo/covenant/elite
	name = "Sangheili Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "An armored protective vest worn by the Minor Elites."
	icon = 'icons/obj/item/clothing/suit/elite_m.dmi'

	armor = /armor/hardsuit/combat/syndicate/ultra

	size = SIZE_6

	flags_clothing = FLAG_CLOTHING_NOHUMAN
	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT,BODY_LEG_LEFT,BODY_LEG_RIGHT)

	value = 300

	can_negate_damage = TRUE

	var/damage_limit = 100 //how much damage before the shield breaks
	var/cooldown_time = SECONDS_TO_DECISECONDS(10) //How long it takes for the shield to reactivate.

	var/obj/effect/shield_overlay

/obj/item/clothing/overwear/armor/halo/covenant/elite/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn && is_advanced(I.owner))
		HOOK_ADD("post_move","\ref[src]_shield_post_move",I.owner,src,src::owner_post_move())
	disable_shield()

/obj/item/clothing/overwear/armor/halo/covenant/elite/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	if(old_inventory.worn && is_advanced(old_inventory.owner))
		HOOK_REMOVE("post_move","\ref[src]_shield_post_move",old_inventory.owner)
	disable_shield()

/obj/item/clothing/overwear/armor/halo/covenant/elite/proc/owner_post_move(var/mob/living/advanced/owner,var/atom/old_loc)
	shield_overlay.glide_size = owner.glide_size
	shield_overlay.force_move(owner.loc)
	return TRUE

/obj/item/clothing/overwear/armor/halo/covenant/elite/New(var/desired_loc)
	. = ..()
	shield_overlay = new(src)
	shield_overlay.mouse_opacity = 0
	shield_overlay.icon = 'icons/halo/effects/shields/elite_shields.dmi'
	shield_overlay.icon_state = "shield_overlay"
	shield_overlay.alpha = 0

/obj/item/clothing/overwear/armor/halo/covenant/elite/PreDestroy()
	CALLBACK_REMOVE("\ref[src]_cooldown_end")
	CALLBACK_REMOVE("\ref[src]_shield_beep")
	QDEL_NULL(shield_overlay)
	. = ..()

/obj/item/clothing/overwear/armor/halo/covenant/elite/proc/disable_shield()
	damage_limit = initial(damage_limit)
	shield_overlay.alpha = 200
	shield_overlay.icon_state = "shield_overlay_recharge"
	CALLBACK("\ref[src]_cooldown_end",cooldown_time,src,src::cooldown_end())
	shield_beep()
	return TRUE

/obj/item/clothing/overwear/armor/halo/covenant/elite/proc/shield_beep()
	if(!CALLBACK_EXISTS("\ref[src]_cooldown_end")) //Only beep if there is a cooldown.
		return FALSE
	play_sound('sound/effects/halo/shields/elite/shield_down_elite.ogg',get_turf(src))
	CALLBACK("\ref[src]_shield_beep",SECONDS_TO_DECISECONDS(1),src,src::shield_beep())
	return TRUE

/obj/item/clothing/overwear/armor/halo/covenant/elite/proc/cooldown_end()
	shield_overlay.alpha = 0
	shield_overlay.icon_state = "shield_overlay"
	play_sound('sound/effects/halo/shields/elite/shield_recharge_elite.ogg',get_turf(src))
	return TRUE

/obj/item/clothing/overwear/armor/halo/covenant/elite/negate_damage(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damage_dealt=0)

	if(damage_dealt <= 0) //The damage doesn't exist for some reason.
		return FALSE

	if(damage_limit <= 0) //No damage can be protected!
		return FALSE

	if(CALLBACK_EXISTS("\ref[src]_cooldown_end")) //Cooling down, can't do anything right now.
		CALLBACK("\ref[src]_cooldown_end",cooldown_time,src,src::cooldown_end()) //restart recharge
		return FALSE

	animate(shield_overlay,alpha=clamp(damage_dealt+100,100,255),time=0,flags=ANIMATION_END_NOW)
	animate(alpha=0,time=5)

	damage_limit -= damage_dealt

	if(damage_limit <= 0)
		disable_shield()
		return FALSE

	return TRUE

/obj/item/clothing/overwear/armor/halo/covenant/elite/major
	name = "Sangheili Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "An armored protective vest worn by the Major Elites."
	icon = 'icons/obj/item/clothing/suit/elite_mj.dmi'

/obj/item/clothing/overwear/armor/halo/covenant/elite/ultra
	name = "Sangheili Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "An armored protective vest worn by the Ultra Elites."
	icon = 'icons/obj/item/clothing/suit/elite_ultra.dmi'

/obj/item/clothing/overwear/armor/halo/covenant/elite/shipmaster
	name = "Sangheili Combat Harness"
	desc = "Aliens! Yay!"
	desc_extended = "An armored protective vest worn by the Shipmaster Elites."
	icon = 'icons/obj/item/clothing/suit/elite_sm.dmi'