/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."
	var/id = null

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null
	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage/organic.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	//health_max = 10
	var/break_threshold = 0 //0 Means it doesn't break. Other values means it breaks.

	var/attach_flag //The organ type that it wishes to attach to. Use FLAG_ORGAN_ flags.
	var/obj/item/organ/attached_organ //The organ that it is attached to.
	var/list/obj/item/organ/attached_organs //The organs that are attached to it.
	var/attach_method = 0 //0 Means it's attached to it. 1 means inside it. TODO: Flags.

	var/style

	color = "#FFFFFF"

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

/obj/item/organ/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(is_advanced(loc) && has_pain && atom_damaged == src && ((src.health && src.health.health_current <= 0) || critical_hit_multiplier > 1))
		var/mob/living/advanced/A = loc
		if(!A.dead)
			send_pain(damage_amount)

	return ..()

/obj/item/organ/proc/on_pain() //What happens if this organ is shot while broken. Other things can cause pain as well.
	return FALSE

/obj/item/organ/Destroy()
	attached_organ = null
	attached_organs.Cut()
	return ..()

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src
	return TRUE

/*
/obj/item/organ/get_miss_chance(var/atom/attacker,var/atom/weapon,var/atom/target)

	if(src.loc && !isturf(src.loc))
		return src.loc.get_miss_chance(attacker,weapon,target) + base_miss_chance

	return ..()
*/

/* HEALTH TODO: FIX THIS
/obj/item/organ/get_examine_text(var/mob/examiner)
	. = ..()
	for(var/k in wounds)
		var/wound/W = k
		W.update_name()
		. += span("notice",W.name)

	return .
*/

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

/obj/item/organ/New()
	. = ..()
	attached_organs = list()
	return .

/obj/item/organ/PostInitialize()
	. = ..()
	initialize_blends()
	return .

/obj/item/organ/proc/unattach_from_parent(var/turf/T)

	if(inventories)
		for(var/v in inventories)
			var/obj/hud/inventory/I = v
			I.drop_objects(T)

	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.unattach_from_parent(T)

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,FALSE)
		src.drop_item(T)

	update_sprite()

/obj/item/organ/proc/unattach_children(var/turf/T)
	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.unattach_from_parent(T)

/obj/item/organ/proc/gib()
	var/turf/T = get_turf(src.loc)
	var/mob/living/advanced/A

	if(is_advanced(src.loc))
		A = src.loc
		A.remove_organ(src,FALSE)

	unattach_from_parent(T)
	unattach_children(T)

	if(A) //A might've gotten removed here
		A.update_sprite()

	//new /obj/effect/gibs/random/(T,"#FF0000","secondary") TODO COLOR
	qdel(src)

/obj/item/organ/update_icon()

	/*
	icon = initial(icon)
	icon_state = initial(icon_state)

	var/is_attached_to = is_advanced(src.loc)
	if(!is_attached_to && has_dropped_icon)
		icon_state = "[icon_state]_inventory"
		if(has_dropped_icon_underlay)
			var/icon/I = new /icon(icon,icon_state)
			var/icon/U = new /icon(icon,"[icon_state]_underlay")
			I.Blend(U,ICON_UNDERLAY)
			icon = I
	*/

	return ..()

/obj/item/organ/proc/on_life()

	if(reagents)
		reagents.metabolize()

	if(bleeding >= 1 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		if(A.blood_type && A.health && A.blood_volume && A.should_bleed() && prob(80)) //Blood optimizations!
			var/bleed_amount = bleeding*DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)
			var/reagent/R = REAGENT(A.blood_type)
			create_blood(/obj/effect/cleanable/blood/drip,get_turf(A),R.color,rand(-TILE_SIZE*0.25,TILE_SIZE*0.25),rand(-TILE_SIZE*0.25,TILE_SIZE*0.25))
			A.blood_volume = clamp(A.blood_volume - bleed_amount,0,A.blood_volume_max)
			bleeding = CEILING(max(0,bleeding - (0.01 + bleed_amount*0.05)),0.01)
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
		if(50 to INFINITY)
			damage_desc += "<u><b>hurting</b></u>"

	switch(health.damage[RAD])
		if(15 to 25)
			damage_desc += "glowing"
		if(25 to 50)
			damage_desc += "<b>pulsating</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>mutating</b></u>"


	switch(bleeding)
		if(1 to 2)
			damage_desc += "trickling blood"
		if(2 to 4)
			damage_desc += "<b>bleeding</b>"
		if(4 to INFINITY)
			damage_desc += "<u><b>gushing blood</b></u>"

	return damage_desc

/*
/obj/item/organ/get_block_power(var/atom/victim,var/atom/attacker,var/atom/weapon,var/atom/object_to_damage,var/damagetype/DT)

	if(is_living(victim))
		var/mob/living/V = victim
		if(istype(DT,/damagetype/unarmed/))
			return V.get_skill_power(SKILL_UNARMED) * V.get_skill_power(SKILL_BLOCK)
		return V.get_skill_power(SKILL_UNARMED) * V.get_skill_power(SKILL_BLOCK) * 0.75

	return ..()

/obj/item/organ/can_block(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(is_living(victim))
		var/mob/living/V = victim
		return (V.get_skill_power(SKILL_UNARMED)*V.get_skill_power(SKILL_BLOCK)) >= block_difficulty[DT.get_attack_type()] ? src : null

	return null


/obj/item/organ/can_parry(var/atom/attacker,var/atom/attacking_weapon,var/atom/victim,var/damagetype/DT)

	if(istype(DT,/damagetype/unarmed/))
		return src

	if(is_living(victim))
		var/mob/living/V = victim
		return (V.get_skill_power(SKILL_UNARMED)*V.get_skill_power(SKILL_PARRY)) >= block_difficulty[DT.get_attack_type()] ? src : null

	return null
*/