@interface izyJSON : NSObject
// class method (not interface method)
+ (NSDictionary *)loadById:(NSString*) path;
+ (NSString *)serialize:(NSDictionary*) JSONInput;
@end

