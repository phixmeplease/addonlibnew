local PANEL = {}

function PANEL:Init()
    self:Setup()
end

function PANEL:Setup()
    self.VBar:SetWide(12)
    self.VBar:SetHideButtons(true)

    self.VBar.Paint = function(s, w, h)
        draw.RoundedBoxEx(6, 0, 0, w, h, addonlib.theme.scroll.background, false, true, false, true)
    end

    self.VBar.btnGrip.Paint = function(s, w, h)
        draw.RoundedBox(6, 0, 0, w, h, addonlib.theme.scroll.grip, false, true, false, true)
    end
end

vgui.Register("addonlib.scrollpanel", PANEL, "DScrollPanel")