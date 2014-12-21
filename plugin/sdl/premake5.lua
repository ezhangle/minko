newoption {
	trigger			= "rebuild-sdl",
	description		= "Rebuilds SDL for the specified platform."
}

if _OPTIONS["rebuild-sdl"] then
	include "lib/sdl"
end

PROJECT_NAME = path.getname(os.getcwd())

minko.project.library("minko-plugin-" .. PROJECT_NAME)

	files {
		"include/**.hpp",
		"src/**.cpp",
		"src/**.hpp"
	}

	includedirs {
		"include",
		"lib/sdl/include",
		"src"
	}

	configuration { "android" }
		minko.plugin.enable { "android" }

	configuration { "html5" }
		removeincludedirs { "lib/sdl/include" }
		includedirs { "SDL" }

	configuration { "ios" }
		buildoptions { "-x objective-c++" }

	configuration { "with-offscreen" }
		minko.plugin.enable { "offscreen" }

	-- Audio only works for HTML5, Windows and Android
	configuration { "linux32 or linux64 or osx64 or ios" }
		excludes {
			"include/SDLAudio.hpp",
			"include/audio/**.hpp",
			"src/SDLAudio.cpp",
			"src/audio/**.cpp",
		}
