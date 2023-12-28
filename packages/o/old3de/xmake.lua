package("old3de")
    set_description("The old3de package")
    add_deps("reactphysics3d")
    add_deps("glfw")

    add_urls("https://github.com/Apsapeh/Old3DEngine.git")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)