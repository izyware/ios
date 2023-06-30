#import "lib/json.h"
#import "lib/monitoring.h"
@interface izyAsyncIO : NSObject
// class method (not interface method)
+ (NSDictionary* )run:(NSString*) action queryObject:(id)queryObject;
@end

@implementation izyAsyncIO
+ (id)run:(NSString*) action queryObject:(id)queryObject
{
    if ([action isEqualToString:@"import.ldpath"]) {
        if (![queryObject isKindOfClass:[NSString class]]) @throw @{ @"reason": @"ldpath needs a string parameter"};
        return @{ @"success": @true, @"data": [[NSClassFromString(queryObject) alloc] init] };
    }
    
    NSString *prefix = @"//inline/";
    if (![action hasPrefix:prefix]) {
        @throw @{ @"reason": @"action not supported"};
    }
    NSString *launchStr = [action substringFromIndex:[prefix length]];
    if ([launchStr isEqualToString:@"json?loadById"]) {
        return [izyJSON loadById:queryObject];
    }
    @throw @{ @"reason": @"action not supported"};
}
@end


