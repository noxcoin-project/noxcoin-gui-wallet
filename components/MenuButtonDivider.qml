import QtQuick 2.9

import "." as NoxcoinComponents
import "effects/" as NoxcoinEffects

Rectangle {
    color: NoxcoinComponents.Style.appWindowBorderColor
    height: 1

    NoxcoinEffects.ColorTransition {
        targetObj: parent
        blackColor: NoxcoinComponents.Style._b_appWindowBorderColor
        whiteColor: NoxcoinComponents.Style._w_appWindowBorderColor
    }
}
