#import "lib/json.h"
#import "lib/monitoring.h"

#define IZYrun(_action, _queryObject) [izyAsyncIO run:_action queryObject:_queryObject];
#define IZYLoadHTMLById(_container, _str) [izyAsyncIO loadHTMLString:_container _id:_str]

@interface izyAsyncIO : NSObject
// class method (not interface method)
+ (NSDictionary* )run:(NSString*) action queryObject:(id)queryObject;
+ (void)loadHTMLString:(id) container _id:(NSString*)_id;
@end
