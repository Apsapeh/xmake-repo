package("ode-test")

    set_homepage("http://ode.org/")
    set_description("ODE is an open source, high performance library for simulating rigid body dynamics.")
    set_license("BSD-3-Clause")

    add_urls("https://bitbucket.org/odedevs/ode/get/$(version).zip")
    add_versions("0.16.2", "000a5cdd0a81811cade2b0409ec06911a95e3c4c0d72a4cce3af6131115d0350")

    add_configs("libccd", {description = "Build with libccd.", default = false, type = "boolean"})
    apply_patch("patches/windows_header.patch", "a1c4b5ca279e113fc1d96f8361f600480662d6d2c61cc0badcc40b9c3a880bdb")

    add_deps("cmake")
    if is_plat("windows") then
        add_syslinks("user32")
    elseif is_plat("linux") then
        add_syslinks("pthread")
    end

    on_install(function (package)
        local configs = {"-DODE_WITH_DEMOS=OFF", "-DODE_WITH_TESTS=OFF"}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        if package:config("libccd") then
            table.insert(configs, "-DODE_WITH_LIBCCD=ON")
        end
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        assert(package:has_cfuncs("dInitODE", {includes = "ode/odeinit.h"}))
    end)