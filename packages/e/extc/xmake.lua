package("extc")
    set_description("The extc package")

    set_urls("https://github.com/Apsapeh/extc.git")
    add_versions("1.5", "7084070e2d4c47dfc49ae9260b1e462628ad913f")

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
