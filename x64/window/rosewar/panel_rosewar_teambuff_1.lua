function PaGlobal_RoseWarTeamBuff:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_RoseWar_TeamBuff, "Static_BuffList_BG")
  self._ui._stc_buffTemplate = UI.getChildControl(Panel_RoseWar_TeamBuff, "Static_BuffIcon_Template")
  self:makeBuffIconList()
  self._initialize = true
end
function PaGlobal_RoseWarTeamBuff:prepareOpen()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  self:open()
end
function PaGlobal_RoseWarTeamBuff:open()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  Panel_RoseWar_TeamBuff:SetShow(true)
  self:makeBuffDataList()
  self:updateBuffIcon()
end
function PaGlobal_RoseWarTeamBuff:prepareClose()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarTeamBuff:close()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  Panel_RoseWar_TeamBuff:SetShow(false)
end
