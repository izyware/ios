@interface izyJSON : NSObject
// class method (not interface method)
+ (NSDictionary *)loadById:(NSString*) path;
@end

@implementation izyJSON
// The return value is either NSArray * or NSDictionary *
+ (NSDictionary *)loadById:(NSDictionary*) queryObject {
    NSString *_id = queryObject[@"id"];
    if (!_id) @throw @{ @"reason": @"please specify either an object or a string to loadById" };
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:_id ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    return @{ @"success": @true, @"data": [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] };
}
@end
