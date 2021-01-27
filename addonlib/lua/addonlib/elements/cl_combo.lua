surface.CreateFont("addonlib.fonts.comboFont", {
    font = "Montserrat Medium",
    size = 30,
    weight = 500,
})

local PANEL = {}

function PANEL:Init()
    self.combo = self:Add("DComboBox")
    self.combo:Dock(FILL)
    self.combo.DropButton.Paint = nil
    
    self.combo.Think = function(s)
        s:CheckConVarChanges()
        s.DropButton:SetText("")
    end

    self.combo.Paint = function(s, w, h)
        draw.RoundedBox(8, 0, 0, w, h, addonlib.theme.combo.background)
        draw.SimpleText(s:GetValue(), "addonlib.fonts.comboFont", 5, h / 2, addonlib.bclr.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

function PANEL:AddChoice(text)
    self.combo:AddChoice(text)
end

vgui.Register("addonlib.combobox", PANEL, "DPanel")