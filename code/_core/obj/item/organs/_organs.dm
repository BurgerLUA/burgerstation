/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."
	var/id = null

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null
	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE
	var/gib_icon_state = null

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage/organic.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	var/break_threshold = 0 //0 Means it doesn't break. Other values means it breaks.

	var/attach_flag //The organ type that it wishes to attach to. Use FLAG_ORGAN_ flags.
	var/obj/item/organ/attached_organ //The organ that it is attached to.
	var/list/obj/item/organ/attached_organs //The organs that are attached to it.
	var/attach_method = 0 //0 Means it's attached to it. 1 means inside it. TODO: Flags.

	//var/style

	no_held_draw = TRUE

	var/enable_skin = TRUE
	var/enable_glow = FALSE
	var/enable_detail = FALSE
	var/enable_wounds = FALSE

	reagents = /reagent_container/limb

	var/hud_id

	var/can_be_targeted = FALSE

	var/target_bounds_x_min = 0
	var/target_bounds_x_max = 0

	var/target_bounds_y_min = 0
	var/target_bounds_y_max = 0

	var/list/visual_wounds = list(
		BRUTE = 0,
		BURN = 0

	)

	var/base_miss_chance = 0

	health_base = 100

	health = /health/obj/item/organ

	var/damage_layer = LAYER_MOB_INJURY

	var/bleeding = 0 //How much blood to use per second.

	var/damage_coefficient = 1 //How much should this contribute to the overall health value of an advanced mob?

	var/has_life = TRUE

	var/has_pain = FALSE

	var/list/defense_rating = HUMAN_ARMOR

	var/robotic = FALSE //Set to true if the limb is robotic.

	var/can_gib = TRUE

	mouse_opacity = 0 //For now

/obj/item/organ/get_base_transform()
	. = ..()
	var/matrix/M = .
	if(!is_advanced(loc) && !is_inventory(loc))
		M.Turn(pick(0,90,180,270))

/obj/item/organ/update_sprite()
	. = ..()

	transform = get_base_transform()

	if(enable_skin && additional_blends["skin"])
		var/icon_blend/IB = additional_blends["skin"]
		color = IB.color

/obj/item/organ/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(has_dropped_icon && !is_advanced(loc))
		icon_state = "[icon_state]_inventory"

/obj/item/organ/update_underlays()

	. = ..()

	if(has_dropped_icon_underlay && !is_advanced(loc))
		var/image/I = new/image(initial(icon),"[icon_state]_underlay")
		add_underlay(I)

/obj/item/organ/proc/get_defense_rating()
	return defense_rating

/obj/item/organ/proc/send_pain(var/pain_amount=50)
	var/mob/living/advanced/A = loc
	if(!A.send_pain(pain_amount))
		return FALSE
	on_pain()
	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.on_pain()
	return TRUE

/obj/item/organ/post_move(var/atom/old_loc)

	. = ..()

	if(is_inventory(old_loc) || is_inventory(loc) || is_advanced(old_loc) || is_advanced(loc))
		update_sprite()

