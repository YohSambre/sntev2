SNTE_V2 = SNTE_V2 or {}

local function loadFolder(strPath)
    local files, folders = file.Find(strPath .. "*", "LUA")

    for _, filename in pairs(files) do
        if SERVER then
            if strPath:find("/client/") or filename:StartWith("sh_") then
                AddCSLuaFile(strPath .. filename)
            end

            if strPath:find("/server/") or filename:StartWith("sh_") then
                include(strPath .. filename)
            end
        else
            include(strPath .. filename)
        end
    end

    for _, folder in pairs(folders) do
        loadFolder(strPath .. folder .. "/")
    end
end

loadFolder("snte_v2/")
