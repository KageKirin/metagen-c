-- package geniefile for argus

argus_script = path.getabsolute(path.getdirectory(_SCRIPT))
argus_root = path.join(argus_script, "argus")

argus_includedirs = {
	path.join(argus_root, "src"),
}

argus_libdirs = {}
argus_links = {}

argus_defines = {}

----

return {
	_load_package = function()
		if os.isdir(argus_root) then
			os.executef('git -C %s pull', argus_root)
		else
			os.executef('git clone https://github.com/KageKirin/argus.git %s', argus_root)
		end
	end,

	_add_includedirs = function()
		includedirs { argus_includedirs }
	end,

	_add_defines = function()
		defines { argus_defines }
	end,

	_add_libdirs = function()
		libdirs { argus_libdirs }
	end,

	_add_external_links = function()
		links { argus_links }
	end,

	_add_self_links = function()
		links { "argus" }
	end,

	_create_projects = function()

group "thirdparty"
project "argus"
	kind "StaticLib"
	language "C"
	flags {}

	defines {
		argus_defines,
	}

	includedirs {
		argus_includedirs,
	}

	files {
		path.join(argus_root, "src/*.h"),
		path.join(argus_root, "src/*.c"),
	}

	configuration {}

end, -- _create_projects()
}

---
