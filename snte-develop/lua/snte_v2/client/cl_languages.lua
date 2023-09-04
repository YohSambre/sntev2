local dictionary = {}

function SNTE_V2.GetTranslation(str, ...)
    local lang = dictionary[SNTE_V2.GetConfig("lang")]

    if not lang then
        lang = "en" -- Fallback to english
    end

    if not lang[str] then
        return "Unknown translation, please report this"
    end

    return string.format(lang[str], unpack(... or {}))
end

function SNTE_V2.RegisterTranslation(id, tbl)
    if not dictionary[id] then
        dictionary[id] = tbl
    end
end
