local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
PaGlobal_WebControl = {
  web_control = nil,
  _ui = {
    _txt_Title = nil,
    _btn_Close = nil,
    _btn_Refresh = nil,
    _btn_CloseWin = nil,
    _btn_KeyHelp = nil,
    _btn_ProductNote = nil
  },
  _webSizeX = 960,
  _webSizeY = 600
}
local countryType = ""
local isIME = false
if isGameTypeTaiwan() then
  countryType = "_TW"
  isIME = true
elseif isGameTypeTR() then
  countryType = "_TR"
  isIME = true
elseif isGameTypeTH() then
  countryType = "_TH"
  isIME = true
elseif isGameTypeID() then
  countryType = "_ID"
  isIME = true
elseif isGameTypeSA() then
  if CppEnums.ServiceResourceType.eServiceResourceType_SA == getGameServiceResType() then
    countryType = "_SA"
  elseif CppEnums.ServiceResourceType.eServiceResourceType_PT == getGameServiceResType() then
    countryType = "_PT"
  end
elseif isGameTypeRussia() then
  countryType = "_RU"
elseif isGameTypeJapan() then
  countryType = "_JP"
elseif isGameTypeNA() then
  countryType = "_NA"
end
local isOpenFromGrowthPass = false
function Panel_WebHelper_ShowToggle(helpType)
  if true == isGameServiceTypeConsole() then
    return
  end
  if Panel_WatchingMode ~= nil and isDeadInWatchingMode() == true then
    return
  end
  if ToClient_IsConferenceMode() then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if Panel_WebControl:IsShow() then
    Panel_WebControl:SetShow(false, true)
    PaGlobal_WebControl.web_control:ResetUrl()
    if true == isOpenFromGrowthPass then
      PaGlobalFunc_GrowthPass_Open()
      isOpenFromGrowthPass = false
    end
    return false
  else
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return false
    end
    if isGameTypeGT() then
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_MSGBOX_COMMON_READY"),
        functionApply = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
      return false
    end
    if isGameTypeCH() == true then
      local url = ToClient_getIngameWikiURL() .. PaGlobal_WebControl:getWikiUrlForCH(helpType)
      if helpType == "KnownIssue" then
        url = PaGlobal_WebControl:getWikiUrlForCH(helpType)
      end
      ToClient_OpenRailBrowser(url, 4)
      return true
    end
    if true == _ContentsGroup_WikiNoToURL then
      local url = ToClient_getIngameBoardURL()
      local keyword = PaGlobal_WebControl:getWikiKeyword(helpType)
      url = url .. "/WikiSearch/" .. tostring(keyword)
      InputMLUp_ExpirienceWiki_All_Close()
      PaGlobal_ExpirienceWiki_All_SetIsWiki()
      PaGlobal_ExpirienceWiki_All_SetDirectLink(url)
      PaGlobal_ExpirienceWiki_All_Open()
      return
    end
    if nil == Panel_Login then
      if Panel_WorldMap:GetShow() then
        WorldMapPopupManager:push(Panel_WebControl, true)
      else
        Panel_WebControl:SetShow(true, true)
      end
    else
      Panel_WebControl:SetShow(true, true)
    end
    PaGlobal_WebControl:takeAndShow(helpType)
    return true
  end
end
function FGlobal_WebHelper_ForceClose()
  if Panel_WebControl:IsShow() then
    Panel_WebControl:SetShow(false, true)
    PaGlobal_WebControl.web_control:ResetUrl()
    if true == isOpenFromGrowthPass then
      PaGlobalFunc_GrowthPass_Open()
      isOpenFromGrowthPass = false
    end
    return
  end
end
function FGlobal_Panel_WebHelper_ShowToggle()
  if true == ToClient_SniperGame_IsPlaying() then
    return
  end
  Panel_WebHelper_ShowToggle("Main")
