
function(make_target_info_header)
	include(CMakeParseArguments)

	set(one_value_required_arguments
		FILENAME
		OUTPUT_PATH
		NAMESPACE
	)

	set(one_value_arguments
		APP_NAME
		APP_VERSION
		APP_DESCRIPTION
		APP_AUTHOR
	)
	set(multi_value_arguments
		PARAMETERS
	)

	cmake_parse_arguments(MTIH "" "${one_value_required_arguments}" "${multi_value_arguments}" ${ARGN})

	foreach(required_argument IN LISTS one_value_required_arguments)
		if(NOT MTIH_${required_argument})
			message(FATAL_ERROR "make_target_info_header: Parameter ${required_argument} is required!")
		endif()
	endforeach()

	cmake_parse_arguments(MTIH "" "${one_value_arguments}" "" ${MTIH_PARAMETERS})

	foreach(argument IN LISTS one_value_arguments)
		if(NOT MTIH_${argument})
			if (GXZN_OS_FS_${argument})
				set(MTIH_${argument} ${GXZN_OS_FS_${argument}})
			else()
				message(WARNING "make_target_info_header: Parameter ${argument} is not defined!")
			endif()
		endif()
	endforeach()

	file(CONFIGURE OUTPUT ${MTIH_OUTPUT_PATH}/${MTIH_FILENAME}.hpp CONTENT [=[
/* THIS FILE WAS GENERATED BY CMAKE, DO NOT EDIT */
#pragma once

#include <string_view>

namespace @MTIH_NAMESPACE@ {

static constexpr std::string_view name       { "@MTIH_APP_NAME@" };
static constexpr std::string_view version    { "@MTIH_APP_VERSION@" };
static constexpr std::string_view description{ "@MTIH_APP_DESCRIPTION@" };
static constexpr std::string_view author     { "@MTIH_APP_AUTHOR@" };

} // namespace @MTIH_NAMESPACE@

]=]
		NEWLINE_STYLE LF
	)
	message(STATUS "> ${MTIH_OUTPUT_PATH}/${MTIH_FILENAME}.hpp generated")

endfunction()
