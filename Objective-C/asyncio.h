#import "lib/json.h"
#import "lib/monitoring.h"

#define IZYrun(_action, _queryObject) [izyAsyncIO run:_action queryObject:_queryObject];

@interface izyAsyncIO : NSObject
// class method (not interface method)
+ (NSDictionary* )run:(NSString*) action queryObject:(id)queryObject;
@end