end
function Panel_WebHelper_ShowAni()
  UIAni.fadeInSCR_Down(Panel_WebControl)
  local aniInfo1 = Panel_WebControl:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_WebControl:GetSizeX() / 2
  aniInfo1.AxisY = Panel_WebControl:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_WebControl:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_WebControl:GetSizeX() / 2
  aniInfo2.AxisY = Panel_WebControl:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function Panel_WebHelper_HideAni()
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
  Panel_WebControl:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_WebControl, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobal_WebControl:initialize()
  if nil == Panel_WebControl then
    return
  end
  Panel_WebControl:SetShow(false, false)
  self._ui._txt_Title = UI.getChildControl(Panel_WebControl, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._txt_Title, "Button_Close")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._txt_Title, "Button_Refresh")
  self._ui._btn_CloseWin = UI.getChildControl(Panel_WebControl, "Button_CloseWindow")
  self._ui._btn_KeyHelp = UI.getChildControl(Panel_WebControl, "Button_KeyboardHelp")
  self._ui._btn_ProductNote = UI.getChildControl(Panel_WebControl, "Button_ProductNote")
  if true == PaGlobalFunc_Util_getIsSelfService() then
    local addSize = 100
    self._webSizeX = self._webSizeX + addSize
    self._webSizeY = self._webSizeY + addSize
    Panel_WebControl:SetSize(Panel_WebControl:GetSizeX() + addSize, Panel_WebControl:GetSizeY() + addSize)
    self._ui._txt_Title:SetSize(Panel_WebControl:GetSizeX(), self._ui._txt_Title:GetSizeY())
  end
  self.web_control = UI.createControl(__ePAUIControl_WebControl, Panel_WebControl, "WebControl_Help_CharInfo")
  self.web_control:SetSize(self._webSizeX, self._webSizeY)
  self.web_control:SetHorizonCenter()
  self.web_control:SetVerticalTop()
  self.web_control:ResetUrl()
  self.web_control:SetSpanSize(0, 60)
  self.web_control:ComputePos()
  self.web_control:SetShow(false)
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_Refresh)
  self._ui._btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  local btnHelpSizeX = self._ui._btn_KeyHelp:GetSizeX() + 23
  local btnHelpTextPosX = btnHelpSizeX - btnHelpSizeX / 2 - self._ui._btn_KeyHelp:GetTextSizeX() / 2
  self._ui._btn_KeyHelp:SetTextSpan(btnHelpTextPosX, 5)
  local btnProductSizeX = self._ui._btn_ProductNote:GetSizeX() + 23
  local btnProductTextPosX = btnProductSizeX - btnProductSizeX / 2 - self._ui._btn_ProductNote:GetTextSizeX() / 2
  self._ui._btn_ProductNote:SetTextSpan(btnProductTextPosX, 5)
  self._ui._btn_ProductNote:SetShow(true)
  self:registerEventHandler()
  self:validate()
end
function PaGlobal_WebControl:registerEventHandler()
  if nil == Panel_WebControl then
    return
  end
  Panel_WebControl:RegisterShowEventFunc(true, "Panel_WebHelper_ShowAni()")
  Panel_WebControl:RegisterShowEventFunc(false, "Panel_WebHelper_HideAni()")
  Panel_WebControl:setGlassBackground(true)
  Panel_WebControl:ActiveMouseEventEffect(true)
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle()")
  self._ui._btn_CloseWin:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle()")
  self._ui._btn_KeyHelp:addInputEvent("Mouse_LUp", "FGlobal_KeyboardHelpShow()")
  self._ui._btn_ProductNote:addInputEvent("Mouse_LUp", "Panel_ProductNote_ShowToggle()")
end
function PaGlobal_WebControl:validate()
  if nil == Panel_WebControl then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._btn_Refresh:isValidate()
  self._ui._btn_CloseWin:isValidate()
  self._ui._btn_KeyHelp:isValidate()
  self._ui._btn_ProductNote:isValidate()
end
function PaGlobal_WebControl:takeAndShow(helpType)
  if true == isGameServiceTypeConsole() then
    return
  end
  Panel_WebControl:SetShow(true, true)
  Panel_WebControl:ComputePos()
  PaGlobal_WebControl.web_control:SetHorizonCenter()
  PaGlobal_WebControl.web_control:SetVerticalTop()
  PaGlobal_WebControl.web_control:SetSpanSize(0, 60)
  PaGlobal_WebControl.web_control:ComputePos()
  local url = ToClient_getIngameWikiURL() .. "/Wiki/Search/" .. PaGlobal_WebControl:getWikiKeyword(helpType)
  PaGlobal_WebControl.web_control:SetUrl(self._webSizeX, self._webSizeY, url)
  if isGameTypeTaiwan() or isGameTypeNA() or isGameTypeKorea() or isGameTypeTR() or isGameTypeID() or isGameTypeTH() or isGameTypeRussia() or isGameTypeJapan() or isGameTypeASIA() then
    PaGlobal_WebControl.web_control:SetIME(true)
  end
  PaGlobal_WebControl.web_control:SetSize(self._webSizeX, self._webSizeY)
  PaGlobal_WebControl.web_control:SetHorizonCenter()
  PaGlobal_WebControl.web_control:SetVerticalTop()
  PaGlobal_WebControl.web_control:SetSpanSize(0, 60)
  PaGlobal_WebControl.web_control:ComputePos()
  PaGlobal_WebControl.web_control:SetShow(true)
  if nil ~= PaGlobalFunc_GrowthPass_IsShow and true == PaGlobalFunc_GrowthPass_IsShow() then
    isOpenFromGrowthPass = true
  end
