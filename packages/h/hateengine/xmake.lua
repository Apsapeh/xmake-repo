package("hateengine")
    set_description("The HateEngine package")
    add_deps("reactphysics3d 0.9.0")
    add_deps("glfw 3.4", {configs = {wayland = is_plat("linux")}})
    add_deps("glm 1.0.0")
    add_deps("tinygltf 2.8.13")
    add_deps("nuklear")
    add_deps("glu")
    add_defines("GLM_ENABLE_EXPERIMENTAL")

    set_urls("https://github.com/Apsapeh/HateEngine.git")
    add_versions("last", "73a7cfe3e02dc58cb386de2fef956a0b50c3b026")

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        end
        os.cp("include/*", package:installdir("include"))
        import("package.tools.xmake").install(package, configs)
    end)
