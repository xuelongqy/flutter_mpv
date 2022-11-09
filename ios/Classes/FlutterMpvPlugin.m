#import "FlutterMpvPlugin.h"
#if __has_include(<flutter_mpv/flutter_mpv-Swift.h>)
#import <flutter_mpv/flutter_mpv-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_mpv-Swift.h"
#endif

@implementation FlutterMpvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMpvPlugin registerWithRegistrar:registrar];
}
@end
