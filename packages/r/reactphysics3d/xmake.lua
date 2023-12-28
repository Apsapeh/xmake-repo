package("reactphysics3d")
    set_description("The reactphysics3d package")

    add_urls("https://github.com/DanielChappuis/reactphysics3d.git")

    on_install(function (package)
    	local data = io.readfile("include/reactphysics3d/configuration.h")
    	io.writefile("include/reactphysics3d/configuration.h", "#include <cstdint>\n" .. data)
    	io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            target("reactphysics3d")
                set_kind("$(kind)")
                add_files("src/**.cpp")
                add_includedirs("include")
                set_languages("cxx11")
                set_symbols("hidden")
	        set_fpmodels("fast")
        	set_optimize("aggressive")
        ]])
        local configs = {kind="static"}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        -- TODO check includes and interfaces
        -- assert(package:has_cfuncs("foo", {includes = "foo.h"})
    end)
