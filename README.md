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

## Using Blocks as class properties to emulate js callbacks
See [can-i-use-objective-c-blocks-as-properties]. Note that if your dont have ARC enabled, you will need to release the block if the property was declared copy. 

## Using XCode Design Environment
Follow these steps:
* Place the UI component on the canvas and add the constraints
* Right-Click on the item in scenes hierarchy and drag it to the .h file to add the property and link to an outlet in the xib XML
* Add the protocol to the controller .h file (i.e. UIWebViewDelegate)

## WKWebView vs. UIWebView
We recommend using WKWebView. It supports async evaluations for hybrid applications. 

# Links
* [github]
* location: `apps/ios`

# ChangeLog
## V7.0
* 7000003: monitoring - implement add coupling for WKWebView
    * Apple is phasing out UIWebView and is replacing UIWebView with WKWebView. 
* 7000002: monitoring - extract name and action key and improve ingestion technique
* 7000001: monitoring - extract context key

## V6.9
* 6900010: monitoring - fix logging filter bug 
* 6900009: refactor libraries 
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

[can-i-use-objective-c-blocks-as-properties]: https://stackoverflow.com/questions/3935574/can-i-use-objective-c-blocks-as-properties
[ObjectiveCLiterals reference]: https://clang.llvm.org/docs/ObjectiveCLiterals.html
[github]: https://github.com/izyware/ios