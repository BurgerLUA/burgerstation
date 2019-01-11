#define RELATIONSHIP_ENEMY -1
#define RELATIONSHIP_NEUTRAL 0
#define RELATIONSHIP_FRIEND 1
#define RELATIONSHIP_ALLY 2

#define HOSTILE_ATTACK_ENEMIES -1
#define HOSTILE_ATTACK_NEUTRAL 0
#define HOSTILE_ATTACK_FRIEND 1
#define HOSTILE_ATTACK_ALLY 2

/faction/
	var/name = "Faction"
	var/desc = "The faction's description."
	var/id = "default"
	var/priority = 0 //A higher value = overrides lower values

	var/list/relationships = list()

	var/aggressiveness = HOSTILE_ATTACK_ENEMIES

/faction/proc/is_hostile_to_faction(var/faction/F)
	if(length(relationships) && relationships[F.id])
		return relationships[F.id] <= aggressiveness
	else
		return FALSE

/faction/proc/is_faction_hostile_to(var/faction/F)
	return F.is_hostile_to_faction(src)

/faction/proc/should_attack_faction(var/faction/F)
	return is_hostile_to_faction(F) || is_faction_hostile_to(F)
