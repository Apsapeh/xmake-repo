package("old3de")
    set_description("The old3de package")
    add_deps("reactphysics3d")
    add_deps("glfw")

    set_urls("https://github.com/Apsapeh/Old3DEngine.git")
    add_versions("last", "887f94a6db4741edf43010ea919d2da4cd72437a")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)
