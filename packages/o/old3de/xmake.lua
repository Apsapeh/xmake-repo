package("old3de")
    set_description("The old3de package")
    add_deps("reactphysics3d")

    add_urls("https://github.com/Apsapeh/Old3DEngine.git")
    --add_versions("1.0", "<shasum256 or gitcommit>")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        -- TODO check includes and interfaces
        -- assert(package:has_cfuncs("foo", {includes = "foo.h"})
    end)
