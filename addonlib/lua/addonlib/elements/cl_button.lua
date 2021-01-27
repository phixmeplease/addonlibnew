surface.CreateFont("addonlib.fonts.buttonText", {
    font = "Montserrat Medium",
    size = 25,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.shadowLerp = 0
    self:SetFont("addonlib.fonts.buttonText")
    self:SetTextColor(addonlib.bclr.white)
end

function PANEL:Paint(w, h)
    BSHADOWS.BeginShadow()
    if (self:IsHovered()) then
        local aX, aY = self:LocalToScreen()
        self.shadowLerp = Lerp(5 * FrameTime(), self.shadowLerp, 3)
        draw.RoundedBox(h / 2, aX, aY, w, h, addonlib.theme.button.background)
    else
        local aX, aY = self:LocalToScreen()
        self.shadowLerp = Lerp(5 * FrameTime(), self.shadowLerp, 0)
        draw.RoundedBox(h / 2, aX, aY, w, h, addonlib.theme.button.background)
    end
    BSHADOWS.EndShadow(3, self.shadowLerp, 2)
end

vgui.Register("addonlib.button", PANEL, "DButton")