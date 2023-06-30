@interface izyMonitoring : NSObject
@property NSDictionary *verbose;
@property (nonatomic) id log;
- (void)printLog:(NSDictionary*) queryObject;
@end


#define stringConcat(...) [@[__VA_ARGS__] componentsJoinedByString:@""]
#define izyObjectiveCLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation izyMonitoring
@synthesize log = _log;
- (void) setLog:(NSDictionary *)queryObject {
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd HH:mm:ss";
    struct _timestampInfo {
      // ts: currentDate.getTime(),
        NSString *tzString;
    } timestampInfo;
    timestampInfo.tzString = [formatter stringFromDate:currentDate];
    
    NSDictionary* verbose = queryObject[@"verbose"];
    if (!verbose) verbose = self.verbose;
    if (!verbose) verbose = [NSMutableDictionary dictionary];
    int level = queryObject[@"level"] || 4;
    NSString* key = queryObject[@"key"];
    id msg = queryObject[@"msg"];
    BOOL shouldIgnore = false;
    if (!verbose[key]) {
      shouldIgnore = true;
      if (verbose[@"forceUpToLevel"]) {
        if (level <= verbose[@"forceUpToLevel"]) shouldIgnore = false;
      }
    }
    if (shouldIgnore) return;
    NSString* txt = @"";
    int msgType = -1;
    if ([msg isKindOfClass:[NSString class]])
        msgType = 0;
    else if ([msg isKindOfClass:[NSDictionary class]])
        msgType = 1;
    NSString* prefix = [NSString stringWithFormat:@"%@", key];
    //var fullcontext = ['', '', ''];
    //var extraInfoInLogs = null;
    switch(msgType) {
        case 1: // object
            for(id p in msg) {
                id value = [msg objectForKey:p];
              /*switch(p) {
                case 'errorObject':
                  if (msg[p] instanceof Error) {
                    txt += p + ': ' + msg[p].toString();
                    extraInfoInLogs = msg[p];
                  }
                  else {
                    if (verbose.extraInfoInLogs) extraInfoInLogs = new Error(JSON.stringify(msg[p]));
                    txt += p + ': ' + msg[p];
                  }
                  break;
                case 'connectionId':
                  fullcontext[1] = msg[p];
                  break;
                case 'name':
                  fullcontext[3] = msg[p];
                  break;
                case 'context':
                  fullcontext[0] = msg[p];
                  break;
                case 'action':
                  txt += '(' + modtask.fixLen(msg[p], 20) + ') ';
                  break;
                default:*/
                txt = stringConcat(txt, p, @": ");
                if ([value isKindOfClass:[NSDictionary class]]) {
                    NSError *error;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:value
                        options:kNilOptions //options:NSJSONWritingPrettyPrinted
                        error:&error];
                    NSString *jsonString;
                    if (!jsonData) {
                        jsonString = @"error";
                        // NSLog(@"error: %@", error);
                    } else {
                        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    }
                    [NSJSONSerialization dataWithJSONObject:value options:0 error:nil];
                    txt = stringConcat(txt, jsonString);
                } else {
                    txt = stringConcat(txt, value);
                }
                txt = stringConcat(txt, @", ");
            }
            break;
    }
    NSString* line = stringConcat(
                                  @"[",
        /*, modtask.fixLen(prefix + '@' + fullcontext.join('.'), 40)*/
        @"] ",
                                  txt);

/*    if (extraInfoInLogs) {
      console.log('_________________________ extraInfoInLogs __________________________');
      console.log(extraInfoInLogs);
      console.log('^^^^^^^^^^^^^^^^^^^^^^^^^ extraInfoInLogs ^^^^^^^^^^^^^^^^^^^^^^^^^');
    } else {
    }*/
    izyObjectiveCLog(@"%@ %@", timestampInfo.tzString, line);
}
@end
