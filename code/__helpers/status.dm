#define STATUS_EFFECT_MAGNITUDE(living,status_type) (living.status_effects[status_type] ? living.status_effects[status_type]["magnitude"] : 0)
#define STATUS_EFFECT_DURATION(living,status_type) (living.status_effects[status_type] ? living.status_effects[status_type]["duration"] : 0)
