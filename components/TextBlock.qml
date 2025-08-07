import QtQuick 2.9

import "../components" as NoxcoinComponents

TextEdit {
    color: NoxcoinComponents.Style.defaultFontColor
    font.family: NoxcoinComponents.Style.fontRegular.name
    selectionColor: NoxcoinComponents.Style.textSelectionColor
    wrapMode: Text.Wrap
    readOnly: true
    selectByMouse: true
    // Workaround for https://bugreports.qt.io/browse/QTBUG-50587
    onFocusChanged: {
        if(focus === false)
            deselect()
    }
}
