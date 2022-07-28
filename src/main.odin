package main

import "core:fmt"
import "core:os"
import "core:c/libc"
import "core:strings"
import "core:encoding/json"

Mode :: enum {
    Build,
    Help,
}

Optimization :: enum {
    Minimal,
    Size,
    Speed,
}

BuildSettings :: struct {
    name:               string,
    build_options:      [dynamic]string,
    src_dir:            string,
    lib:                bool,
    linker_arguments:   [dynamic]string,
    subsystem:          string,
    lld:                bool,
    assembler:          bool,
    obj:                bool,
    defines:            map[string]string,
    collection:         map[string]string,
    optimization:       Optimization,
}


main :: proc() {
    #no_bounds_check arg1 := os.args[1]

    mode : Mode

    if arg1 == "" {
        fmt.eprint("One Argument is required!")
        os.exit(1)
    }

    switch arg1 {
        case "build":
            mode = .Build
        case:
            mode = .Help
    }

    config_file := "odin-build.json"
    
    if !os.exists(config_file) {
        fmt.eprint("Require odin-build.json")
        os.exit(1)
    }



    switch mode {
        case .Build:
            build(config_file)
        case .Help:
            help()
    }

}

// When a Error, it returns false
build :: proc(config_file: string) -> (ok: bool) {
    data, success := os.read_entire_file(config_file)
    if !success do return false
    
    is_valid := json.is_valid(data)
    if !is_valid do return false

    read_config_file(config_file, data)

    return true
}

help :: proc() {

}

read_config_file :: proc (config_file: string, data: []u8) -> (ok: bool) {
    value, err := json.parse(data)
    

    
    return true
}


create_build_settings :: proc(value: json.Value) -> BuildSettings