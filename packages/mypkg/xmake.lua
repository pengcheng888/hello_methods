package("mypkg")
    set_description("My Custom Package")
    set_license("MIT")

    -- 添加配置选项（可选）
    add_configs("shared", {description = "Build shared library", default = false, type = "boolean"})

    -- 安装阶段：编译并安装库
    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        else
            configs.kind = "static"
        end

        -- 导入构建工具
        import("package.tools.xmake").install(package, configs)
    end)

    -- 测试包（可选）
    on_test(function (package)
        assert(package:has_cfuncs("mypkg_func", {includes = "mypkg.h"}))
    end)