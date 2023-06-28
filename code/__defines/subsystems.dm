#define NEW_SS_GLOBAL(varname) if(varname != src){if(istype(varname)){Recover();qdel(varname);}varname = src;}

#define SUBSYSTEM_DEF(X) var/global/subsystem/##X/SS##X;\
/subsystem/##X/New(){\
	NEW_SS_GLOBAL(SS##X);\
	PreInitialize();\
}\
/subsystem/##X

#define SS_ORDER_BAN 1
#define SS_ORDER_CONFIG 2
#define SS_ORDER_LOGGING 3

#define SS_ORDER_FIRST 10
#define SS_ORDER_PRELOAD 11
#define SS_ORDER_POSTLOAD 12
#define SS_ORDER_LOOT 13

#define SS_ORDER_DMM 20
#define SS_ORDER_TURFS 21
#define SS_ORDER_CHUNK 22
#define SS_ORDER_AREAS 23
#define SS_ORDER_OBJS 24

#define SS_ORDER_SUNLIGHT 30
#define SS_ORDER_GENERATION 31
#define SS_ORDER_IMPORTANT 32
#define SS_ORDER_POWER 33

#define SS_ORDER_NORMAL 40
#define SS_ORDER_LIFE 41
#define SS_ORDER_LAST 42
#define SS_ORDER_AIR 43

#define SS_ORDER_SMOOTHING 50
#define SS_ORDER_LIGHTING 51
#define SS_ORDER_THINK 52
#define SS_ORDER_CALLBACK 53

#define SS_ORDER_DELETE 99
#define SS_ORDER_REPORT 100

#define queue_smoothing_obj(A) if(!A.queued_smoothing) {A.queued_smoothing = TRUE; SSsmoothing.queued_smoothing_objs += A}
#define queue_smoothing_turf(A) if(!A.queued_smoothing) {A.queued_smoothing = TRUE; SSsmoothing.queued_smoothing_turfs += A}