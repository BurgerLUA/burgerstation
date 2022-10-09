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
#define SS_ORDER_FIRST 4
#define SS_ORDER_PRELOAD 5
#define SS_ORDER_POSTLOAD 6
#define SS_ORDER_DMM 7
#define SS_ORDER_TURFS 8
#define SS_ORDER_AREAS 9
#define SS_ORDER_OBJS 10
#define SS_ORDER_POWER 11
#define SS_ORDER_SUNLIGHT 12
#define SS_ORDER_GENERATION 13
#define SS_ORDER_IMPORTANT 14
#define SS_ORDER_NORMAL 15
#define SS_ORDER_LIFE 16
#define SS_ORDER_LAST 17
#define SS_ORDER_AIR 18
#define SS_ORDER_SMOOTHING 19
#define SS_ORDER_LIGHTING 20
#define SS_ORDER_DELETE 21
#define SS_ORDER_REPORT 22

#define queue_smoothing_obj(A) if(!A.queued_smoothing) {A.queued_smoothing = TRUE; SSsmoothing.queued_smoothing_objs += A}
#define queue_smoothing_turf(A) if(!A.queued_smoothing) {A.queued_smoothing = TRUE; SSsmoothing.queued_smoothing_turfs += A}