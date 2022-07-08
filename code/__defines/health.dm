#define BLOOD_DEATH_PERCENT 0.4

#define QUEUE_HEALTH_UPDATE(mob) if(!mob.queue_health_update && mob.health) {SShealthupdate.queued_mobs += mob;mob.queue_health_update=TRUE}