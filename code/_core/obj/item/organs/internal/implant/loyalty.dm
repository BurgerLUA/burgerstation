/obj/item/organ/internal/implant/head/loyalty
	var/registered_name = "none"
	var/registered_id = "none"
	var/registered_squad = "none"
	var/loyalty_tag = "none"

/obj/item/organ/internal/implant/head/loyalty/proc/update_implant(var/desired_name,var/desired_id,var/desired_squad)

	if(desired_name)
		registered_name = desired_name

	if(desired_id)
		registered_id = desired_id

	if(desired_squad)
		registered_squad = desired_squad

	if(is_living(loc))
		var/mob/living/L = loc
		L.to_chat("\The [src.name] in your [attached_organ.name] beeps.")

	return TRUE

/obj/item/organ/internal/implant/head/loyalty/on_organ_add(var/mob/living/advanced/new_owner)
	new_owner.set_loyalty_tag(loyalty_tag)
	return ..()

/obj/item/organ/internal/implant/head/loyalty/on_organ_remove(var/mob/living/advanced/old_owner)
	old_owner.set_loyalty_tag(null)
	return ..()

/obj/item/organ/internal/implant/head/loyalty/nanotrasen
	name = "loyalty implant"
	desc = "Do you swear loyalty? No? Well that doesn't matter."
	desc_extended = "A state of the art NanoTrasen Loyalty Implant Tracker, or NT-LIT, as the cool kids call it. This implant prevents the user from doing most forms of physical harm to those who also have the same loyalty implant model, and vice versa. Note that technology isn't advanced enough to stop other sources of harm, but NanoTrasen doesn't want you to know about that."
	loyalty_tag = "NanoTrasen"

/obj/item/organ/internal/implant/head/loyalty/syndicate
	name = "freedom implant"
	desc = "An implant that gives you FREEDOM."
	desc_extended = "A highly illegal Syndicate Freedom Implant specifically designed to override and replace any other Implants. This implant prevents the user from doing harm to those who also have the same freedom implant model, and vice versa."
	loyalty_tag = "Syndicate"

/obj/item/organ/internal/implant/head/loyalty/vladistov
	name = "revolutionary implant"
	desc = "An implant that gives you ENERGY."
	desc_extended = "A highly illegal Vladistov Implant specifically designed to override and replace any other Implants. This implant prevents the user from doing harm to those who also have the same freedom implant model, and vice versa."
	loyalty_tag = "Vladistov"