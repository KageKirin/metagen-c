-- package geniefile for xxhash

xxhash_script = path.getabsolute(path.getdirectory(_SCRIPT))
xxhash_root = path.join(xxhash_script, "xxhash")


xxhash_includedirs = {
	path.join(xxhash_root),
}

xxhash_libdirs = {}
xxhash_links = {}

xxhash_defines = {}

----

return {
	_load_package = function()
		if os.isdir(xxhash_root) then
			os.executef('git -C %s pull', xxhash_root)
		else
			os.executef('git clone https://github.com/Cyan4973/xxHash.git %s', xxhash_root)
		end
	end,

	_add_includedirs = function()
		includedirs { xxhash_includedirs }
	end,

	_add_defines = function()
		defines { xxhash_defines }
	end,

	_add_libdirs = function()
		libdirs { xxhash_libdirs }
	end,

	_add_external_links = function()
		links { xxhash_links }
	end,

	_add_self_links = function()
		links { "xxhash" }
	end,

	_create_projects = function()

group "thirdparty"
project "xxhash"
	kind "StaticLib"
	language "C"
	flags {}

	defines {
		xxhash_defines,
	}

	includedirs {
		xxhash_includedirs,
	}

	files {
		path.join(xxhash_root, "*.h"),
		path.join(xxhash_root, "*.c"),
	}

	configuration {}

end, -- _create_projects()
}

---
