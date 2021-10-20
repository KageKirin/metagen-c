const bld = @import("std").build;

pub fn build(b: *bld.Builder) void {
    const dir = "src/";
    const sources = [_][]const u8 {
        "main.c"
    };
    const incl_dirs = [_][] const u8 {
        "xxHash"
    };
    const flags = [_][]const u8 {
    };

    const exe = b.addExecutable("metagen", null);
    exe.setTarget(b.standardTargetOptions(.{}));
    exe.setBuildMode(b.standardReleaseOptions());
    exe.linkSystemLibrary("c");
    //exe.linkSystemLibrary("c++");
    exe.linkLibrary(lib_xxhash(b));

    inline for (incl_dirs) |incl_dir| {
        exe.addIncludeDir(incl_dir);
    }

    inline for (sources) |src| {
        exe.addCSourceFile(dir ++ src, &flags);
    }

    exe.install();
}

// xxHash
fn lib_xxhash(b: *bld.Builder) *bld.LibExeObjStep {
    const lib = b.addStaticLibrary("xxHash", null);
    const dir = "xxHash/";
    const sources = [_][]const u8 {
        "xxhash.c"
    };
    const incl_dirs = [_][] const u8 {
        "xxHash"
    };
    const flags = [_][]const u8 {
    };

    lib.setBuildMode(b.standardReleaseOptions());
    lib.linkSystemLibrary("c");

    inline for (incl_dirs) |incl_dir| {
        lib.addIncludeDir(incl_dir);
    }

    inline for (sources) |src| {
        lib.addCSourceFile(dir ++ src, &flags);
    }

    return lib;
}
