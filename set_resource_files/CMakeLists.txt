cmake_minimum_required(VERSION 3.16)

project(set_resource_files VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appset_resource_files
    qml.qrc
    main.cpp
)

set_source_files_properties(qml/Datapools/Settings.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

set(resource_files
    # Widgets
    qml/Widgets/Btn.qml

    # Datapools
    qml/Datapools/Settings.qml
)

qt_add_qml_module(appset_resource_files
    URI set_resource_files
    VERSION 1.0
    QML_FILES
        Main.qml
        ${resource_files}

)

set_target_properties(appset_resource_files PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appset_resource_files
    PRIVATE Qt6::Quick
)

install(TARGETS appset_resource_files
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