end
function Panel_WebControl_LevelUpGuide(isString)
  if nil == isString then
    return
  end
  Panel_WebHelper_ShowToggle(isString)
end
function PaGlobal_WebControl:getWikiKeyword(helpType)
  local keyword = ""
  if helpType == "GUIDE" then
    keyword = "beginner"
  elseif helpType == "SelfCharacterInfo" then
    keyword = "generalinfo"
  elseif helpType == "PanelImportantKnowledge" then
    keyword = "knowledge"
  elseif helpType == "PanelWindowEquipment" then
    keyword = "equipment"
  elseif helpType == "PanelGameExit" then
    keyword = "exit"
  elseif helpType == "PanelWindowInventory" then
    keyword = "inventory"
  elseif helpType == "UIGameOption" then
    keyword = "option"
  elseif helpType == "PanelQuestHistory" then
    keyword = "quest"
  elseif helpType == "PanelQuestReward" then
    keyword = "quest"
  elseif helpType == "PanelFixEquip" then
    keyword = "repair"
  elseif helpType == "NodeMenu" then
    keyword = "node"
  elseif helpType == "NpcShop" then
    keyword = "npcshop"
  elseif helpType == "PanelBuyDrink" then
    keyword = "knowledge"
  elseif helpType == "Chatting" then
    keyword = "chat"
  elseif helpType == "KnownIssue" then
    keyword = "issue"
  elseif helpType == "PearlApp" then
    keyword = "app"
  elseif helpType == "GuildVehicle" then
    keyword = "guildmounts"
  elseif helpType == "PanelAlchemy" then
    keyword = "alchemy"
  elseif helpType == "PanelCook" then
    keyword = "cooking"
  elseif helpType == "PanelManufacture" then
    keyword = "processing"
  elseif helpType == "PanelHouseControl" then
    keyword = "house"
  elseif helpType == "PanelTradeMarketGraph" then
    keyword = "trade"
  elseif helpType == "TerritoryTrade" then
    keyword = "imperialdelivery"
  elseif helpType == "TerritorySupply" then
    keyword = "imperialdelivery"
  elseif helpType == "TerritoryAuth" then
    keyword = "imperialdelivery"
  elseif helpType == "HouseManageWork" then
    keyword = "work_mangement"
  elseif helpType == "PanelWorldMapTownWorkerManage" then
    keyword = "work_mangement"
  elseif helpType == "FarmManageWork" then
    keyword = "work_mangement"
  elseif helpType == "PanelWindowHouse" then
    keyword = "work_mangement"
  elseif helpType == "PanelWindowTent" then
    keyword = "garden"
  elseif helpType == "Gathering" then
    keyword = "gathering"
  elseif helpType == "Pet" then
    keyword = "pet"
  elseif helpType == "Maid" then
    keyword = "maid"
  elseif helpType == "Dye" then
    keyword = "dye"
  elseif helpType == "HouseRank" then
    keyword = "house"
  elseif helpType == "Worker" then
    keyword = "worker"
  elseif helpType == "AlchemyStone" then
    keyword = "alchemystone"
  elseif helpType == "LifeRanking" then
    keyword = "ranking"
  elseif helpType == "DeliveryPerson" then
    keyword = "reserve"
  elseif helpType == "PanelServantinfo" then
    keyword = "mount"
  elseif helpType == "PanelServantInventory" then
    keyword = "mount"
  elseif helpType == "PanelWindowStableShop" then
    keyword = "stable_wharf"
  elseif helpType == "PanelWindowWharfShop" then
    keyword = "stable_wharf"
  elseif helpType == "PanelWindowStableMarket" then
    keyword = "stable_wharf"
  elseif helpType == "PanelWindowStableMating" then
    keyword = "stable_wharf"
  elseif helpType == "PanelWindowStableRegister" then
    keyword = "stable_wharf"
  elseif helpType == "WareHouse" then
    keyword = "warehouse"
  elseif helpType == "DeliveryInformation" then
    keyword = "warehouse"
  elseif helpType == "DeliveryRequest" then
    keyword = "warehouse"
  elseif helpType == "ProductNote" then
    keyword = "craftingnote"
  elseif helpType == "ItemMarket" then
    keyword = "centralmarket"
  elseif helpType == "ClothExchange" then
    keyword = "exchange_outfit"
  elseif helpType == "SpiritEnchant" then
    keyword = "enhancement"
  elseif helpType == "PanelWindowExtractionCrystal" then
    keyword = "extraction"
  elseif helpType == "PanelWindowExtractionEnchantStone" then
    keyword = "extraction"
  elseif helpType == "PanelWindowSkill" then
    keyword = "skill"
  elseif helpType == "PanelEnableSkill" then
    keyword = "skill"
  elseif helpType == "Socket" then
    keyword = "transfusion"
  elseif helpType == "WarInfo" then
    keyword = "nodewar"
  elseif helpType == "BonusStat" then
    keyword = "apdp"
  elseif helpType == "PanelFriends" then
    keyword = "friend"
  elseif helpType == "PanelClan" then
    keyword = "clan"
  elseif helpType == "PanelGuild" then
    keyword = "guild"
  elseif helpType == "PanelLordMenu" then
    keyword = "warwinner"
  elseif helpType == "Panelmail" then
    keyword = "mail"
  elseif helpType == "PartyOption" then
    keyword = "party"
  elseif helpType == "PanelMailSend" then
    keyword = "mail"
  elseif helpType == "Update" then
    keyword = "thisweek"
  elseif helpType == "Fairy" then
    keyword = "fairy"
  elseif helpType == "WorldBoss" then
    keyword = "wboss"
  elseif helpType == "FamilyInventory" then
    keyword = "familyinventory"
  elseif helpType == "HorseRace" then
    keyword = "grandprix"
  elseif helpType == "SpecUpGuide" then
    keyword = "tip_combat"
  elseif helpType == "PanelWindowArtifact" then
    keyword = "lightstone"
  elseif helpType == "PanelWindowArtifactList" then
    keyword = "lightsotne_option"
  elseif helpType == "Solare" then
    keyword = "solare"
  elseif helpType == "PetLeader" then
    keyword = "petleader"
  elseif helpType == "Main" then
    keyword = "main"
  elseif helpType == "SeasonPassGuide" then
    keyword = "season_info"
  elseif helpType == "lv50above" then
    keyword = "lv50above"
  elseif helpType == "calpheon" then
    keyword = "calpheon"
  elseif helpType == "mediah" then
    keyword = "mediah"
  elseif helpType == "alchemy_adv" then
    keyword = "alchemy_adv"
  elseif helpType == "taming" then
    keyword = "taming"
  elseif helpType == "fishingadv" then
    keyword = "fishingadv"
  elseif helpType == "hunting" then
    keyword = "hunting"
  elseif helpType == "energy" then
    keyword = "energy"
  elseif helpType == "crystalPreset" then
    keyword = "crystal_preset"
  elseif helpType == "GuildPresent" then
    keyword = "great_ocean#hugeship"
  elseif helpType == "pve_info" then
    keyword = "pve_info"
  elseif helpType == "adventure_book" then
    keyword = "adventure_book"
  elseif helpType == "magnus" then
    keyword = "magnus"
  elseif helpType == "pearlitem_probability" then
    keyword = "pearlitem_probability"
  elseif helpType == "Guild_Vehicle" then
    keyword = "guildmounts"
  elseif helpType == "Carrack_Vehicle" then
    keyword = "Epheria_Carrack"
  elseif helpType == "WaroftheRoses" then
    keyword = "WaroftheRoses"
  elseif helpType == "HardCore" then
    keyword = "hardcore"
  elseif helpType == "MaidActor" then
    keyword = "maid_custom"
  else
    keyword = "main"
  end
  return keyword
