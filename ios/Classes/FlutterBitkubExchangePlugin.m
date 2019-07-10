#import "FlutterBitkubExchangePlugin.h"
#import <flutter_bitkub_exchange/flutter_bitkub_exchange-Swift.h>

@implementation FlutterBitkubExchangePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBitkubExchangePlugin registerWithRegistrar:registrar];
}
@end
