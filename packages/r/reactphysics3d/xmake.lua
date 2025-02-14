package("reactphysics3d")
    set_description("The reactphysics3d package")

    add_urls("https://github.com/Apsapeh/HateEngine-reactphysics3d.git")
    add_versions("0.9.0", "40ee80bc453421faad11be231edbbeb838f93ee2")
    
    on_install(function (package)
        local configs = {kind="static"}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)
