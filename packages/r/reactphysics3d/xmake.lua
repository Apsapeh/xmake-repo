package("reactphysics3d")
    set_description("The reactphysics3d package")

    add_urls("https://github.com/DanielChappuis/reactphysics3d.git")
    add_versions("0.9.0", "2591dae5f2dadd42f32227bc805dabc0a6fc8642")

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
                set_optimize("aggressive")
        ]])
        local configs = {kind="static"}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)
