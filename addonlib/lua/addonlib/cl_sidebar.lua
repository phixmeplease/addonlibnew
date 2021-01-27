surface.CreateFont("addonlib.fonts.buttonFont", {
    font = "Montserrat Medium",
    size = 30,
    weight = 500,
})

local PANEL = {}

AccessorFunc(PANEL, "body_element", "Body")

function PANEL:Init()

    self.buttons = {}
    self.pnls = {}

    self.active = 0

    self:SetTall(50)
end

function PANEL:AddTab(name, panel, panelFunc)
    local i = table.Count(self.buttons) + 1
    self.buttons[i] = self:Add("DButton")
    local btn = self.buttons[i]
    btn.id = i
    btn:Dock(TOP)
    btn:SetText(name)
    btn:SetFont("addonlib.fonts.buttonFont")
    btn:SetColor(addonlib.theme.navbar.text)
    btn:SizeToContentsY(10)
    btn:SizeToContentsX(32)
    btn:SetContentAlignment(4)
    btn:SetTextInset(5, 0)
    btn.Paint = function(s, w, h)
        if (self.active == btn.id) then
            --draw.RoundedBox(0, 0, h - 3, w, 3, addonlib.theme.navbar.acent)
            draw.RoundedBox(0, w - 3, 0, 3, h, addonlib.theme.navbar.acent)
        end
    end
    btn.DoClick = function(s)
        self:SetActive(s.id)
    end

    self.pnls[i] = self:GetBody():Add(panel)
    local pnl = self.pnls[i]
    pnl:Dock(FILL)
    pnl:SetVisible(false)

    if (panelFunc) then
        panelFunc(pnl)
    end

    return btn
end

function PANEL:SetActive(id)
    local activeBtn = self.buttons[self.active]
    if (activeBtn) then
        activeBtn:SetColor(addonlib.theme.navbar.text)
    end

    local activePnl = self.pnls[self.active]
    if (activePnl) then
        activePnl:SetVisible(false)
    end

    self.active = id

    local activeBtn = self.buttons[id]
    if (activeBtn) then
        activeBtn:SetColor(addonlib.theme.navbar.acent)
    end

    local activePnl = self.pnls[id]
    if (activePnl) then
        activePnl:SetVisible(true)
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, addonlib.theme.navbar.background)
end

function PANEL:Think()
    local w = self:GetWide()
    for k, v in pairs(self.buttons) do
        if (v:GetWide() > w) then
            w = v:GetWide()
        end
    end
    self:SetWide(w)
end

vgui.Register("addonlib.sidebar", PANEL, "EditablePanel")