#import "PillowPlugin.h"
#if __has_include(<pillow/pillow-Swift.h>)
#import <pillow/pillow-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pillow-Swift.h"
#endif

@implementation PillowPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPillowPlugin registerWithRegistrar:registrar];
}
@end
