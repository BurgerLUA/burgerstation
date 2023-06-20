var/global/list/obj/item/organ/internal/implant/hand/left/iff/all_IFFs = list() //For future use in tracking.

/obj/item/organ/internal/implant/hand/left/iff
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to a database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	var/registered_name = "none"
	var/registered_id = "none"
	var/registered_squad = "none"
	var/iff_tag = "none"

/obj/item/organ/internal/implant/hand/left/iff/New(var/desired_loc)
	all_IFFs += src
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/PreDestroy()
	all_IFFs -= src
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/on_organ_add(var/mob/living/advanced/new_owner)
	new_owner.set_iff_tag(iff_tag)
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/on_organ_remove(var/mob/living/advanced/old_owner)
	old_owner.set_iff_tag(initial(old_owner.loyalty_tag))
	return ..()

/obj/item/organ/internal/implant/hand/left/iff/nanotrasen
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "NanoTrasen"

/obj/item/organ/internal/implant/hand/left/iff/syndicate
	name = "\improper NanoTrasen IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to Syndicate Operatives. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Syndicate"

/obj/item/organ/internal/implant/hand/left/iff/revolutionary
	name = "\improper Revolutionary IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to Revolutionaries. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Revolutionary"


/obj/item/organ/internal/implant/hand/left/iff/deathsquad
	name = "\improper Deathsquad IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to Deathsquad. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Deathsquad"

/obj/item/organ/internal/implant/hand/left/iff/space_cop
	name = "\improper Space Cop IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Space Cop"

/obj/item/organ/internal/implant/hand/left/iff/cult
	name = "\improper Cult IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Cult"

/obj/item/organ/internal/implant/hand/left/iff/clockwork_cult
	name = "\improper Clockwork Cult IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Clockwork"

/obj/item/organ/internal/implant/hand/left/iff/goblin
	name = "\improper Goblin IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Goblin"

/obj/item/organ/internal/implant/hand/left/iff/merc
	name = "\improper Mercenary IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "Mercenary"

/obj/item/organ/internal/implant/hand/left/iff/golem
	name = "\improper Golem IFF implant"
	desc = "Prevents friendly fire and collects your personal information."
	desc_extended = "A special integrated friend or foe implant based on the civilian model that prevents the user from being targeted with weapons registered to the NanoTrasen Firearms Database. Like the civilian counterpart, it also tracks movement and sents vitals data to nearby devices. Due to religious concenrs, it can only be implanted in the left hand."
	iff_tag = "golem"
