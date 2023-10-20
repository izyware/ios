@implementation izyAsyncIO
+ (id)run:(NSString*) action queryObject:(id)queryObject
{
    if ([action isEqualToString:@"import.ldpath"]) {
        if (![queryObject isKindOfClass:[NSString class]]) @throw @{ @"reason": @"ldpath needs a string parameter"};
        return @{ @"success": @true, @"data": [[NSClassFromString(queryObject) alloc] init] };
    }

    if ([action isEqualToString:@"deviceextension.run"]) {
        NSArray* qs = queryObject[@"qs"];
        @throw @{ @"reason": @"stop here" };
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
+ (void)loadHTMLString:(id) container _id:(NSString*)_id {
    if (!_id) @throw @{ @"reason": @"please specify either an object or a string" };
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:_id ofType:@"html"];
    NSData *data = [NSData dataWithContentsOfFile:resourcePath];
    if (!data) @throw @{ @"reason": @"resource not found"};
    [container loadData:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding] MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
}
+ (void)loadURL:(id) container _id:(NSString*)_id {
    if (!_id) @throw @{ @"reason": @"please specify either an object or a string" };
    NSURL *URL = [NSURL URLWithString:_id];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:URL];
    [container loadRequest:requestURL];
}
@end
