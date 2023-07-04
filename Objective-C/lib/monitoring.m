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
    if ([verbose objectForKey:key] == nil || ([verbose[key] isKindOfClass:[NSNumber class]] && [verbose[key] isEqual:@0])) {
        shouldIgnore = true;
        /* if (verbose[@"forceUpToLevel"]) {
            if (level <= verbose[@"forceUpToLevel"]) shouldIgnore = false;
        }*/
    }

    if (shouldIgnore) return;
    NSString* txt = @"";
    int msgType = -1;
    if ([msg isKindOfClass:[NSString class]])
        msgType = 0;
    else if ([msg isKindOfClass:[NSDictionary class]])
        msgType = 1;
    NSString* prefix = [NSString stringWithFormat:@"%@", key];
    NSMutableArray  *fullcontext = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
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
                default:*/
                if ([p isEqual:@"context"]) {
                    [fullcontext replaceObjectAtIndex:0 withObject:msg[p]]; // fullcontext[0] = msg[p];
                } else if ([p isEqual:@"name"]) {
                    [fullcontext replaceObjectAtIndex:2 withObject:msg[p]]; // fullcontext[2] = msg[p];
                } else if ([p isEqual:@"action"]) {
                    txt = stringConcat(txt, @"(", [msg[p] stringByPaddingToLength: 20 withString: @" " startingAtIndex:0], @") "); // txt += '(' + modtask.fixLen(msg[p], 20) + ') ';
                } else {
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
            }
            break;
    }
    NSString* line = stringConcat(
     @"[",
     [stringConcat(prefix, @"@", [fullcontext componentsJoinedByString:@"."]) stringByPaddingToLength: 40 withString: @" " startingAtIndex:0], // modtask.fixLen(prefix + '@' + fullcontext.join('.'), 40)
      @"] ",
      txt
    );
/*    if (extraInfoInLogs) {
      console.log('_________________________ extraInfoInLogs __________________________');
      console.log(extraInfoInLogs);
      console.log('^^^^^^^^^^^^^^^^^^^^^^^^^ extraInfoInLogs ^^^^^^^^^^^^^^^^^^^^^^^^^');
    } else {
    }*/
    if (self.monitoringIngestionService) {
        self.monitoringIngestionService(@{
            @"line": line
        });
    }
    izyObjectiveCLog(@"%@ %@", timestampInfo.tzString, line);
}
@end
