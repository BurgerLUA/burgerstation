/addiction/
	var/name = "Addiction Name"
	var/list/addiction_reagents = list()

/addiction/proc/on_add(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withrawl_value=0)
	return TRUE

/addiction/proc/on_add_initial(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withrawl_value=0)
	return TRUE

/addiction/proc/on_life(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withrawl_value=0)
	return TRUE

/addiction/proc/on_remove(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B)
	return TRUE

/addiction/opium
	name = "Opium Addiction"