addonlib = {}
addonlib.baseprefix = "[Addon Library] "
addonlib.bclr = {} -- The base color list
addonlib.bclr.white = Color(255, 255, 255) -- white
addonlib.bclr.black = Color(0, 0, 0) -- black
addonlib.bclr.chat = Color(31, 202, 245) -- chat color
addonlib.bclr.green = Color(0, 255, 0)

-- this is the debug command
addonlib.debug = function(text)
    MsgC(addonlib.bclr.chat, addonlib.baseprefix, addonlib.bclr.white, text .. "\n")
end

-- addonlib lets you add a file directory to include
-- it uses 'cl_', 'sh_', and 'sv_' prefixes
addonlib.includeFiles = function(dir)
    local files, folders = file.Find(dir .. "*", LUA)

    for k, v in pairs(files) do
        if (string.StartWith(v, "sh_")) then
            if (SERVER) then
                AddCSLuaFile(dir .. v)
                include(dir .. v)
            end
            if (CLIENT) then
                include(dir .. v)
            end
            addonlib.debug("Added shared file " .. v)
        end
        if (string.StartWith(v, "sv_")) then
            if (SERVER) then
                include(dir .. v)
                addonlib.debug("Added server file " .. v)
            end
        end
        if (string.StartWith(v, "cl_")) then
            if (SERVER) then
                AddCSLuaFile(dir .. v)
            end
            if (CLIENT) then
                include(dir .. v)
                addonlib.debug("Added client file " .. v)
            end
        end
    end

    if (folders) then
        for k, v in pairs(folders) do
            addonlib.includeFiles(dir .. v .. "/")
        end
    end
end

addonlib.includeFiles("addonlib/")

-- This lets you load stuff in this hook
-- an example of adding your own addon is listed below:
-- if (addonlib) then
--     addonlib.includeFiles("youraddonfolder/")
-- else
--     hook.Add("addonlibPostLoad", "initalizeyouraddonname", function()
--         addonlib.includeFiles("youraddonfolder/")
--         hook.Remove("addonlibPostLoad", "initalizeyouraddonname")
--     end)
-- end
hook.Call("addonlibPostLoad")