/obj/item/organ/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	var/total_bleed_damage = SAFENUM(damage_table[BLADE])*2.5 + SAFENUM(damage_table[BLUNT])*0.75 + SAFENUM(damage_table[PIERCE])*1.5
	if(total_bleed_damage>0)
		var/bleed_to_add = total_bleed_damage/50
		src.bleeding += bleed_to_add

	if(is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(has_pain && atom_damaged == src && ((src.health && src.health.health_current <= 0) || critical_hit_multiplier > 1))
			if(!A.dead)
				send_pain(damage_amount)
		if(!A.immortal && !A.ckey_last && !A.boss && health && health.health_max <= damage_amount && A.health.health_current <= 0 && prob(SAFENUM(damage_table[BLADE]) + SAFENUM(damage_table[BLUNT])) )
			gib()
			A.death()

	return ..()

/obj/item/organ/proc/on_pain() //What happens if this organ is shot while broken. Other things can cause pain as well.
	return FALSE

/obj/item/organ/Destroy()
	color = "#000000"
	attached_organ = null
	attached_organs?.Cut()
	return ..()

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src
	return TRUE

/obj/item/organ/initialize_blends()

	if(enable_skin)
		add_blend("skin", desired_color = "#000000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_glow)
		add_blend("skin_glow", desired_icon = icon, desired_icon_state = "[icon_state]_glow", desired_color = "#000000", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_detail)
		add_blend("skin_detail", desired_icon = icon, desired_icon_state = "[icon_state]_color", desired_color = "#000000", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_wounds)
		for(var/damagetype in visual_wounds)
			add_blend("damage_[damagetype]", desired_icon = damage_icon, desired_icon_state = "none", desired_color = "#FFFFFF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY,desired_layer = damage_layer)

	return ..()

/obj/item/organ/New(var/desired_loc)
	. = ..()
	attached_organs = list()

/obj/item/organ/PostInitialize()
	. = ..()
	initialize_blends(icon_state)

/obj/item/organ/Finalize()
	. = ..()
	update_sprite()

/obj/item/organ/proc/unattach_from_parent(var/turf/T,var/do_delete=FALSE)

	unattach_children(T,do_delete)

	if(T)
		for(var/k in inventories)
			var/obj/hud/inventory/I = k
			var/list/dropped_objects = I.drop_objects(T)
			for(var/j in dropped_objects)
				var/obj/item/O = j
				animate(O,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=3)

	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,FALSE)
		if(do_delete)
			qdel(src)
			return TRUE
		else
			src.drop_item(T)
	else if(do_delete)
		qdel(src)
		return TRUE

	update_sprite()

	return TRUE

/obj/item/organ/proc/unattach_children(var/turf/T,var/do_delete=FALSE)
	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.unattach_from_parent(T,do_delete)
	return TRUE

/obj/item/organ/proc/gib()

	if(!can_gib)
		return TRUE

	var/turf/T = get_turf(src)

	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		if(!A.dead)
			A.visible_message(span("warning","\The [A.name]'s [src.name] explodes!"),span("danger","Your [src.name] explodes!"))
		if(A.blood_type)
			var/organ_size = ((target_bounds_x_max - target_bounds_x_min) * (target_bounds_y_max - target_bounds_y_min))/(4*4)
			var/reagent/R = REAGENT(A.blood_type)
			for(var/i=1,i<=clamp(organ_size,1,4),i++)
				create_blood(/obj/effect/cleanable/blood/gib,T,R.color,rand(-TILE_SIZE*3,TILE_SIZE*3),rand(-TILE_SIZE*3,TILE_SIZE*3),TRUE)
			if(gib_icon_state)
				var/obj/effect/cleanable/blood/body_gib/BG = create_blood(/obj/effect/cleanable/blood/body_gib,T,R.color,rand(-TILE_SIZE*3,TILE_SIZE*3),rand(-TILE_SIZE*3,TILE_SIZE*3),TRUE)
				if(BG)
					BG.icon_state = gib_icon_state
					BG.flesh_color = color
					BG.update_sprite()

	unattach_from_parent(T,TRUE)

	return TRUE

/obj/item/organ/proc/on_life()

	if(reagents)
		reagents.metabolize(is_advanced(src.loc) ? src.loc : null)

	if(bleeding >= 0.25 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		if(A.blood_type && A.health && A.blood_volume && prob(80)) //Blood optimizations!
			var/bleed_amount = bleeding*TICKS_TO_SECONDS(LIFE_TICK_SLOW)
			var/reagent/R = REAGENT(A.blood_type)
			create_blood(/obj/effect/cleanable/blood/drip,get_turf(A),R.color,A.pixel_x + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1),A.pixel_y + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1))
			A.blood_volume = clamp(A.blood_volume - bleed_amount,0,A.blood_volume_max)
			bleeding = CEILING(max(0,bleeding - (0.02 + bleed_amount*0.075)),0.01)
			A.queue_health_update = TRUE

	return TRUE

obj/item/organ/proc/on_organ_remove(var/mob/living/advanced/old_owner)
	return TRUE

obj/item/organ/proc/on_organ_add(var/mob/living/advanced/new_owner)
	return TRUE

obj/item/organ/proc/get_damage_description(var/mob/examiner,var/verbose=FALSE)

	if(!health)
		return list()

	var/list/damage_desc = list()

	switch(health.damage[BRUTE])
		if(5 to 15)
			damage_desc += "<i>bruised<i/>"
		if(15 to 25)
			damage_desc += "battered"
		if(25 to 50)
			damage_desc += "<b>crushed</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>mangled</b></u>"

	switch(health.damage[BURN])
		if(5 to 15)
			damage_desc += "<i>blistered<i/>"
		if(15 to 25)
			damage_desc += "burned"
		if(25 to 50)
			damage_desc += "<b>scorched</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>charred</b></u>"

	switch(health.damage[PAIN])
		if(5 to 15)
			damage_desc += "<i>tender<i/>"
		if(15 to 25)
			damage_desc += "sore"
		if(25 to 50)
			damage_desc += "<b>stinging</b>"
		if(50 to 99)
			damage_desc += "<u><b>hurting</b></u>"
		if(100 to INFINITY)
			damage_desc += "<u><b>numb from the pain</b></u>"

	switch(health.damage[RAD])
		if(15 to 25)
			damage_desc += "glowing"
		if(25 to 50)
			damage_desc += "<b>pulsating</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>mutating</b></u>"


	switch(bleeding)
		if(0.5 to 2)
			damage_desc += "trickling blood"
		if(2 to 4)
			damage_desc += "<b>bleeding</b>"
		if(4 to INFINITY)
			damage_desc += "<u><b>gushing blood</b></u>"

	return damage_desc


/obj/item/organ/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)
	. = ..()
	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		I.act_emp(owner,source,epicenter,magnitude,desired_loyalty)