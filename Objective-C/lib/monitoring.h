#import "string.h"
@interface izyMonitoring : NSObject
@property NSDictionary *verbose;
typedef void(^IngestionServiceBlock)(NSDictionary *queryObject);
@property (nonatomic) IngestionServiceBlock monitoringIngestionService;
@property (nonatomic) id log;
@property (nonatomic) id add;
- (void)printLog:(NSDictionary*) queryObject;
@end

#define izyObjectiveCLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
