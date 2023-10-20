#define CLIENT(x) x && SSclient.all_clients[x] ? SSclient.all_clients[x] : null
#define MOBDATA(x) x && SSclient.ckey_to_mobdata[x] ? SSclient.ckey_to_mobdata[x] : null
#define GLOBALDATA(x) x && SSclient.ckey_to_globaldata[x] ? SSclient.ckey_to_globaldata[x] : null
#define AREA(x) x && SSarea.all_areas[x] ? SSarea.all_areas[x] : null
#define JOB(x) x && SSjob.all_jobs[x] ? SSjob.all_jobs[x] : null
#define ARMOR(x) x && SSarmor.all_armors[x] ? SSarmor.all_armors[x] : null