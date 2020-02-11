//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<connectivity/FLTConnectivityPlugin.h>)
#import <connectivity/FLTConnectivityPlugin.h>
#else
@import connectivity;
#endif

#if __has_include(<prs_utility_plugin/PrsUtilityPlugin.h>)
#import <prs_utility_plugin/PrsUtilityPlugin.h>
#else
@import prs_utility_plugin;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTConnectivityPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTConnectivityPlugin"]];
  [PrsUtilityPlugin registerWithRegistrar:[registry registrarForPlugin:@"PrsUtilityPlugin"]];
}

@end
