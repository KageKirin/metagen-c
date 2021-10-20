const bld = @import("std").build;

pub fn build(b: *bld.Builder) void {
    const dir = "src/";
    const sources = [_][]const u8 {
        "main.c"
    };
    const incl_dirs = [_][] const u8 {
    };
    const flags = [_][]const u8 {
    };

    const exe = b.addExecutable("metagen", null);
    exe.setTarget(b.standardTargetOptions(.{}));
    exe.setBuildMode(b.standardReleaseOptions());
    exe.linkSystemLibrary("c");
    //exe.linkSystemLibrary("c++");

    inline for (incl_dirs) |incl_dir| {
        exe.addIncludeDir(incl_dir);
    }

    inline for (sources) |src| {
        exe.addCSourceFile(dir ++ src, &flags);
    }

    exe.install();
}
