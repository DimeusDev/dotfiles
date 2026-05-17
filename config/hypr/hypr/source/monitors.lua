hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

hl.config({
    misc = {
        -- vfr saves power when gpu is idle
        vrr = 1,
    },
})
