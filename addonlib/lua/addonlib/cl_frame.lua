-- Basic Frame Functions
--     SetTitle(text) - Sets the title of the frame
--     ShowCloseButton(show) - Should I show the close button?

surface.CreateFont("addonlib.fonts.frameTitle", {
    font = "Montserrat Medium",
    size = 30,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.title = "AddonLib Default Frame"

    self.header = self:Add("DPanel")
    self.header:Dock(TOP)
    self.header:SetTall(40)

    self.header.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, addonlib.theme.frame.header, true, true, false, false)
        draw.SimpleText(self.title, "addonlib.fonts.frameTitle", 5, h / 2, addonlib.bclr.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    self.header.cbtn = self.header:Add("DButton")
    self.header.cbtn:Dock(RIGHT)
    self.header.cbtn:SetWide(40)
    self.header.cbtn:SetText("")
    self.header.cbtn.margin = 10
    self.header.cbtn.marginH = 12
    self.header.cbtn.Paint = function(s, w, h)
        if (!s:IsHovered()) then
            surface.SetDrawColor(addonlib.theme.frame.close.r, addonlib.theme.frame.close.g, addonlib.theme.frame.close.b)
            draw.NoTexture()
            addonlib.circle(w / 2, h / 2, 15, 365)
        else
            surface.SetDrawColor(addonlib.theme.frame.close.r, addonlib.theme.frame.close.g, addonlib.theme.frame.close.b)
            draw.NoTexture()
            addonlib.circle(w / 2, h / 2, 13, 365)
        end
    end

    self.header.cbtn.DoClick = function()
        self:Remove()
    end
end

function PANEL:Paint(w, h)
    local aX, aY = self:LocalToScreen()
    BSHADOWS.BeginShadow()
    draw.RoundedBox(6, aX, aY, w, h, addonlib.theme.frame.background)
    BSHADOWS.EndShadow(3, 2, 2)
end

function PANEL:SetTitle(title)
    self.title = title
end

function PANEL:ShowCloseButton(show)
    self.header.cbtn:SetVisible(show)
end

vgui.Register("addonlib.frame", PANEL, "EditablePanel")

concommand.Add("addonlib_frame", function()
    local f = vgui.Create("addonlib.frame")
    f:SetSize(ScrW() * .75, ScrH() * .75)
    f:Center()
    f:MakePopup(true)
    f:SetTitle("AddonLib - Testing Frame (by lion)")

    local c = f:Add("addonlib.sidebar")
    c:Dock(LEFT)
    c:Center()
    c:SetBody(f)

    c:AddTab("Cool People", "DPanel")
    c:AddTab("Bad People", "DButton")
    c:AddTab("Ok People", "DHTML", function(s)
        s:OpenURL("https://www.google.com/")
    end)
end)