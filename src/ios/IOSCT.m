#import "IOSCT.h"

#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import <Cordova/CDVAvailability.h>

@implementation IOSCT

- (void)CallStateDidChange:(NSNotification *)notification
{
    NSLog(@"Notification : %@", notification);
    NSString *callInfo = [[notification userInfo] objectForKey:@"callState"];

    if([callInfo isEqualToString: CTCallStateDialing])
    {
        //The call state, before connection is established, when the user initiates the call.
        NSLog(@"Call is dailing");
        NSString *func = [NSString stringWithFormat:@"window.dispatchEvent(new CustomEvent('%@'));", @"IOSCT.callStatusChanged.dialing"];
        [self.commandDelegate evalJs:func];
    }
    if([callInfo isEqualToString: CTCallStateIncoming])
    {
        //The call state, before connection is established, when a call is incoming but not yet answered by the user.
        NSLog(@"Call is Coming");
        NSString *func = [NSString stringWithFormat:@"window.dispatchEvent(new CustomEvent('%@'));", @"IOSCT.callStatusChanged.incoming"];
        [self.commandDelegate evalJs:func];
    }
    if([callInfo isEqualToString: CTCallStateConnected])
    {
        //The call state when the call is fully established for all parties involved.
        NSLog(@"Call Connected");
        NSString *func = [NSString stringWithFormat:@"window.dispatchEvent(new CustomEvent('%@'));", @"IOSCT.callStatusChanged.connected"];
        [self.commandDelegate evalJs:func];
    }
    if([callInfo isEqualToString: CTCallStateDisconnected])
    {
        //The call state Ended.
        NSLog(@"Call Ended");
        NSString *func = [NSString stringWithFormat:@"window.dispatchEvent(new CustomEvent('%@'));", @"IOSCT.callStatusChanged.ended"];
        [self.commandDelegate evalJs:func];
    }
}

- (void)registerListener:(CDVInvokedUrlCommand *)command {
    NSLog(@"PLUGIN IOSCT INITIALIZED");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CallStateDidChange:) name:@"IOSCTStatusChange" object:nil];

    self.objCallCenter = [[CTCallCenter alloc] init];
    self.objCallCenter.callEventHandler = ^(CTCall* call) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:call.callState forKey:@"callState"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IOSCTStatusChange" object:nil userInfo:dict];
    };

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK ];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)dealloc {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];

    [nc removeObserver:self name:@"IOSCTStatusChange" object:nil];
}

@end
