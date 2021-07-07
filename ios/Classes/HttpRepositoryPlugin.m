#import "HttpRepositoryPlugin.h"
#if __has_include(<http_repository/http_repository-Swift.h>)
#import <http_repository/http_repository-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "http_repository-Swift.h"
#endif

@implementation HttpRepositoryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHttpRepositoryPlugin registerWithRegistrar:registrar];
}
@end