end
function PaGlobal_WebControl:getWikiUrlForCH(helpType)
  local url = ""
  if helpType == "GUIDE" then
  elseif helpType == "SelfCharacterInfo" then
    url = "/adventureringame.html?newsid=18448981&newid=18490985"
  elseif helpType == "PanelImportantKnowledge" then
    url = "/adventureringame.html?newsid=18448981&newid=18490060"
  elseif helpType == "PanelWindowEquipment" then
    url = "/adventureringame.html?newsid=18448981&newid=18462662"
  elseif helpType == "PanelGameExit" then
    url = "/adventureringame.html?newsid=18448981&newid=18490030"
  elseif helpType == "PanelWindowInventory" then
    url = "/adventureringame.html?newsid=18448981&newid=18490068"
  elseif helpType == "UIGameOption" then
  elseif helpType == "PanelQuestHistory" then
    url = "/adventureringame.html?newsid=18448981&newid=18491209"
  elseif helpType == "PanelQuestReward" then
  elseif helpType == "PanelFixEquip" then
  elseif helpType == "NodeMenu" then
  elseif helpType == "NpcShop" then
    url = "/adventureringame.html?newsid=18448981&newid=18489948"
  elseif helpType == "PanelBuyDrink" then
  elseif helpType == "Chatting" then
    url = "/adventureringame.html?newsid=18448981&newid=18491093"
  elseif helpType == "KnownIssue" then
    url = "https://bd.qq.com/cp/a20240819/html/index.html#/article/XCMOBZIBzR3U20yG-fdQ"
  elseif helpType == "PearlApp" then
  elseif helpType == "GuildVehicle" then
    url = "/adventureringame.html?newsid=18448981&newid=18491045"
  elseif helpType == "PanelAlchemy" then
  elseif helpType == "PanelCook" then
    url = "/adventureringame.html?newsid=18448981&newid=18487574"
  elseif helpType == "PanelManufacture" then
    url = "/adventureringame.html?newsid=18448981&newid=18490605"
  elseif helpType == "PanelHouseControl" then
    url = "/adventureringame.html?newsid=18448981&newid=18490714"
  elseif helpType == "PanelTradeMarketGraph" then
    url = "/adventureringame.html"
  elseif helpType == "TerritoryTrade" then
  elseif helpType == "TerritorySupply" then
  elseif helpType == "TerritoryAuth" then
  elseif helpType == "HouseManageWork" then
    url = "/adventureringame.html?newsid=18448981&newid=18490469"
  elseif helpType == "PanelWorldMapTownWorkerManage" then
  elseif helpType == "FarmManageWork" then
  elseif helpType == "PanelWindowHouse" then
  elseif helpType == "PanelWindowTent" then
  elseif helpType == "Gathering" then
    url = "/adventureringame.html?newsid=18448981&newid=18488093"
  elseif helpType == "Pet" then
    url = "/adventureringame.html?newsid=18448981&newid=18490822"
  elseif helpType == "Maid" then
  elseif helpType == "Dye" then
  elseif helpType == "HouseRank" then
  elseif helpType == "Worker" then
  elseif helpType == "AlchemyStone" then
  elseif helpType == "LifeRanking" then
    url = "/adventureringame.html?newsid=18448981&newid=18483251"
  elseif helpType == "DeliveryPerson" then
  elseif helpType == "PanelServantinfo" then
    url = "/adventureringame.html?newsid=18448981&newid=18491039"
  elseif helpType == "PanelServantInventory" then
    url = "/adventureringame.html?newsid=18448981&newid=18491039"
  elseif helpType == "PanelWindowStableShop" then
    url = "/adventureringame.html?newsid=18448981&newid=18490646"
  elseif helpType == "PanelWindowWharfShop" then
    url = "/adventureringame.html?newsid=18448981&newid=18490646"
  elseif helpType == "PanelWindowStableMarket" then
  elseif helpType == "PanelWindowStableMating" then
    url = "/adventureringame.html?newsid=18448981&newid=18490646"
  elseif helpType == "PanelWindowStableRegister" then
  elseif helpType == "WareHouse" then
    url = "/adventureringame.html?newsid=18448981&newid=18490623"
  elseif helpType == "DeliveryInformation" then
    url = "/adventureringame.html?newsid=18448981&newid=18490623"
  elseif helpType == "DeliveryRequest" then
    url = "/adventureringame.html?newsid=18448981&newid=18490623"
  elseif helpType == "ProductNote" then
    url = "/adventureringame.html?newsid=18448981&newid=18490605"
  elseif helpType == "ItemMarket" then
    url = "/adventureringame.html?newsid=18448981&newid=18487388"
  elseif helpType == "ClothExchange" then
  elseif helpType == "SpiritEnchant" then
    url = "/adventureringame.html?newsid=18448981&newid=18490560"
  elseif helpType == "PanelWindowExtractionCrystal" then
  elseif helpType == "PanelWindowExtractionEnchantStone" then
  elseif helpType == "PanelWindowSkill" then
    url = "/adventurer.html?newsid=18448981&newid=18491191"
  elseif helpType == "PanelEnableSkill" then
  elseif helpType == "Socket" then
  elseif helpType == "WarInfo" then
  elseif helpType == "PanelFriends" then
    url = "/adventureringame.html?newsid=18448981&newid=18490079"
  elseif helpType == "PanelClan" then
  elseif helpType == "PanelGuild" then
    url = "/adventureringame.html?newsid=18448981&newid=18491361"
  elseif helpType == "PanelLordMenu" then
  elseif helpType == "Panelmail" then
    url = "/adventureringame.html?newsid=18448981&newid=18489953"
  elseif helpType == "PartyOption" then
  elseif helpType == "PanelMailSend" then
  elseif helpType == "Update" then
    url = "/latestcontent.html"
  elseif helpType == "Fairy" then
    url = "/adventureringame.html?newsid=18448981&newid=18491111"
  elseif helpType == "WorldBoss" then
    url = "/adventureringame.html?newsid=18448981&newid=18489994"
  elseif helpType == "FamilyInventory" then
  elseif helpType == "HorseRace" then
  elseif helpType == "SpecUpGuide" then
  elseif helpType == "PanelWindowArtifact" then
    url = "/adventureringame.html?newsid=18448981&newid=18449023"
  elseif helpType == "PanelWindowArtifactList" then
    url = "/adventureringame.html?newsid=18448981&newid=18577930"
  elseif helpType == "Solare" then
    url = "/adventureringame.html?newsid=18448981&newid=18551238"
  elseif helpType == "PetLeader" then
  elseif helpType == "Main" then
    url = "/adventureringame.html?newid=18462748"
  elseif helpType == "SeasonPassGuide" then
    url = "/adventureringame.html?newsid=18448981&newid=18464699"
  elseif helpType == "lv50above" then
  elseif helpType == "calpheon" then
  elseif helpType == "mediah" then
  elseif helpType == "alchemy_adv" then
    url = "/adventureringame.html?newsid=18448981&newid=18487570"
  elseif helpType == "taming" then
    url = "/adventureringame.html?newsid=18448981&newid=18487662"
  elseif helpType == "fishingadv" then
    url = "/adventureringame.html?newsid=18448981&newid=18487637"
  elseif helpType == "hunting" then
    url = "/adventureringame.html?newsid=18448981&newid=18487601"
  elseif helpType == "energy" then
  elseif helpType == "crystalPreset" then
    url = "/adventureringame.html?newsid=18448981&newid=18491332"
  elseif helpType == "GuildPresent" then
    url = "/adventurer.html?newsid=18623668&newid=18530083"
  elseif helpType == "pve_info" then
    url = "/adventureringame.html?newsid=18448981&newid=18487606"
  elseif helpType == "adventure_book" then
    url = "/adventureringame.html?newsid=18448981&newid=18487996"
  elseif helpType == "magnus" then
    url = "/adventureringame.html"
  elseif helpType == "pearlitem_probability" then
  elseif helpType == "Guild_Vehicle" then
  elseif helpType == "Carrack_Vehicle" then
    url = "/adventureringame.html?newsid=18448981&newid=18530069"
  elseif helpType == "WaroftheRoses" then
    url = "/adventurer.html?newsid=18448981&newid=18632893"
  elseif helpType == "MusicAlbum" then
    url = "/adventurer.html?newsid=18448981&newid=18537007"
  elseif helpType == "BonusStat" then
    url = "/adventurer.html?newsid=18448981&newid=18637854"
  elseif helpType == "MaidActor" then
    url = "/adventurer.html?newsid=18448981&newid=18663103"
  else
    url = "/adventureringame.html"
  end
  if url == "" then
    url = "/adventureringame.html"
  end
  return url
end
function FromClient_resetCoherentUIForWebHelper()
  if Panel_WebControl:GetShow() then
    TooltipSimple_Hide()
    FGlobal_WebHelper_ForceClose()
  end
end
function FromClient_WebContron_Initialize()
  PaGlobal_WebControl:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_WebContron_Initialize")
registerEvent("FromClient_resetCoherentUI", "FromClient_resetCoherentUIForWebHelper")
