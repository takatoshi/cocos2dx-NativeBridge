#include "NativeBridge.h"

void NativeBridge::openUrl(const char* url) {
    NSURL* nsUrl = [NSURL URLWithString:[NSString stringWithUTF8String:url]];
    [[UIApplication sharedApplication] openURL:nsUrl];
}
