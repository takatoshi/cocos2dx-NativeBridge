#include "NativeBridge.h"
#include "jni/NativeBridgeJNI.h"

void NativeBridge::openUrl(const char* url) {
    openUrlJNI(url);
}
