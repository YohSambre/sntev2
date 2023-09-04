local config = {
    ["theme"] = "light",
    ["lang"] = "fr",
}

function SNTE_V2.GetConfig(conf)
    return config[conf] or nil
end
