#define MECH_SLOT_NONE 0x0
#define MECH_SLOT_HAND 0x1
#define MECH_SLOT_SHOULDER 0x2
#define MECH_SLOT_BACK 0x4
#define MECH_SLOT_CHEST 0x8
#define MECH_SLOT_HEAD 0x10


/obj/item/mech_part/equipment
	name = "equipment"
	icon = 'icons/mob/living/advanced/mecha/equipment.dmi'
	var/slot = MECH_SLOT_NONE
	var/current_slot

	health = null


/obj/item/mech_part/equipment/weapon
	name = "mech weapon"
	var/obj/item/weapon/stored_weapon

	pixel_x = 0
	pixel_y = 0

/obj/item/mech_part/equipment/weapon/get_battery()
	if(stored_weapon)
		return stored_weapon.get_battery()
	return ..()

/obj/item/mech_part/equipment/weapon/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_weapon")
	return .

/obj/item/mech_part/equipment/weapon/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_weapon")
	if(stored_weapon) stored_weapon.update_sprite()
	update_sprite()
	return .

/obj/item/mech_part/equipment/weapon/Generate()
	stored_weapon = new stored_weapon(src)
	INITIALIZE(stored_weapon)
	GENERATE(stored_weapon)
	FINALIZE(stored_weapon)
	update_sprite()
	return ..()

/obj/item/mech_part/equipment/weapon/update_sprite()

	if(istype(stored_weapon))

		name = stored_weapon.name
		desc = stored_weapon.desc
		desc_extended = stored_weapon.desc_extended

		if(istype(src.loc,/mob/living/vehicle/mech/modular))
			icon = initial(icon)
			icon_state = "[stored_weapon.icon_state]_[current_slot]"
		else
			icon = stored_weapon.icon
			icon_state = stored_weapon.icon_state

	else
		name = "WEAPON ERROR."

	return ..()

/obj/item/mech_part/equipment/weapon/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if(stored_weapon && istype(src.loc,/mob/living/vehicle/mech/modular))
		return stored_weapon.click_on_object(caller,object,location,control,params)
	return ..()

/obj/item/mech_part/equipment/weapon/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	DEFER_OBJECT
	if(stored_weapon && !is_inventory(defer_object))
		return stored_weapon.clicked_on_by_object(caller,defer_object,location,control,params)
	return ..()

/obj/item/mech_part/equipment/weapon/smg/
	stored_weapon = /obj/item/weapon/ranged/energy/mech/smg
	slot = MECH_SLOT_HAND | MECH_SLOT_SHOULDER

/obj/item/mech_part/equipment/weapon/rifle
	stored_weapon = /obj/item/weapon/ranged/energy/mech/lmg
	slot = MECH_SLOT_HAND

/obj/item/mech_part/equipment/weapon/laser
	stored_weapon = /obj/item/weapon/ranged/energy/mech/laser
	slot = MECH_SLOT_HAND

/obj/item/mech_part/equipment/weapon/ion
	stored_weapon = /obj/item/weapon/ranged/energy/mech/ion
	slot = MECH_SLOT_HAND

/obj/item/mech_part/equipment/weapon/missile_pod
	stored_weapon = /obj/item/weapon/ranged/energy/mech/missile_pod
	slot = MECH_SLOT_SHOULDER
