add_rules("mode.debug", "mode.release")

target("hellomethods")
    set_kind("static")
    add_includedirs("include") -- 默认私有头文件目录不会被继承
    add_files("src/hello.cpp")


target("a.out")
    set_kind("binary")
    add_deps("hellomethods")  -- 添加依赖
    add_includedirs("include") -- 默认私有头文件目录不会被继承
    add_files("src/main.cpp")