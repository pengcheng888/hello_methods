target("mypkg")
    set_kind("$(kind)")  -- 从外部传入的配置（static/shared）
    add_files("src/mypkg.c")
    add_includedirs("include", {public = true})  -- 公开头文件

    -- 安装头文件
    add_headerfiles("include/(mypkg.h)")