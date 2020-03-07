#define NEW_SS_GLOBAL(varname) if(varname != src){if(istype(varname)){Recover();qdel(varname);}varname = src;}

#define SUBSYSTEM_DEF(X) var/global/subsystem/##X/SS##X;\
/subsystem/##X/New(){\
	NEW_SS_GLOBAL(SS##X);\
	PreInit();\
}\
/subsystem/##X


#define SS_ORDER_FIRST 1

#define SS_ORDER_PRELOAD 2
#define SS_ORDER_DMM 3

#define SS_ORDER_AREAS 4
#define SS_ORDER_TURFS 5
#define SS_ORDER_OBJS 6

#define SS_ORDER_LIGHTING 7
#define SS_ORDER_DELETE 8

#define SS_ORDER_SPAWNING 9

#define SS_ORDER_IMPORTANT 10
#define SS_ORDER_NORMAL 11
#define SS_ORDER_LIFE 12

#define SS_ORDER_LAST 13

#define SS_ORDER_REPORT 14
