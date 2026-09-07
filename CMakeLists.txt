cmake_minimum_required(VERSION 3.21)

project(echomp
    VERSION 1.1
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(echomp
    main.cpp
)

qt_add_qml_module(echomp
    URI echomp
    VERSION 1.0

    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/qml/echomp"

    QML_FILES
        qml/Main.qml
)

# Hot reload
#target_compile_definitions(echomp PRIVATE QT_QML_DEBUG)

target_link_libraries(echomp
    PRIVATE Qt6::Quick
)