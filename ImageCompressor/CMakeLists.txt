cmake_minimum_required(VERSION 3.16)

project(ImageCompressor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

set(SCRIPTS
    scripts/image.ps1
    scripts/folder.ps1
    scripts/pngquant.exe
)

qt_add_executable(appImageCompressor
    main.cpp
    backend.h
    backend.cpp
    ${SCRIPTS}
)

file(COPY ${SCRIPTS} DESTINATION ${CMAKE_BINARY_DIR})

qt_add_qml_module(appImageCompressor
    URI ImageCompressor
    VERSION 1.0
    QML_FILES
        Main.qml
)

set_target_properties(appImageCompressor PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appImageCompressor
    PRIVATE Qt6::Quick
)

install(TARGETS appImageCompressor
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
