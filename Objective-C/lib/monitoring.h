#import "string.h"
@interface izyMonitoring : NSObject
@property NSDictionary *verbose;
@property (nonatomic) id log;
- (void)printLog:(NSDictionary*) queryObject;
@end

#define izyObjectiveCLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
