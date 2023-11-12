qt_add_library(DatosLib STATIC)

set_target_properties(DatosLib PROPERTIES AUTOMOC ON)
target_link_libraries(DatosLib PRIVATE Qt6::Quick)

set_source_files_properties(Settings.qml PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
        )

qt_add_qml_module(DatosLib
        URI Datos
        VERSION 1.0
        RESOURCE_PREFIX /imports
        QML_FILES Settings.qml
        )

