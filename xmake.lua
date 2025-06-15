-- 定义包信息
package("mylib")


    set_homepage("https://github.com/pengcheng888/hello_methods.git")
    set_description("A simple math library")
    set_license("MIT")
    
    -- 添加GitHub仓库作为源
    add_urls("https://github.com/pengcheng888/hello_methods.git")
    
    -- 添加版本 (使用Git标签)
    add_versions("v1.0.0", "161199a952f302353d676d7ff44f79df8f5ef9aa") -- 替换为实际的commit hash
    
    -- 添加配置选项
    add_configs("shared", {description = "Build shared library", default = false, type = "boolean"})
    
    -- 安装阶段
    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared"
        else
            configs.kind = "static"
        end
        
        -- 设置目标平台和架构
        configs.plat = package:plat()
        configs.arch = package:arch()
        
        -- 导入构建工具
        import("package.tools.xmake").install(package, configs)
    end)
    
    -- 测试包
    on_test(function (package)
        -- 检查头文件
        assert(package:has_cxxfuncs("add", {includes = "mylib.h"}))
        
        -- 实际测试代码
        assert(package:check_cxxsnippets({test = [[
            #include <mylib.h>
            void test() {
                int result = mylib::add(2, 3);
            }
        ]]}, {configs = {languages = "c++11"}}))
    end)

-- 库目标
target("mylib")
    set_kind("$(kind)")  -- 从外部传入的配置
    set_languages("c++11")
    
    -- 添加源文件
    add_files("src/**.cpp")
    
    -- 公开头文件
    add_includedirs("include", {public = true})
    add_headerfiles("include/(**.h)")

-- 测试目标
target("test_mylib")
    set_kind("binary")
    add_files("tests/*.cpp")
    add_deps("mylib")
    set_default(false)  -- 默认不构建测试