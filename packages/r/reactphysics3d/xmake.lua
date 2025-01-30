package("reactphysics3d")
    set_description("The reactphysics3d package")

    add_urls("https://github.com/DanielChappuis/reactphysics3d.git")
    add_versions("0.9.0", "4bbbaa7c6e92942734eec696e23a2fad1f1cb8a1")
    add_patches("0.9.0", "patches/no_exceptions.patch", "80ada60e0c5c4fb61c15857055357f330790c9ad4c32edca8ef28d186c186048")
    add_patches("0.9.0", "patches/trigger_assert_fix.patch", "240c70e9bcbc064a40b50775cca25742272ad582b94285c49557568f229d898f")
    
    on_install(function (package)
    	--local data = io.readfile("include/reactphysics3d/configuration.h")
    	--io.writefile("include/reactphysics3d/configuration.h", "#include <cstdint>\n" .. data)
    	io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            target("reactphysics3d")
                set_kind("$(kind)")
                set_exceptions("no-cxx")
                add_files("src/**.cpp")
                add_includedirs("include")
                set_languages("cxx11")

                if is_mode("debug") then
                    set_symbols("debug")
                    set_optimize("none")
                elseif is_mode("release") then
                    set_strip("all")
                    set_fpmodels("fast")
                    set_optimize("aggressive")
                end
        ]])
        local configs = {kind="static"}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)
