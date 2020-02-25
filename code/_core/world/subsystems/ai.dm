var/global/list/ai/all_living_ai = list()

SUBSYSTEM_DEF(ai)
	name = "AI Subsystem"
	desc = "Controls the AI of mobs."
	tick_rate = DECISECONDS_TO_TICKS(AI_TICK)
	priority = SS_ORDER_IMPORTANT

/subsystem/ai/on_life()

	for(var/ai/AI in all_living_ai)
		AI.on_life()

	return TRUE