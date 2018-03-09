#import <Cordova/CDVPlugin.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface IOSCT : CDVPlugin

@property (nonatomic, strong) CTCallCenter *objCallCenter;

- (void)registerListener:(CDVInvokedUrlCommand *)command;

@end

