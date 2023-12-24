package("extc")
    set_description("The extc package")

    set_urls("https://github.com/Apsapeh/extc.git")
    add_versions("last", "f9d16e95c3a1de53760c0dedae21221f67cf9bfd")
    --add_versions("1.5", "7084070e2d4c47dfc49ae9260b1e462628ad913f")

    on_load(function (package)
        package:add("includedirs", "include")
    end)

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        import("package.tools.xmake").install(package, config)
        os.cp("include/*", package:installdir("include"))
    end)

    on_test(function (package)
        -- TODO check includes and interfaces
        assert(package:has_cfuncs("vec_init", {includes = "extc_vec.h"}))
    end)
