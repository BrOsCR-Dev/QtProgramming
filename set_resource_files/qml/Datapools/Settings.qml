pragma Singleton
import QtQuick 2.15

QtObject {
    property int window_width: 42
    property int window_height: 42

    function myFunction() {
        console.log("Hello from MySingleton!");
    }
}
