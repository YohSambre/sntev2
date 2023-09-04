util.AddNetworkString("SNTEV2:OpenMenu")

concommand.Add("debugMenu", function(ply)
    local snteinfos = { -- "1st page (Stats) "
        [1] = 2000, -- "1st element in the Stats page Current exploits"
        [2] = 3000, -- "2nd element in the Stats page Total exploits"
        [3] = 0,    -- "3rd element in the Stats page Current backdoors"
        [4] = 2000, -- "3rd element in the Stats page Total backdoors"
    }

    net.Start("SNTEV2:OpenMenu")
    net.WriteTable(snteinfos)
    net.Send(ply)
end)
