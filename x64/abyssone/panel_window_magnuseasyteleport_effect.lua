function FromClient_luaLoadComplete_MagnusEasyTeleport_Effect()
  Panel_Window_MagnusEasyTeleport_Effect:SetShow(true)
  Panel_Window_MagnusEasyTeleport_Effect:SetFadeOverRender(true)
end
function FromClient_EasyMagnusTeleportEndFadeEffect()
  Panel_Window_MagnusEasyTeleport_Effect:AddEffect("fUI_A1_FadeIn_01A", false, 0, 0)
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_MagnusEasyTeleport_Effect")
registerEvent("FromClient_EasyMagnusTeleportEndFadeEffect", "FromClient_EasyMagnusTeleportEndFadeEffect")
