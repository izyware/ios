@interface izyJSON : NSObject
- (id)loadById:(NSString*) path;
@end

@implementation izyJSON
// The return value is either NSArray * or NSDictionary *
- (id)loadById:(NSString*) path {
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end

