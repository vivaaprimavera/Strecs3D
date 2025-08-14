project(project VERSION 0.1 LANGUAGES C CXX)

function(apply_other_settings TARGET_NAME)
  
  target_link_libraries(${TARGET_NAME} PRIVATE
    Qt6::Core
    Qt6::Widgets
    ${VTK_LIBRARIES}
    lib3mf::lib3mf
    libzip::zip
  )

  
  set_target_properties(${TARGET_NAME} PROPERTIES
    BUILD_WITH_INSTALL_RPATH TRUE
    INSTALL_RPATH_USE_LINK_PATH TRUE
  )
endfunction()

find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

if(Qt6_DIR)
  get_filename_component(QT_INSTALL_PREFIX "${Qt6_DIR}/../../../" ABSOLUTE)
  set(QT_PLUGIN_PATH "${QT_INSTALL_PREFIX}/plugins")
  if(EXISTS "${QT_PLUGIN_PATH}")
    message(STATUS "Found Qt plugins at: ${QT_PLUGIN_PATH}")
  else()
    message(WARNING "Qt plugins not found at ${QT_PLUGIN_PATH}")
  endif()
endif()

find_package(PkgConfig)
pkg_check_modules(LIB3MF IMPORTED_TARGET lib3mf)
if(LIB3MF_FOUND)
    message(STATUS "lib3MF found: ${LIB3MF_VERSION}")
else()
    message(FATAL_ERROR "lib3mf not found ${PKG_CONFIG_FOUND}. Please install via vcpkg: vcpkg install lib3mf")
endif()

