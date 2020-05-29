#define NEW_SS_GLOBAL(varname) if(varname != src){if(istype(varname)){Recover();qdel(varname);}varname = src;}

#define SUBSYSTEM_DEF(X) var/global/subsystem/##X/SS##X;\
/subsystem/##X/New(){\
	NEW_SS_GLOBAL(SS##X);\
	PreInitialize();\
}\
/subsystem/##X


#define SS_ORDER_LOGGING 1
#define SS_ORDER_FIRST 2
#define SS_ORDER_PRELOAD 3
#define SS_ORDER_DMM 4
#define SS_ORDER_AREAS 5
#define SS_ORDER_TURFS 6
#define SS_ORDER_OBJS 7
#define SS_ORDER_OBJS_POST 8
#define SS_ORDER_LIGHTING 9
#define SS_ORDER_DELETE 10
#define SS_ORDER_GENERATEING 11
#define SS_ORDER_IMPORTANT 12
#define SS_ORDER_NORMAL 13
#define SS_ORDER_LIFE 14
#define SS_ORDER_LAST 15
#define SS_ORDER_AIR 16
#define SS_ORDER_REPORT 17