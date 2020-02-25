SUBSYSTEM_DEF(combat)
	name = "Combat Subsystem"
	desc = "Controls combat related stuff."
	tick_rate = 1
	priority = 97

/subsystem/combat/on_life()
	return FALSE