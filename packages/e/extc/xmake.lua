package("extc")
    set_description("The extc package")

    set_urls("https://github.com/Apsapeh/extc.git")
    add_version("last", "f9d16e95c3a1de53760c0dedae21221f67cf9bfd")
    --add_versions("1.5", "7084070e2d4c47dfc49ae9260b1e462628ad913f")

    on_install(function (package)
	package:add("includedirs", "include/")
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        -- TODO check includes and interfaces
        assert(package:has_cfuncs("init_vec", {includes = "extc_vec.h"})
    end)
