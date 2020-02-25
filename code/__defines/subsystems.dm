#define NEW_SS_GLOBAL(varname) if(varname != src){if(istype(varname)){Recover();qdel(varname);}varname = src;}

#define SUBSYSTEM_DEF(X) var/global/subsystem/##X/SS##X;\
/subsystem/##X/New(){\
	NEW_SS_GLOBAL(SS##X);\
	PreInit();\
}\
/subsystem/##X

#define SS_ORDER_PRELOAD 1
#define SS_ORDER_DMM 2
#define SS_ORDER_AREAS 3
#define SS_ORDER_TURFS 4
#define SS_ORDER_OBJS 5

#define SS_ORDER_LIGHTING 6
#define SS_ORDER_DELETE 7

#define SS_ORDER_SPAWNING 8

#define SS_ORDER_IMPORTANT 9
#define SS_ORDER_NORMAL 10
#define SS_ORDER_LIFE 11

#define SS_ORDER_LAST 12

#define SS_ORDER_REPORT 13
