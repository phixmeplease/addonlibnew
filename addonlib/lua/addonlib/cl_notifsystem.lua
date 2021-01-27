-- All Valid types of nofifications:
--     warn - yellow warning type
--     error - red error type
--     success - green success type
--     info - blue info type

surface.CreateFont("addonlib.notif.title", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})
surface.CreateFont("addonlib.notif.desc", {
    font = "Montserrat Medium",
    size = 20,
    weight = 500,
})

local function buildNotifPanel()
    if (IsValid(ADDONLIB_NOTIFPANEL)) then
        ADDONLIB_NOTIFPANEL:Remove()
    end

    ADDONLIB_NOTIFPANEL = vgui.Create("DPanel")
    ADDONLIB_NOTIFPANEL:ParentToHUD()
    ADDONLIB_NOTIFPANEL:SetWide(math.max(ScrW() * .1, 300))
    ADDONLIB_NOTIFPANEL:SetTall(ScrH())
    ADDONLIB_NOTIFPANEL:AlignRight(25)
    ADDONLIB_NOTIFPANEL:AlignTop(25)
    ADDONLIB_NOTIFPANEL.Paint = nil

    ADDONLIB_NOTIFPANEL.addNofiy = function(type, titletext, desctext, time)

    end
end

addonlib.notif = function(type, titletext, desctext, time)
    if (IsValid(ADDONLIB_NOTIFPANEL)) then
        local notifclr = addonlib.bclr.white

        if (type == "warn") then notifclr = addonlib.theme.notif.warn end
        if (type == "error") then notifclr = addonlib.theme.notif.error end
        if (type == "success") then notifclr = addonlib.theme.notif.success end
        if (type == "info") then notifclr = addonlib.theme.notif.info end


        local npnl = ADDONLIB_NOTIFPANEL:Add("DPanel")
        npnl:Dock(TOP)
        npnl:SetTall(0)
        npnl:SizeTo(ADDONLIB_NOTIFPANEL:GetWide(), ADDONLIB_NOTIFPANEL:GetTall() / 10, 0.2, 0, -1, function() end)
        npnl:DockMargin(0, 0, 0, 25)

        npnl.Paint = function(s, w, h)
            local aX, aY = s:LocalToScreen()
            BSHADOWS.BeginShadow()
            draw.RoundedBox(6, aX, aY, w, h, addonlib.theme.notif.background)
            draw.RoundedBoxEx(6, aX, aY, 10, h, notifclr, true, false, true, false)
            BSHADOWS.EndShadow(3, 2, 2)
        end

        local title = npnl:Add("DLabel")
        title:Dock(TOP)
        title:DockMargin(15, 0, 0, 0)
        title:SetColor(addonlib.bclr.white)
        title:SetText(titletext)
        title:SetFont("addonlib.notif.title")
        title:SizeToContentsY()

        local desc = npnl:Add("DLabel")
        desc:SetWrap(true)
        desc:Dock(FILL)
        desc:DockMargin(15, 0, 0, 0)
        desc:SetContentAlignment(7)
        desc:SetText(desctext)
        desc:SetColor(addonlib.bclr.white)
        desc:SetFont("addonlib.notif.desc")

        timer.Simple(time, function()
            if (IsValid(npnl)) then
                npnl:SizeTo(ADDONLIB_NOTIFPANEL:GetWide(), 0, 0.2, 0, -1, function()
                    npnl:Remove()
                end)
            end
        end)
    end
end

timer.Simple(3, function()
    buildNotifPanel()
end)

concommand.Add("addonlib_buildnotif", function()
    buildNotifPanel()
end)

concommand.Add("addonlib_testnotif", function()
    addonlib.notif("success", "Success!", "You have successfully done somthing wow.", 1)
    addonlib.notif("warn", "Warn!", "You about to mess up :(", 4)
    addonlib.notif("error", "Error!", "Get rekt kid", 7)
    addonlib.notif("info", "Here ya go!", "Here is some cool info or somthing! This is also super long just to prove it works lol.", 10)
end)

net.Receive("addonlib_notify", function()
    local type = net.ReadString()
    local titletext = net.ReadString()
    local desctext = net.ReadString()
    local time = net.ReadInt(32)
    addonlib.notif(type, titletext, desctext, time)
end)