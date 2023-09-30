
if(NOT GRM_DEV_MODE)
	return()
endif()

if(GRM_BUILD_TEST)
	enable_testing()
	add_subdirectory(${GRM_TEST_DIR}) # filesystem tests (only if project is not included as subproject)
endif()

if(GRM_GENERATE_DOCS)
	include(${GRM_ROOT}/cmake/automatics/docs.cmake)
endif()
