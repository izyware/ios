# Using the Objective-C SDK
use the izy-iOSHost project Xcode project.

## Phone Setup
Follow these steps:
* Enable developer mode
     While the device is attached to computer, go in Xcode > Products > ...
* "Untrusted Developer, Your device management settings does not allow using an app from (essentially myself)... on this iPad. You can allow using these apps in Settings."

    * Settings > General > Device Management > select the profile to trust


# Using izy-proxy macros and functions
The SDK has syntactical parity with izy-proxy. For more information refer to izy-proxy documentation. Some of the Objective-C and CLANG features have been utilitized to simplify the workflow in the environment and achieve closer parity with Javascript environment.

## CLANG Container/Collection Literals 
Use `NSDictionary *` for representing JSON objects in conjuction with boxed literals:

    monitoring.log = @{ @"key": @"service", @"msg": @{
        @"action": @"start",
        @"context": @{
            @"key": @"value"
        }
    }};

See [ObjectiveCLiterals reference]. 

## CLANG property setters
Use setters to achieve better parity with js syntax and simplify function calls with single input and no return values, for example the following:

    [monitoring log:@{}];
    
will become

    monitoring.log = @{};
    
## JS Equivalents
* split: componentsSeparatedByString
* join: componentsJoinedByString

# Links
* [github]
* location: `apps/ios`

# ChangeLog

## V6.9
* 6900008: string - stringConcat macro
* 6900007: asyncio - implement IZYrun macro to simplfy chain action process in ObjectiveC

        NSDictionary* outcome = IZYrun(@"//inline/json?loadById", @{ @"id": @"queryObject" });
        NSDictionary* queryObject = outcome[@"data"];


* 6900006: asyncio - port run and ldmod and //inline/ from izy-proxy
* 6900005: monitoring - implement log function as a property setter to simplify client code syntax
* 6900004: json/io use class method to implement the loadById functionality 
* 6900003: add monitoring.log interface
* 6900002: add json/loadById interface
* 6900001: add the Objective-C SDK 

[ObjectiveCLiterals reference]: https://clang.llvm.org/docs/ObjectiveCLiterals.html
[github]: https://github.com/izyware/ios