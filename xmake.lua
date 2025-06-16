-- 库目标
target("mylib")
    set_kind("static")  -- 从外部传入的配置
    add_files("src/**.cpp")  -- 添加源文件
    add_includedirs("include")

-- 测试目标
target("test_mylib")
    set_kind("binary")
    add_includedirs("include")
    add_files("tests/*.cpp")
    add_deps("mylib")