#define SQUAD_PUBLIC "public"
#define SQUAD_FRIENDS_ONLY "friends"
#define SQUAD_INVITE_ONLY "invite"

/squad/
	name = "Squad Name"
	desc = "Squad description."
	desc_extended = "Squad long description."
	var/access = SQUAD_INVITE_ONLY

	var/mob/living/advanced/player/leader = null
	var/list/mob/living/advanced/player/members = list()

/squad/Destroy()

	for(var/mob/living/advanced/player/P in members)
		remove_member(P)

	remove_leader()

	return ..()

/squad/proc/add_member(var/mob/living/advanced/player/P)

	if(P in members)
		return FALSE

	members += P

	P.set_squad(src)

	return TRUE

/squad/proc/remove_member(var/mob/living/advanced/player/P)

	if(!(P in members))
		return FALSE

	P.unset_squad(src)

	members -= P

	return TRUE

/squad/proc/set_leader(var/mob/living/advanced/player/P)

	if(!(P in members))
		return FALSE

	if(leader)

		if(leader == P)
			return FALSE

		remove_leader()

	leader = P

	return TRUE

/squad/proc/remove_leader()

	if(!leader)
		return FALSE

	leader = null

	return TRUE