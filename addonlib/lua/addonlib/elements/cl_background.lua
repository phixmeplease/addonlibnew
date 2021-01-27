addonlib.blur = Material("pp/blurscreen")

addonlib.drawPanelBackgroundBlur = function(pnl, amm)
    DisableClipping(true)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(addonlib.blur)

    for i = 1, 3 do
        addonlib.blur:SetFloat("$blur", (i / 3) * (amount or 8))
        addonlib.blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
    DisableClipping(false)
end