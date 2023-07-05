
@implementation izyJSON
// The return value is either NSArray * or NSDictionary *
+ (NSDictionary *)loadById:(NSDictionary*) queryObject {
    NSString *_id = queryObject[@"id"];
    if (!_id) @throw @{ @"reason": @"please specify either an object or a string to loadById" };
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:_id ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    return @{ @"success": @true, @"data": [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] };
}

// JSONInput could be a dictionary or array
+ (NSString *)serialize:(NSDictionary*) JSONInput {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JSONInput
        options: 0 // options:NSJSONWritingPrettyPrinted
        error:&error];
    if (!jsonData) {
        @throw @{ @"reason": @"cannot serialize" };
        // NSLog(@"%@", error);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
