util.AddNetworkString("addonlib_notify")

addonlib.notifyPlayer = function(ply, type, titletext, desctext, time)
    net.Start("addonlib_notify")
    net.WriteString(type)
    net.WriteString(titletext)
    net.WriteString(desctext)
    net.WriteInt(time, 32)
    net.Send(ply)
end