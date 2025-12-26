local isLargePartyOpen = ToClient_IsContentsGroupOpen("286")
local PP = CppEnums.PAUIMB_PRIORITY
local PLT = CppEnums.PartyLootType
local PLT2S = CppEnums.PartyLootType2String
local Panel_Window_PartySetting_info = {
  _ui = {
    static_Bg = nil,
    static_Content = nil,
    txt_Title = nil,
    static_BottomBg = nil,
    staticText_Close_ConsoleUI = nil,
    static_DropOption = nil,
    radioButton = {},
    radioButtonText = nil,
    static_LT_ConsoleUI = nil,
    static_RT_ConsoleUI = nil,
    static_CharacterSlot_Template = nil,
    static_ClassImage = nil,
    static_Info = nil,
    static_ClassIcon = nil,
    staticText_Level = nil,
    staticText_Name = nil,
    staticText_Authorize_ConsoleUI = nil,
    staticText_KickOut_ConsoleUI = nil,
    staticText_Recruite = nil,
    staticText_Invite_ConsoleUI = nil,
    static_LeaderIcon = nil,
    static_FocusSlot = nil,
    static_NoExpAlertBg = nil,
    stc_RaidSlot_Template = nil,
    stc_Raid_ClassImage = nil,
    stc_Raid_LeaderIcon = nil,
    stc_Raid_ClassIcon = nil,
    txt_Raid_level = nil,
    txt_Raid_Name = nil,
    stc_Raid_KeyGuide_A = nil,
    stc_Raid_KeyGuide_X = nil,
    stc_Raid_KeyGuide_Y = nil,
    stc_selfBorder = nil,
    stc_OverBG = nil
  },
  _value = {
    isMaster = false,
    partyMemberCount = 0,
    currentIndex = nil,
    currentLootType = nil,
    isOnPanel = true
  },
  _config = {
    maxBigSlot = 5,
    slotBigRow = 5,
    slotBigCol = 1,
    maxSmallSlot = 20,
    slotSmallRow = 4,
    slotSmallCol = 5,
    lootingOptionCount = 4
  },
  _pos = {
    partyStartY = 130,
    partySizeY = 0,
    partySpaceY = 4,
    largePartyStartX = 35,
    largePartyStartY = 140,
    largePartySizeX = 130,
    largePartySizeY = 130,
    largePartySpace = 4,
    aniInfoBasePosX = 0,
    aniInfoEndPosX = 300,
    aniImageBasePosX = 0,
    aniImageEndPosX = 0
  },
  _color = {
    unSelected = Defines.Color.C_FF525B6D,
    selected = Defines.Color.C_FFEEEEEE
  },
  _enum = {
    eTAB_LOOTING_FREE = CppEnums.PartyLootType.LootType_Free,
    eTAB_LOOTING_ORDERED = CppEnums.PartyLootType.LootType_Shuffle,
    eTAB_LOOTING_RANDOM = CppEnums.PartyLootType.LootType_Random
  },
  _enum = {eSLOT_TYPE_MEMBER = 0, eSLOT_TYPE_INVITE = 1},
  _stringLooting = {
    [CppEnums.PartyLootType.LootType_Free] = nil,
    [CppEnums.PartyLootType.LootType_Shuffle] = nil,
    [CppEnums.PartyLootType.LootType_Random] = nil
  },
  _enumMachingIndex = {
    [0] = CppEnums.PartyLootType.LootType_Free,
    [1] = CppEnums.PartyLootType.LootType_Shuffle,
    [2] = CppEnums.PartyLootType.LootType_Random
  },
  _partyMemberData = {},
  _partyMemberUIBig = {},
  _partyMemberUISmall = {},
  _tabList = {},
  _changedPartyMode = nil,
  _renewchattingUISize = 832,
  _DROPOPTION_MAXSIZE = 1000
}
function Panel_Window_PartySetting_info:registEventHandler()
  Panel_Window_PartySetting:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobalFunc_PartySetting_SelectLoot(-1)")
  Panel_Window_PartySetting:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobalFunc_PartySetting_SelectLoot(1)")
end
function Panel_Window_PartySetting_info:registerMessageHandler()
  registerEvent("onScreenResize", "FromClient_PartySetting_Resize")
  registerEvent("ResponseParty_updatePartyList", "FromClient_ResponseParty_updatePartySettingList")
  registerEvent("ResponseParty_invite", "FromClient_ResponseParty_updatePartySettingList")
  registerEvent("ResponseParty_refuse", "FromClient_ResponseParty_updatePartySettingList")
  registerEvent("ResponseParty_changeLeader", "FromClient_ResponseParty_updatePartySettingList")
  registerEvent("ResponseParty_withdraw", "FromClient_ResponseParty_updatePartySettingList")
  registerEvent("FromClient_PadSnapChangePanel", "FromClient_PartySetting_PadSnapChangePanel")
  registerEvent("FromClient_UpdatePartyExperiencePenalty", "FromClient_PartySetting_UpdatePartyExperiencePenalty")
  registerEvent("FromClient_updatePartyLootType", "FromClient_PartySetting_updatePartyLootType")
end
function Panel_Window_PartySetting_info:initialize()
  self:childControl()
  self:createTemplate()
  self:createTemplateSmall()
  self:initValue()
  self:resize()
  self:registerMessageHandler()
  self:registEventHandler()
end
function Panel_Window_PartySetting_info:initValue()
  self._value.currentIndex = nil
  self._value.partyMemberCount = 0
  self._value.isMaster = false
  self._value.partyType = CppEnums.PartyType.ePartyType_Normal
  self._stringLooting[CppEnums.PartyLootType.LootType_Free] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_FREE")
  self._stringLooting[CppEnums.PartyLootType.LootType_Shuffle] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TURN")
  self._stringLooting[CppEnums.PartyLootType.LootType_Random] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_RANDOM")
end
function Panel_Window_PartySetting_info:resize()
  self:setBgSize()
end
function Panel_Window_PartySetting_info:childControl()
  self._ui.static_Bg = UI.getChildControl(Panel_Window_PartySetting, "Static_Bg")
  self._ui.static_Content = UI.getChildControl(Panel_Window_PartySetting, "Static_Content")
  self._ui.txt_Title = UI.getChildControl(self._ui.static_Content, "StaticText_Title")
  self._ui.static_BottomBg = UI.getChildControl(self._ui.static_Content, "Static_BottomBg")
  self._ui.staticText_Close_ConsoleUI = UI.getChildControl(self._ui.static_BottomBg, "StaticText_Close_ConsoleUI")
  self._ui.static_DropOption = UI.getChildControl(self._ui.static_Content, "Static_DropOption")
  for index = 0, self._config.lootingOptionCount - 1 do
    self._ui.radioButton[index] = UI.getChildControl(self._ui.static_DropOption, "RadioButton_" .. index + 1)
  end
  self._ui.radioButtonText = UI.getChildControl(self._ui.static_DropOption, "StaticText_SelectedLootOption")
  self._ui.static_LT_ConsoleUI = UI.getChildControl(self._ui.static_DropOption, "Static_LT_ConsoleUI")
  self._ui.static_RT_ConsoleUI = UI.getChildControl(self._ui.static_DropOption, "Static_RT_ConsoleUI")
  self._ui.static_CharacterSlot_Template = UI.getChildControl(self._ui.static_Content, "Static_CharacterSlot_Template")
  self._ui.static_ClassImage = UI.getChildControl(self._ui.static_CharacterSlot_Template, "Static_ClassImage")
  self._ui.static_Info = UI.getChildControl(self._ui.static_CharacterSlot_Template, "Static_Info")
  self._ui.static_ClassIcon = UI.getChildControl(self._ui.static_Info, "Static_ClassIcon")
  self._ui.staticText_Level = UI.getChildControl(self._ui.static_Info, "StaticText_Level")
  self._ui.staticText_Name = UI.getChildControl(self._ui.static_Info, "StaticText_Name")
  self._ui.static_PlatformIcon = UI.getChildControl(self._ui.static_Info, "Static_PlatFormIcon")
  self._ui.staticText_Authorize_ConsoleUI = UI.getChildControl(self._ui.static_CharacterSlot_Template, "StaticText_Authorize_ConsoleUI")
  self._ui.staticText_KickOut_ConsoleUI = UI.getChildControl(self._ui.static_CharacterSlot_Template, "StaticText_KickOut_ConsoleUI")
  self._ui.staticText_ShowProfile_ConsoleUI = UI.getChildControl(self._ui.static_CharacterSlot_Template, "StaticText_ShowProfile_ConsoleUI")
  self._ui.staticText_Recruite = UI.getChildControl(self._ui.static_CharacterSlot_Template, "StaticText_Recruite")
  self._ui.staticText_Invite_ConsoleUI = UI.getChildControl(self._ui.static_CharacterSlot_Template, "StaticText_Invite_ConsoleUI")
  self._ui.static_LeaderIcon = UI.getChildControl(self._ui.static_CharacterSlot_Template, "Static_LeaderIcon")
  self._pos.partyStartY = self._ui.static_CharacterSlot_Template:GetPosY()
  self._pos.partySizeY = self._ui.static_CharacterSlot_Template:GetSizeY()
  self._pos.aniInfoBasePosX = self._ui.static_Info:GetPosX()
  self._pos.aniImageBasePosX = self._ui.static_ClassImage:GetPosX()
  self._ui.static_CharacterSlot_Template:SetShow(false)
  self._ui.static_FocusSlot = UI.getChildControl(self._ui.static_Content, "Static_FocusSlot")
  self._ui.static_FocusSlot:SetShow(true)
  self._ui.static_NoExpAlertBg = UI.getChildControl(self._ui.static_Content, "Static_NoExpAlertBg")
  self._ui.static_ExpBonusIcon = UI.getChildControl(self._ui.static_Content, "Static_ExpBonusIcon")
  self._ui.stc_RaidSlot_Template = UI.getChildControl(self._ui.static_Content, "Static_RaidSlot_Template")
  self._ui.stc_Raid_ClassImage = UI.getChildControl(self._ui.stc_RaidSlot_Template, "Static_ClassImage")
  self._ui.stc_Raid_LeaderIcon = UI.getChildControl(self._ui.stc_RaidSlot_Template, "Static_LeaderIcon")
  self._ui.stc_Raid_ClassIcon = UI.getChildControl(self._ui.stc_RaidSlot_Template, "Static_ClassIcon")
  self._ui.txt_Raid_level = UI.getChildControl(self._ui.stc_RaidSlot_Template, "StaticText_Level")
  self._ui.txt_Raid_Name = UI.getChildControl(self._ui.stc_RaidSlot_Template, "StaticText_Name")
  self._ui.stc_Raid_PlatformIcon = UI.getChildControl(self._ui.static_Info, "Static_PlatFormIcon")
  self._ui.stc_Raid_KeyGuide_A = UI.getChildControl(self._ui.stc_RaidSlot_Template, "StaticText_A_ConsoleUI")
  self._ui.stc_Raid_KeyGuide_X = UI.getChildControl(self._ui.stc_RaidSlot_Template, "StaticText_X_ConsoleUI")
  self._ui.stc_Raid_KeyGuide_Y = UI.getChildControl(self._ui.stc_RaidSlot_Template, "StaticText_Y_ConsoleUI")
  self._ui.stc_selfBorder = UI.getChildControl(self._ui.stc_RaidSlot_Template, "Static_SelfBorder")
  self._ui.stc_OverBG = UI.getChildControl(self._ui.stc_Raid_ClassImage, "Static_OverBG")
  self._ui.stc_TitleBG = UI.getChildControl(self._ui.stc_Raid_ClassImage, "Static_TitleBG")
  self:initKeyGuide()
  self._pos.largePartySizeX = self._ui.stc_RaidSlot_Template:GetSizeX()
  self._pos.largePartySizeY = self._ui.stc_RaidSlot_Template:GetSizeY()
end
function Panel_Window_PartySetting_info:initKeyGuide()
  local maxSizeX = math.max(self._ui.staticText_Authorize_ConsoleUI:GetTextSizeX(), self._ui.staticText_KickOut_ConsoleUI:GetTextSizeX())
  if true == _ContentsGroup_isPS4UI then
    self._ui.staticText_ShowProfile_ConsoleUI:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
    maxSizeX = math.max(maxSizeX, self._ui.staticText_ShowProfile_ConsoleUI:GetTextSizeX())
  else
    self._ui.staticText_Authorize_ConsoleUI:SetPosY(30)
    self._ui.staticText_KickOut_ConsoleUI:SetPosY(65)
  end
  maxSizeX = maxSizeX + self._ui.staticText_ShowProfile_ConsoleUI:GetSizeX() + 30
  local posX = self._ui.static_CharacterSlot_Template:GetSizeX() - maxSizeX
  self._ui.staticText_ShowProfile_ConsoleUI:SetPosX(posX)
end
function Panel_Window_PartySetting_info:createTemplate()
  for index = 0, self._config.maxBigSlot - 1 do
    local slot = {
      slotNo = 0,
      static_CharacterSlot_Template = nil,
      static_ClassImage = nil,
      static_Info = nil,
      static_ClassIcon = nil,
      staticText_Level = nil,
      staticText_Name = nil,
      static_PlatformIcon = nil,
      staticText_Authorize_ConsoleUI = nil,
      staticText_KickOut_ConsoleUI = nil,
      staticText_ShowProfile_ConsoleUI = nil,
      staticText_Recruite = nil,
      staticText_Invite_ConsoleUI = nil,
      static_LeaderIcon = nil
    }
    slot.static_CharacterSlot_Template = UI.createAndCopyBasePropertyControl(self._ui.static_Content, "Static_CharacterSlot_Template", self._ui.static_Content, "Static_CharacterSlot_Template_" .. index)
    slot.static_ClassImage = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "Static_ClassImage", slot.static_CharacterSlot_Template, "Static_ClassImage_" .. index)
    slot.static_Info = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "Static_Info", slot.static_CharacterSlot_Template, "Static_Info" .. index)
    slot.static_ClassIcon = UI.createAndCopyBasePropertyControl(self._ui.static_Info, "Static_ClassIcon", slot.static_Info, "Static_ClassIcon_" .. index)
    slot.staticText_Level = UI.createAndCopyBasePropertyControl(self._ui.static_Info, "StaticText_Level", slot.static_Info, "StaticText_Level_" .. index)
    slot.staticText_Name = UI.createAndCopyBasePropertyControl(self._ui.static_Info, "StaticText_Name", slot.static_Info, "StaticText_Name_" .. index)
    slot.static_PlatformIcon = UI.createAndCopyBasePropertyControl(self._ui.static_Info, "Static_PlatFormIcon", slot.static_Info, "Static_PlatFormIcon_" .. index)
    slot.staticText_Authorize_ConsoleUI = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "StaticText_Authorize_ConsoleUI", slot.static_CharacterSlot_Template, "StaticText_Authorize_ConsoleUI_" .. index)
    slot.staticText_KickOut_ConsoleUI = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "StaticText_KickOut_ConsoleUI", slot.static_CharacterSlot_Template, "StaticText_KickOut_ConsoleUI_" .. index)
    slot.staticText_ShowProfile_ConsoleUI = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "StaticText_ShowProfile_ConsoleUI", slot.static_CharacterSlot_Template, "StaticText_ShowProfile_ConsoleUI" .. index)
    slot.staticText_Recruite = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "StaticText_Recruite", slot.static_CharacterSlot_Template, "StaticText_Recruite_" .. index)
    slot.staticText_Invite_ConsoleUI = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "StaticText_Invite_ConsoleUI", slot.static_CharacterSlot_Template, "StaticText_Invite_ConsoleUI_" .. index)
    slot.static_LeaderIcon = UI.createAndCopyBasePropertyControl(self._ui.static_CharacterSlot_Template, "Static_LeaderIcon", slot.static_CharacterSlot_Template, "Static_LeaderIcon_" .. index)
    function slot:setPos(index)
      local partyInfo = Panel_Window_PartySetting_info
      local row = index % partyInfo._config.slotBigRow
      local newPosY = partyInfo._pos.partyStartY + row * (partyInfo._pos.partySizeY + partyInfo._pos.partySpaceY)
      self.static_CharacterSlot_Template:SetPosY(newPosY)
    end
    function slot:setShow(bShow)
      self.static_CharacterSlot_Template:SetShow(bShow)
    end
    function slot:SetIgnore(bIgnore)
      self.static_CharacterSlot_Template:SetIgnore(bIgnore)
    end
    slot.slotNo = index
    slot:setPos(index)
    slot.static_CharacterSlot_Template:addInputEvent("Mouse_On", "PaGlobalFunc_PartySetting_OnSelectParty(" .. index .. ")")
    slot.static_CharacterSlot_Template:addInputEvent("Mouse_Out", "PaGlobalFunc_PartySetting_OutSelectParty(" .. index .. ")")
    slot.static_PlatformIcon:SetShow(false)
    self._ui.static_Content:SetChildOrder(slot.static_CharacterSlot_Template:GetKey(), self._ui.static_FocusSlot:GetKey())
    self._partyMemberUIBig[index] = slot
  end
end
function Panel_Window_PartySetting_info:createTemplateSmall()
  local row = 0
  for index = 0, self._config.maxSmallSlot - 1 do
    local slot = {
      slotNo = 0,
      stc_RaidSlot = nil,
      stc_ClassImage = nil,
      stc_LeaderIcon = nil,
      stc_ClassIcon = nil,
      stc_PlatformIcon = nil,
      txt_Level = nil,
      txt_Name = nil,
      stc_KeyGuide_A = nil,
      stc_KeyGuide_X = nil,
      stc_KeyGuide_Y = nil,
      stc_SelfBorder = nil,
      stc_OverBG = nil,
      stc_TotleBG = nil,
      classType = nil
    }
    slot.stc_RaidSlot = UI.createAndCopyBasePropertyControl(self._ui.static_Content, "Static_RaidSlot_Template", self._ui.static_Content, "Static_RaidSlot_Template_" .. index)
    slot.stc_ClassImage = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "Static_ClassImage", slot.stc_RaidSlot, "Static_ClassImage_" .. index)
    slot.stc_LeaderIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "Static_LeaderIcon", slot.stc_RaidSlot, "Static_LeaderIcon_" .. index)
    slot.stc_OverBG = UI.createAndCopyBasePropertyControl(self._ui.stc_Raid_ClassImage, "Static_OverBG", slot.stc_RaidSlot, "Static_OverBG" .. index)
    slot.stc_TitleBG = UI.createAndCopyBasePropertyControl(self._ui.stc_Raid_ClassImage, "Static_TitleBG", slot.stc_RaidSlot, "Static_TitleBG" .. index)
    slot.stc_ClassIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "Static_ClassIcon", slot.stc_RaidSlot, "Static_ClassIcon_" .. index)
    slot.txt_Level = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "StaticText_Level", slot.stc_RaidSlot, "StaticText_Level_" .. index)
    slot.txt_Name = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "StaticText_Name", slot.stc_RaidSlot, "StaticText_Name_" .. index)
    slot.stc_PlatformIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "Static_PlatFormIcon", slot.stc_RaidSlot, "Static_PlatFormIcon" .. index)
    slot.stc_KeyGuide_A = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "StaticText_A_ConsoleUI", slot.stc_RaidSlot, "StaticText_A_ConsoleUI_" .. index)
    slot.stc_KeyGuide_X = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "StaticText_X_ConsoleUI", slot.stc_RaidSlot, "StaticText_X_ConsoleUI_" .. index)
    slot.stc_KeyGuide_Y = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "StaticText_Y_ConsoleUI", slot.stc_RaidSlot, "StaticText_Y_ConsoleUI_" .. index)
    slot.stc_SelfBorder = UI.createAndCopyBasePropertyControl(self._ui.stc_RaidSlot_Template, "Static_SelfBorder", slot.stc_RaidSlot, "Static_SelfBorder" .. index)
    slot.txt_Level:SetTextMode(__eTextMode_AutoWrap)
    slot.txt_Name:SetTextMode(__eTextMode_AutoWrap)
    function slot:setPos(index)
      local partyInfo = Panel_Window_PartySetting_info
      local col = index % partyInfo._config.slotSmallCol
      local newPosX = partyInfo._pos.largePartyStartX + col * (partyInfo._pos.largePartySizeX + partyInfo._pos.largePartySpace)
      local newPosY = partyInfo._pos.largePartyStartY + row * (partyInfo._pos.largePartySizeY + partyInfo._pos.largePartySpace)
      self.stc_RaidSlot:SetPosY(newPosY)
      self.stc_RaidSlot:SetPosX(newPosX)
      if 0 == col - partyInfo._config.slotSmallRow then
        row = row + 1
      end
    end
    function slot:setShow(bShow)
      self.stc_RaidSlot:SetShow(bShow)
    end
    function slot:SetIgnore(bIgnore)
      self.stc_RaidSlot:SetIgnore(bIgnore)
    end
    slot.slotNo = index
    slot:setPos(index)
    slot.stc_RaidSlot:addInputEvent("Mouse_On", "PaGlobalFunc_PartySetting_OnSelectLargeParty(" .. index .. ")")
    slot.stc_RaidSlot:addInputEvent("Mouse_Out", "PaGlobalFunc_PartySetting_OutSelectLargeParty(" .. index .. ")")
    slot.stc_KeyGuide_A:SetShow(false)
    slot.stc_KeyGuide_X:SetShow(false)
    slot.stc_KeyGuide_Y:SetShow(false)
    slot.stc_SelfBorder:SetShow(false)
    slot.stc_OverBG:SetShow(false)
    slot.stc_TitleBG:SetShow(false)
    slot.stc_PlatformIcon:SetShow(false)
    self._partyMemberUISmall[index] = slot
  end
end
function Panel_Window_PartySetting_info:clearButton(index)
  self._partyMemberUIBig[index].staticText_Invite_ConsoleUI:SetShow(false)
  self._partyMemberUIBig[index].staticText_Authorize_ConsoleUI:SetShow(false)
  self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetShow(false)
  self._partyMemberUIBig[index].staticText_ShowProfile_ConsoleUI:SetShow(false)
end
function Panel_Window_PartySetting_info:setBigButtonIcon(index)
  if nil == index then
    return
  end
  if index == self._value.partyMemberCount then
    self._partyMemberUIBig[index].staticText_Authorize_ConsoleUI:SetShow(false)
    self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetShow(false)
    self._partyMemberUIBig[index].staticText_ShowProfile_ConsoleUI:SetShow(false)
    self._partyMemberUIBig[index].staticText_Invite_ConsoleUI:SetShow(true)
    self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PartySetting_OpenInvite(0)")
    self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  else
    if true == _ContentsGroup_isPS4UI then
      local selfPlayerPlatform = ToClient_getGamePlatformType()
      if self._partyMemberData[index]._platformType == selfPlayerPlatform then
        self._partyMemberUIBig[index].staticText_ShowProfile_ConsoleUI:SetShow(true)
        self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PartySetting_ShowProfile(" .. index .. ")")
      else
        self._partyMemberUIBig[index].staticText_ShowProfile_ConsoleUI:SetShow(false)
        self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    end
    if true == self._value.isMaster then
      self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetShow(true)
      self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PartySetting_BanishMember(" .. index .. ",true)")
      if true == self._partyMemberData[index]._isSelf then
        self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PartySetting_KickOrOutParty(" .. index .. ")")
        self._partyMemberUIBig[index].staticText_Authorize_ConsoleUI:SetShow(false)
        self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      else
        self._partyMemberUIBig[index].staticText_Authorize_ConsoleUI:SetShow(true)
        self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PartySetting_ChangeLeader(" .. index .. ")")
      end
    elseif true == self._partyMemberData[index]._isSelf then
      self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetShow(true)
      self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PartySetting_KickOrOutParty(" .. index .. ")")
    else
      self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
      self._partyMemberUIBig[index].static_CharacterSlot_Template:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
  end
end
function Panel_Window_PartySetting_info:setBigButtonText(index)
  if index == self._value.partyMemberCount then
    return
  end
  if true == self._value.isMaster then
    local changeLeaderText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_AUTORIZE")
    self._partyMemberUIBig[index].staticText_Authorize_ConsoleUI:SetText(changeLeaderText)
    if true == self._partyMemberData[index]._isSelf then
      local outText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEAVE")
      self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetText(outText)
    else
      local kickText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_KICKOUT")
      self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetText(kickText)
    end
  elseif true == self._partyMemberData[index]._isSelf then
    local outText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEAVE")
    self._partyMemberUIBig[index].staticText_KickOut_ConsoleUI:SetText(outText)
  end
end
function Panel_Window_PartySetting_info:setBigInfo(index)
  self:clearButton(index)
  self._partyMemberUIBig[index].staticText_Recruite:SetShow(false)
  if true == self._partyMemberData[index]._isSelf then
    local selfPosY = self._partyMemberUIBig[index].static_CharacterSlot_Template:GetPosY()
    self._ui.static_FocusSlot:SetPosY(selfPosY)
    self._ui.static_FocusSlot:SetShow(true)
  end
  if true == self._partyMemberData[index]._isMaster then
    self._partyMemberUIBig[index].static_LeaderIcon:SetShow(true)
  else
    self._partyMemberUIBig[index].static_LeaderIcon:SetShow(false)
  end
  if self._partyMemberData[index]._isOffline == true then
    if self._partyMemberData[index]._serverNo == 0 then
      self._partyMemberUIBig[index].staticText_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_PARTY_DISCONNECT"))
    else
      local serverNo = self._partyMemberData[index]._serverNo
      local curChannelData = getCurrentChannelServerData()
      local currentServerNo = curChannelData._serverNo
      local channelName = getChannelName(curChannelData._worldNo, serverNo)
      self._partyMemberUIBig[index].staticText_Level:SetText(channelName)
    end
    self._partyMemberUIBig[index].staticText_Level:SetShow(true)
  else
    self._partyMemberUIBig[index].staticText_Level:SetShow(true)
    self._partyMemberUIBig[index].staticText_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. self._partyMemberData[index]._level)
  end
  self._partyMemberUIBig[index].staticText_Name:SetShow(true)
  self._partyMemberUIBig[index].staticText_Name:SetText(self._partyMemberData[index]._name)
  self:setBigIcon(index)
  self._partyMemberUIBig[index].classType = self._partyMemberData[index]._class
  if true == ToClient_isTotalGameClient() then
    self:setCrossPlayIcon(self._partyMemberUIBig[index].static_PlatformIcon, self._partyMemberData[index]._platformType, self._partyMemberUIBig[index].staticText_Name)
  end
  if true == self._value.isOnPanel then
    self:setBigButtonIcon(self._value.currentIndex)
  end
end
function Panel_Window_PartySetting_info:setBigInviteInfo(index)
  self:clearButton(index)
  self._partyMemberUIBig[index].static_ClassIcon:SetShow(false)
  self._partyMemberUIBig[index].staticText_Level:SetShow(false)
  self._partyMemberUIBig[index].staticText_Name:SetShow(false)
  self._partyMemberUIBig[index].static_LeaderIcon:SetShow(false)
  self:setBigInviteIcon(index)
  self._partyMemberUIBig[index].classType = -1
  if true == self._value.isOnPanel and index == self._value.currentIndex then
    self._partyMemberUIBig[index].staticText_Invite_ConsoleUI:SetShow(true)
  end
end
function Panel_Window_PartySetting_info:setBigIcon(index)
  local classType = self._partyMemberData[index]._class
  if self._partyMemberUIBig[index].classType == classType then
    return
  end
  if true == self._partyMemberData[index]._isOffline then
    classType = -1
    self._partyMemberUIBig[index].static_ClassIcon:SetShow(false)
  end
  local texture_Big = NewClassData.newClass_Texture_ID[classType]._partyBigTextureTID
  if texture_Big ~= nil then
    self._partyMemberUIBig[index].classType = classType
    self._partyMemberUIBig[index].static_ClassImage:ChangeTextureInfoTextureIDAsync(texture_Big, 0)
    self._partyMemberUIBig[index].static_ClassImage:setRenderTexture(self._partyMemberUIBig[index].static_ClassImage:getBaseTexture())
    self._partyMemberUIBig[index].static_ClassImage:SetShow(true)
  end
  local texture_Icon = NewClassData.newClass_Texture_ID[classType]._symbolTextureTID
  if texture_Icon ~= nil then
    self._partyMemberUIBig[index].static_ClassIcon:ChangeTextureInfoTextureIDAsync(texture_Icon, 0)
    self._partyMemberUIBig[index].static_ClassIcon:setRenderTexture(self._partyMemberUIBig[index].static_ClassIcon:getBaseTexture())
    self._partyMemberUIBig[index].static_ClassIcon:SetShow(true)
  end
end
function Panel_Window_PartySetting_info:setBigInviteIcon(index)
  if nil == self._partyMemberUIBig[index] then
    return
  end
  local classType = -1
  if self._partyMemberUIBig[index].classType == classType then
    return
  end
  local texture_Big = NewClassData.newClass_Texture_ID[classType]._partyBigTextureTID
  if texture_Big ~= nil then
    self._partyMemberUIBig[index].static_ClassImage:ChangeTextureInfoTextureIDAsync(texture_Big, 0)
    self._partyMemberUIBig[index].static_ClassImage:setRenderTexture(self._partyMemberUIBig[index].static_ClassImage:getBaseTexture())
    self._partyMemberUIBig[index].static_ClassImage:SetShow(true)
  end
  self._partyMemberUIBig[index].staticText_Recruite:SetShow(true)
end
function Panel_Window_PartySetting_info:setCrossPlayIcon(targetControl, platformType, nameControl)
  targetControl:SetShow(false)
  if nil == platformType then
    return
  end
  if true == _ContentsGroup_ConsoleIntegration then
    targetControl:SetPosX(nameControl:GetPosX() + nameControl:GetTextSizeX() + 5)
    targetControl:SetPosY(nameControl:GetPosY())
    targetControl:SetShow(true)
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if selfPlayerPlatform == platformType then
      if __eGAME_PLATFORM_TYPE_PS == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_ps.dds")
      elseif __eGAME_PLATFORM_TYPE_XB == selfPlayerPlatform then
        targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_xb.dds")
      end
    else
      targetControl:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_other.dds")
    end
  end
end
function Panel_Window_PartySetting_info:clearBottomTab()
  for index = 0, self._config.lootingOptionCount - 1 do
    self._ui.radioButton[index]:SetFontColor(self._color.unSelected)
    self._ui.radioButton[index]:SetCheck(false)
  end
end
function Panel_Window_PartySetting_info:updateDefaultPartySettingList()
  local self = Panel_Window_PartySetting_info
  self._ui.radioButtonText:SetText("")
  if 0 == self._value.partyMemberCount then
    self._ui.static_FocusSlot:SetShow(false)
    self._ui.static_NoExpAlertBg:SetShow(false)
  end
  for index = 0, self._config.maxBigSlot - 1 do
    self._partyMemberUIBig[index]:setShow(false)
    if index < self._value.partyMemberCount then
      self._partyMemberUIBig[index]:setShow(true)
      self._partyMemberUIBig[index]:SetIgnore(false)
      self:setBigInfo(index)
    elseif index == self._value.partyMemberCount and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      self._partyMemberUIBig[index]:setShow(true)
      self._partyMemberUIBig[index]:SetIgnore(false)
      self._partyMemberUIBig[index].static_PlatformIcon:SetShow(false)
      self:setBigInviteInfo(index)
    else
      self._partyMemberUIBig[index]:setShow(false)
    end
  end
end
function Panel_Window_PartySetting_info:updateLargePartySettingList()
  if 0 == self._value.partyMemberCount then
    self._ui.static_FocusSlot:SetShow(false)
    self._ui.static_NoExpAlertBg:SetShow(false)
  end
  for index = 0, self._config.maxSmallSlot - 1 do
    self._partyMemberUISmall[index]:setShow(false)
    if index < self._value.partyMemberCount then
      self._partyMemberUISmall[index]:setShow(true)
      self._partyMemberUISmall[index]:SetIgnore(false)
      self:setSmallInfo(index)
    elseif index == self._value.partyMemberCount and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) then
      self._partyMemberUISmall[index]:setShow(true)
      self._partyMemberUISmall[index]:SetIgnore(false)
      self._partyMemberUISmall[index].stc_PlatformIcon:SetShow(false)
      self:setSamllInviteInfo(index)
    end
  end
end
function Panel_Window_PartySetting_info:setSmallButtonIcon(index)
  if nil == index then
    return
  end
  self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._partyMemberUISmall[index].stc_OverBG:SetShow(false)
  self._partyMemberUISmall[index].stc_TitleBG:SetShow(true)
  self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
  self._partyMemberUISmall[index].stc_OverBG:SetSize(self._partyMemberUISmall[index].stc_OverBG:GetSizeX(), self._partyMemberUISmall[index].stc_KeyGuide_A:GetSizeY())
  self._partyMemberUISmall[index].stc_OverBG:SetPosY((self._partyMemberUISmall[index].stc_RaidSlot:GetSizeY() - self._partyMemberUISmall[index].stc_OverBG:GetSizeY()) / 2)
  self._partyMemberUISmall[index].stc_KeyGuide_A:SetSpanSize(0, 0)
  self._partyMemberUISmall[index].stc_KeyGuide_X:SetSpanSize(0, 0)
  self._partyMemberUISmall[index].stc_KeyGuide_Y:SetSpanSize(0, 0)
  if index == self._value.partyMemberCount then
    self._partyMemberUISmall[index].stc_TitleBG:SetShow(false)
    self._partyMemberUISmall[index].stc_OverBG:SetShow(true)
    self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PartySetting_OpenInvite(1)")
    self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(true)
    self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(false)
    self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
    self._partyMemberUISmall[index].stc_KeyGuide_X:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_INVITE_MESSAGEBOX_TITLE"))
  else
    local changeLeaderText = PAGetString(Defines.StringSheet_RESOURCE, "PARTYOPTION_BTN_MANDATE")
    local kickText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_KICKOUT")
    local outText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_LEAVE")
    if true == self._value.isMaster then
      if true == self._partyMemberData[index]._isSelf then
        self._partyMemberUISmall[index].stc_OverBG:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(false)
        self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetText(outText)
        self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PartySetting_KickOrOutParty(" .. index .. ")")
      else
        self._partyMemberUISmall[index].stc_OverBG:SetSize(self._partyMemberUISmall[index].stc_OverBG:GetSizeX(), self._partyMemberUISmall[index].stc_KeyGuide_A:GetSizeY() * 2)
        self._partyMemberUISmall[index].stc_OverBG:SetPosY((self._partyMemberUISmall[index].stc_RaidSlot:GetSizeY() - self._partyMemberUISmall[index].stc_OverBG:GetSizeY()) / 2)
        self._partyMemberUISmall[index].stc_OverBG:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(false)
        self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_X:SetTextMode(__eTextMode_AutoWrap)
        self._partyMemberUISmall[index].stc_KeyGuide_X:SetText(changeLeaderText)
        self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PartySetting_ChangeLeader(" .. index .. ")")
        self._partyMemberUISmall[index].stc_KeyGuide_X:SetSpanSize(0, -(self._ui.stc_Raid_KeyGuide_X:GetSizeY() / 2))
        self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_Y:SetText(kickText)
        self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_PartySetting_BanishMember(" .. index .. ",true)")
        self._partyMemberUISmall[index].stc_KeyGuide_Y:SetSpanSize(0, self._ui.stc_Raid_KeyGuide_Y:GetSizeY() / 2)
      end
    elseif true == self._partyMemberData[index]._isSelf then
      self._partyMemberUISmall[index].stc_OverBG:SetShow(true)
      self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(true)
      self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(false)
      self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
      self._partyMemberUISmall[index].stc_KeyGuide_A:SetText(outText)
      self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PartySetting_KickOrOutParty(" .. index .. ")")
    end
    if _ContentsGroup_isPS4UI and false == self._partyMemberData[index]._isSelf then
      local selfPlayerPlatform = ToClient_getGamePlatformType()
      if self._partyMemberData[index]._platformType == selfPlayerPlatform then
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(true)
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_XBOX_PROFILE"))
        self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_PartySetting_ShowProfile(" .. index .. ")")
        local sizeY = self._ui.stc_Raid_KeyGuide_X:GetSizeY()
        if self._partyMemberUISmall[index].stc_KeyGuide_Y:GetShow() and self._partyMemberUISmall[index].stc_KeyGuide_A:GetShow() then
          self._partyMemberUISmall[index].stc_KeyGuide_X:SetSpanSize(0, -sizeY + 5)
          self._partyMemberUISmall[index].stc_KeyGuide_Y:SetSpanSize(0, 0)
          self._partyMemberUISmall[index].stc_KeyGuide_A:SetSpanSize(0, sizeY - 5)
          self._partyMemberUISmall[index].stc_OverBG:SetSize(self._partyMemberUISmall[index].stc_OverBG:GetSizeX(), sizeY * 3 - 17)
        elseif self._partyMemberUISmall[index].stc_KeyGuide_Y:GetShow() or self._partyMemberUISmall[index].stc_KeyGuide_X:GetShow() then
          self._partyMemberUISmall[index].stc_KeyGuide_X:SetSpanSize(0, -(self._ui.stc_Raid_KeyGuide_X:GetSizeY() / 2))
          self._partyMemberUISmall[index].stc_KeyGuide_Y:SetSpanSize(0, -(self._ui.stc_Raid_KeyGuide_Y:GetSizeY() / 2))
          self._partyMemberUISmall[index].stc_KeyGuide_A:SetSpanSize(0, self._ui.stc_Raid_KeyGuide_A:GetSizeY() / 2)
          self._partyMemberUISmall[index].stc_OverBG:SetSize(self._partyMemberUISmall[index].stc_OverBG:GetSizeX(), sizeY * 2 - 17)
        else
          self._partyMemberUISmall[index].stc_KeyGuide_A:SetSpanSize(0, 0)
          self._partyMemberUISmall[index].stc_OverBG:SetSize(self._partyMemberUISmall[index].stc_OverBG:GetSizeX(), self._partyMemberUISmall[index].stc_KeyGuide_A:GetSizeY())
        end
        self._partyMemberUISmall[index].stc_OverBG:SetShow(true)
        self._partyMemberUISmall[index].stc_OverBG:SetPosY((self._partyMemberUISmall[index].stc_RaidSlot:GetSizeY() - self._partyMemberUISmall[index].stc_OverBG:GetSizeY()) / 2)
      else
        self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(false)
        self._partyMemberUISmall[index].stc_RaidSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      end
    end
  end
end
function Panel_Window_PartySetting_info:clearSmallButton(index)
  if nil == index or nil == self._partyMemberUISmall[index] then
    return
  end
  self._partyMemberUISmall[index].stc_OverBG:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_A:SetSpanSize(0, 0)
  self._partyMemberUISmall[index].stc_KeyGuide_X:SetSpanSize(0, 0)
  self._partyMemberUISmall[index].stc_KeyGuide_Y:SetSpanSize(0, 0)
end
function Panel_Window_PartySetting_info:setSmallInfo(index)
  self:clearSmallButton(index)
  local isSelf = self._partyMemberData[index]._isSelf
  self._partyMemberUISmall[index].stc_SelfBorder:SetShow(isSelf)
  local isMaster = self._partyMemberData[index]._isMaster
  self._partyMemberUISmall[index].stc_LeaderIcon:SetShow(isMaster)
  if self._partyMemberData[index]._isOffline == true then
    if self._partyMemberData[index]._serverNo == 0 then
      self._partyMemberUISmall[index].txt_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_PARTY_DISCONNECT"))
    else
      local serverNo = self._partyMemberData[index]._serverNo
      local curChannelData = getCurrentChannelServerData()
      local currentServerNo = curChannelData._serverNo
      local channelName = getChannelName(curChannelData._worldNo, serverNo)
      self._partyMemberUISmall[index].txt_Level:SetText(channelName)
    end
    self._partyMemberUISmall[index].txt_Level:SetShow(true)
  else
    self._partyMemberUISmall[index].txt_Level:SetShow(true)
    self._partyMemberUISmall[index].txt_Level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. self._partyMemberData[index]._level)
  end
  local controlOffsetY = 10
  self._partyMemberUISmall[index].txt_Name:SetShow(true)
  self._partyMemberUISmall[index].txt_Name:SetText(self._partyMemberData[index]._name)
  local levelPosY = self._partyMemberUISmall[index].txt_Name:GetPosY() - (self._partyMemberUISmall[index].txt_Name:GetTextSizeY() - controlOffsetY)
  self._partyMemberUISmall[index].txt_Level:SetPosY(levelPosY)
  self:setSmallIcon(index)
  self._partyMemberUISmall[index].classType = self._partyMemberData[index]._class
  if true == ToClient_isTotalGameClient() then
    self:setCrossPlayIcon(self._partyMemberUISmall[index].stc_PlatformIcon, self._partyMemberData[index]._platformType, self._partyMemberUISmall[index].txt_Name)
    local iconPosY = self._partyMemberUISmall[index].txt_Name:GetPosY() - (self._partyMemberUISmall[index].txt_Name:GetTextSizeY() / 2 - controlOffsetY)
    self._partyMemberUISmall[index].stc_PlatformIcon:SetPosY(iconPosY)
  end
  if true == self._value.isOnPanel then
    self:setSmallButtonIcon(self._value.currentIndex)
  end
end
function Panel_Window_PartySetting_info:setSmallIcon(index)
  local classType = self._partyMemberData[index]._class
  if self._partyMemberUISmall[index].classType == classType then
    return
  end
  if true == self._partyMemberData[index]._isOffline then
    classType = -1
    self._partyMemberUISmall[index].stc_ClassIcon:SetShow(false)
  end
  local texture_Small = NewClassData.newClass_Texture_ID[classType]._partySmallTextureTID
  if texture_Small ~= nil then
    self._partyMemberUISmall[index].stc_ClassImage:ReleaseTexture()
    self._partyMemberUISmall[index].stc_ClassImage:ChangeTextureInfoTextureIDAsync(texture_Small, 0)
    self._partyMemberUISmall[index].stc_ClassImage:setRenderTexture(self._partyMemberUISmall[index].stc_ClassImage:getBaseTexture())
    self._partyMemberUISmall[index].stc_ClassImage:SetShow(true)
  end
  local texture_Icon = NewClassData.newClass_Texture_ID[classType]._symbolTextureTID
  if texture_Icon ~= nil then
    self._partyMemberUISmall[index].stc_ClassIcon:ChangeTextureInfoTextureIDAsync(texture_Icon, 0)
    self._partyMemberUISmall[index].stc_ClassIcon:setRenderTexture(self._partyMemberUISmall[index].stc_ClassIcon:getBaseTexture())
    self._partyMemberUISmall[index].stc_ClassIcon:SetShow(true)
  end
end
function Panel_Window_PartySetting_info:setSamllInviteInfo(index)
  self._partyMemberUISmall[index].stc_KeyGuide_A:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(false)
  self._partyMemberUISmall[index].stc_KeyGuide_Y:SetShow(false)
  self._partyMemberUISmall[index].txt_Level:SetShow(false)
  self._partyMemberUISmall[index].txt_Name:SetShow(false)
  self._partyMemberUISmall[index].stc_LeaderIcon:SetShow(false)
  self._partyMemberUISmall[index].stc_ClassIcon:SetShow(false)
  self._partyMemberUISmall[index].stc_SelfBorder:SetShow(false)
  self:setSmallInviteIcon(index)
  self._partyMemberUISmall[index].classType = -1
  if true == self._value.isOnPanel and index == self._value.currentIndex then
    self._partyMemberUISmall[index].stc_KeyGuide_X:SetShow(true)
  end
end
function Panel_Window_PartySetting_info:setSmallInviteIcon(index)
  if nil == self._partyMemberUISmall[index] then
    return
  end
  local classType = -1
  if self._partyMemberUISmall[index].classType == classType then
    return
  end
  local texture_Small = NewClassData.newClass_Texture_ID[classType]._partySmallTextureTID
  if texture_Small ~= nil then
    self._partyMemberUISmall[index].stc_ClassImage:ChangeTextureInfoTextureIDAsync(texture_Small, 0)
    self._partyMemberUISmall[index].stc_ClassImage:setRenderTexture(self._partyMemberUISmall[index].stc_ClassImage:getBaseTexture())
    self._partyMemberUISmall[index].stc_ClassImage:SetShow(true)
  end
end
function Panel_Window_PartySetting_info:updatePartySettingList(partyType)
  self._value.partyMemberCount = RequestParty_getPartyMemberCount()
  if false == getSelfPlayer():get():hasParty() then
    partyType = self._value.partyType
  end
  if nil == partyType and nil ~= self._value.partyType and self._value.partyType ~= ToClient_GetPartyType() then
    self._changedPartyMode = true
  end
  if nil == partyType then
    self._value.partyType = ToClient_GetPartyType()
  else
    self._value.partyType = partyType
  end
  self._value.isMaster = RequestParty_isLeader()
  if true == _ContentsGroup_NewUI_PartyWidget_All then
    self._partyMemberData = PaGlobalFunc_Widget_Party_All_SetMemberDataConsole(self._value.partyMemberCount)
  else
    self._partyMemberData = PaGlobalFunc_ResponseParty_PartyMemberSet(self._value.partyMemberCount)
  end
  local isPartyFlag = CppEnums.PartyType.ePartyType_Normal == self._value.partyType
  Panel_Window_PartySetting_info:SetShowPartyList(not isPartyFlag)
  if CppEnums.PartyType.ePartyType_Normal == self._value.partyType then
    if not isFlushedUI() then
      self:open()
    end
    self:updateDefaultPartySettingList()
  elseif CppEnums.PartyType.ePartyType_Large == self._value.partyType then
    self:updateLargePartySettingList()
  end
  if self._changedPartyMode then
    self._changedPartyMode = false
    PaGlobalFunc_ChattingHistory_ChangePartyType(self._value.partyType)
    ToClient_padSnapSetTargetPanel(Panel_Window_PartySetting)
  end
end
function Panel_Window_PartySetting_info:SetShowPartyList(isRaid)
  local isPartyFlag = CppEnums.PartyType.ePartyType_Normal == self._value.partyType
  self._ui.static_FocusSlot:SetShow(isPartyFlag)
  self._ui.static_ExpBonusIcon:SetShow(isPartyFlag)
  if false == isRaid then
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TITLE"))
    for index = 0, self._config.maxSmallSlot - 1 do
      self._partyMemberUISmall[index]:setShow(false)
      self._partyMemberUISmall[index]:SetIgnore(true)
    end
  else
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LARGEPARTYSETTING_TITLE"))
    for index = 0, self._config.maxBigSlot - 1 do
      self._partyMemberUIBig[index]:setShow(false)
      self._partyMemberUIBig[index]:SetIgnore(true)
    end
  end
end
function Panel_Window_PartySetting_info:setBgSize()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local sizeX = self._renewchattingUISize
  Panel_Window_PartySetting:SetSize(screenSizeX, screenSizeY)
  Panel_Window_PartySetting:ComputePos()
  if true == _ContentsGroup_RenewUI_Chatting then
    sizeX = PaGlobalFunc_ChattingHistory_GetSizeX()
  end
  local newBgSizeX = screenSizeX - sizeX
  local backgroundSize = newBgSizeX + 10
  self._ui.static_Bg:SetSize(backgroundSize, screenSizeY)
  self._ui.static_Content:SetSize(backgroundSize - 100, screenSizeY)
  self._ui.static_BottomBg:ComputePos()
  self._ui.static_DropOption:SetSize(backgroundSize, self._ui.static_DropOption:GetSizeY())
  self._ui.static_DropOption:ComputePos()
  self._ui.static_LT_ConsoleUI:ComputePos()
  self._ui.static_RT_ConsoleUI:ComputePos()
  self._ui.radioButtonText:ComputePos()
  local dropOptionSize = math.min(self._DROPOPTION_MAXSIZE, newBgSizeX)
  local dropOptionPositionPerButton = dropOptionSize / (self._config.lootingOptionCount + 1)
  local lootingOptionMiddlePoint = (self._config.lootingOptionCount + 1) / 2
  for index = 0, self._config.lootingOptionCount - 1 do
    self._ui.radioButton[index]:SetSpanSize(dropOptionPositionPerButton * (index - lootingOptionMiddlePoint + 1), 50)
    self._ui.radioButton[index]:ComputePos()
  end
  local staticLine = UI.getChildControl(self._ui.static_DropOption, "Static_Line")
  staticLine:SetSize(dropOptionSize - 80, staticLine:GetSizeY())
  staticLine:ComputePos()
  if CppEnums.PartyType.ePartyType_Normal == self._value.partyType then
    for index = 0, self._config.maxBigSlot - 1 do
      local currentPartyMemberUI = self._partyMemberUIBig[index]
      currentPartyMemberUI.static_CharacterSlot_Template:SetSize(backgroundSize - 100, self._partyMemberUIBig[index].static_CharacterSlot_Template:GetSizeY())
      currentPartyMemberUI.static_CharacterSlot_Template:ComputePos()
      currentPartyMemberUI:setPos(index)
      currentPartyMemberUI.static_Info:ComputePos()
      currentPartyMemberUI.static_ClassIcon:ComputePos()
      currentPartyMemberUI.staticText_Level:ComputePos()
      currentPartyMemberUI.staticText_Name:ComputePos()
      currentPartyMemberUI.static_PlatformIcon:ComputePos()
      currentPartyMemberUI.staticText_KickOut_ConsoleUI:ComputePos()
      currentPartyMemberUI.staticText_Authorize_ConsoleUI:ComputePos()
      currentPartyMemberUI.staticText_Recruite:ComputePos()
      currentPartyMemberUI.staticText_Invite_ConsoleUI:ComputePos()
    end
    self._pos.aniInfoBasePosX = self._partyMemberUIBig[0].static_Info:GetPosX()
    self._pos.aniInfoEndPosX = math.min(self._partyMemberUIBig[0].static_ClassImage:GetPosX() + self._partyMemberUIBig[0].static_ClassImage:GetSizeX() / 2, self._pos.aniInfoBasePosX)
  end
  self._ui.static_FocusSlot:SetSize(backgroundSize - 100, self._ui.static_FocusSlot:GetSizeY())
  self._ui.static_FocusSlot:ComputePos()
  self._ui.static_ExpBonusIcon:ComputePos()
  self._ui.static_NoExpAlertBg:ComputePos()
  local staticTextDesc = UI.getChildControl(self._ui.static_ExpBonusIcon, "StaticText_Desc")
  staticTextDesc:ComputePos()
  local staticDeco = UI.getChildControl(self._ui.static_FocusSlot, "Static_Deco")
  staticDeco:ComputePos()
end
function Panel_Window_PartySetting_info:open()
  Panel_Window_PartySetting:SetShow(true)
end
function Panel_Window_PartySetting_info:close()
  Panel_Window_PartySetting:SetShow(false)
end
function PaGlobalFunc_PartySetting_OnSelectPartyOnAni(index)
  local self = Panel_Window_PartySetting_info
  local aniInfo1 = self._partyMemberUIBig[index].static_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(self._pos.aniInfoBasePosX, 0)
  aniInfo1:SetEndPosition(self._pos.aniInfoEndPosX, 0)
  aniInfo1.IsChangeChild = true
  local aniInfo2 = self._partyMemberUIBig[index].static_ClassImage:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo2:SetStartPosition(self._pos.aniInfoBasePosX, 0)
  aniInfo2:SetEndPosition(0, 0)
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_PartySetting_OutSelectPartyOutAni(index)
  local self = Panel_Window_PartySetting_info
  local aniInfo1 = self._partyMemberUIBig[index].static_Info:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(self._pos.aniInfoEndPosX, 0)
  aniInfo1:SetEndPosition(self._pos.aniInfoBasePosX, 0)
  aniInfo1.IsChangeChild = true
end
function PaGlobalFunc_PartySetting_OnSelectLargePartyOnAni(index)
  local self = Panel_Window_PartySetting_info
  local posY = self._partyMemberUISmall[index].stc_OverBG:GetPosY()
  local aniInfo1 = self._partyMemberUISmall[index].stc_OverBG:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(0, posY + 10)
  aniInfo1:SetEndPosition(0, posY)
  aniInfo1.IsChangeChild = true
  local aniInfo2 = self._partyMemberUISmall[index].stc_OverBG:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo2:SetStartPosition(0, posY + 10)
  aniInfo2:SetEndPosition(0, posY)
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_PartySetting_OutSelectLargePartyOutAni(index)
  local self = Panel_Window_PartySetting_info
  local posY = self._partyMemberUISmall[index].stc_OverBG:GetPosY()
  local aniInfo1 = self._partyMemberUISmall[index].stc_OverBG:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartPosition(0, posY)
  aniInfo1:SetEndPosition(0, posY + 10)
  aniInfo1.IsChangeChild = true
end
function PaGlobalFunc_PartySetting_GetShow()
  return Panel_Window_PartySetting:GetShow()
end
function PaGlobalFunc_PartySetting_Close()
  local self = Panel_Window_PartySetting_info
  self:close()
end
function PaGlobalFunc_PartySetting_Open(partyType)
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return false
  end
  local self = Panel_Window_PartySetting_info
  self:initValue()
  if nil == partyType then
    self._value.partyType = ToClient_GetPartyType()
  else
    if partyType ~= ToClient_GetPartyType() and getSelfPlayer():get():hasParty() then
      local typeStr = ""
      if CppEnums.PartyType.ePartyType_Normal == ToClient_GetPartyType() then
        typeStr = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_LARGEPARTY_TITLE")
      else
        typeStr = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_PARTY")
      end
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MENU_PARTY_ALERTMESSAGE", "partyType", typeStr))
      return false
    end
    self._value.partyType = partyType
  end
  self._value.currentIndex = 0
  self:updatePartySettingList(partyType)
  local isPartyFlag = CppEnums.PartyType.ePartyType_Normal == self._value.partyType
  self._ui.static_FocusSlot:SetShow(isPartyFlag)
  Panel_Window_PartySetting_info:SetShowPartyList(not isPartyFlag)
  self._ui.static_ExpBonusIcon:SetShow(isPartyFlag)
  if true == isPartyFlag then
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYSETTING_TITLE"))
  else
    self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LARGEPARTYSETTING_TITLE"))
  end
  self:open()
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingHistory_Open(nil, true, partyType)
  end
  ToClient_padSnapSetTargetPanel(Panel_Window_PartySetting)
  if nil ~= PaGlobalFunc_BloodAltar_SetOpenType then
    PaGlobalFunc_BloodAltar_SetOpenType(__eInstanceSetSubScriptType_CantSet)
  end
  return true
end
function PaGlobalFunc_PartySetting_Exit()
  local self = Panel_Window_PartySetting_info
  self:close()
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingHistory_Close()
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) and true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Window_BloodAltar_All then
    local bloodAltarType = PaGlobalFunc_PartySetting_GetOpenType()
    FromClient_BloodAltar_CheckSetSubScriptInstanceFieldAck(bloodAltarType)
  end
end
function PaGlobalFunc_PartySetting_ForBloodAltar()
  local self = Panel_Window_PartySetting_info
  self:initValue()
  self._value.partyType = ToClient_GetPartyType()
  self:updatePartySettingList()
  self:open()
  ToClient_padSnapSetTargetPanel(Panel_Window_PartySetting)
  if nil ~= PaGlobalFunc_BloodAltar_SetOpenType then
    PaGlobalFunc_BloodAltar_SetOpenType(__eInstanceSetSubScriptType_Setable)
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) and true == _ContentsGroup_UsePadSnapping and true == Panel_Window_BloodAltar_All:GetShow() and nil ~= Panel_Window_BloodAltar_All then
    PaGlobal_BloodAltar_All:prepareClose()
  end
end
function PaGlobalFunc_PartySetting_OnSelectParty(index)
  PaGlobalFunc_PartySetting_OnSelectPartyOnAni(index)
  local self = Panel_Window_PartySetting_info
  self._value.currentIndex = index
  self:setBigButtonIcon(index)
  self:setBigButtonText(index)
end
function PaGlobalFunc_PartySetting_OutSelectParty(index)
  PaGlobalFunc_PartySetting_OutSelectPartyOutAni(index)
  local self = Panel_Window_PartySetting_info
  self:clearButton(index)
end
function PaGlobalFunc_PartySetting_OnSelectLargeParty(index)
  local self = Panel_Window_PartySetting_info
  self._value.currentIndex = index
  self:setSmallButtonIcon(index)
  PaGlobalFunc_PartySetting_OnSelectLargePartyOnAni(index)
end
function PaGlobalFunc_PartySetting_OutSelectLargeParty(index)
  PaGlobalFunc_PartySetting_OutSelectLargePartyOutAni(index)
  local self = Panel_Window_PartySetting_info
  self:clearSmallButton(index)
end
function PaGlobalFunc_PartySetting_ChangeLeader(index)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  local self = Panel_Window_PartySetting_info
  local memberData = self._partyMemberData[index]
  RequestParty_changeLeader(memberData._index)
  self:updatePartySettingList()
end
function PaGlobalFunc_PartySetting_KickOrOutParty(index)
  local self = Panel_Window_PartySetting_info
  local memberData = self._partyMemberData[index]
  local isPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == isPlayingPvPMatch then
    RequestParty_withdrawMember(memberData._index)
    return
  end
  local function partyOut()
    RequestParty_withdrawMember(memberData._index)
    PaGlobalFunc_PartySetting_Exit()
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  end
  local messageBoxMemo = ""
  if CppEnums.PartyType.ePartyType_Normal == self._value.partyType then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PARTY_DISTRIBUTION_GETOUTPARTY")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LARGEPARTY_DISTRIBUTION_GETOUTPARTY")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = partyOut,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_PartySetting_BanishMember(index)
  local self = Panel_Window_PartySetting_info
  local memberData = self._partyMemberData[index]
  local withdrawMemberData = RequestParty_getPartyMemberAt(memberData._index)
  local withdrawMemberActorKey = withdrawMemberData:getActorKey()
  local withdrawMemberPlayerActor = getPlayerActor(withdrawMemberActorKey)
  local contentString = ""
  local titleForceOut = ""
  local function partyBanish()
    RequestParty_withdrawMember(memberData._index)
    _AudioPostEvent_SystemUiForXBOX(50, 0)
  end
  if 0 == self._value.partyType then
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_PARTY_FORCEOUT")
  else
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT_QUESTION", "member_name", withdrawMemberData:name())
    titleForceOut = PAGetString(Defines.StringSheet_GAME, "PANEL_LARGEPARTY_FORCEOUT")
  end
  local messageboxData = {
    title = titleForceOut,
    content = contentString,
    functionYes = partyBanish,
    functionNo = MessageBox_Empty_function,
    priority = PP.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_PartySetting_ShowProfile(index)
  local self = Panel_Window_PartySetting_info
  local memberData = self._partyMemberData[index]
  local withdrawMemberData = RequestParty_getPartyMemberAt(memberData._index)
  ToClient_showXboxFriendProfile(withdrawMemberData:getXuid())
end
function PaGlobalFunc_PartySetting_OpenInvite(partyType)
  local self = Panel_Window_PartySetting_info
  PaGlobalFunc_PartyInvite_Show(partyType)
end
function PaGlobalFunc_PartySetting_SelectLoot(value)
  local self = Panel_Window_PartySetting_info
  if CppEnums.PartyType.ePartyType_Normal ~= self._value.partyType then
    return
  end
  if true == self._value.isMaster then
    self._value.currentLootType = (self._value.currentLootType + value + self._config.lootingOptionCount) % self._config.lootingOptionCount
    PaGlobalFunc_PartySetting_ClickLoot(self._value.currentLootType)
  end
end
function PaGlobalFunc_PartySetting_ClickLoot(index)
  local self = Panel_Window_PartySetting_info
  if index == self._enum.eTAB_LOOTING_FREE then
  elseif index == self._enum.eTAB_LOOTING_ORDERED then
  elseif index == self._enum.eTAB_LOOTING_RANDOM then
  end
  RequestParty_changeLooting(index)
end
function FromClient_PartySetting_Init()
  local self = Panel_Window_PartySetting_info
  self:initialize()
end
function FromClient_PartySetting_Resize()
  local self = Panel_Window_PartySetting_info
  self:resize()
end
function FromClient_ResponseParty_updatePartySettingList()
  local self = Panel_Window_PartySetting_info
  if PaGlobalFunc_PartySetting_GetShow() then
    self:updatePartySettingList()
  end
end
function FromClient_PartySetting_PadSnapChangePanel(fromPanel, toPanel)
  local self = Panel_Window_PartySetting_info
  local thisPanelKey = Panel_Window_PartySetting:GetKey()
  if nil ~= toPanel then
    if thisPanelKey ~= toPanel:GetKey() then
      self._value.isOnPanel = false
    end
    if thisPanelKey == toPanel:GetKey() then
      self._value.isOnPanel = true
    end
  end
end
function FromClient_PartySetting_UpdatePartyExperiencePenalty(isPenalty)
  local self = Panel_Window_PartySetting_info
  if nil == isPenalty then
    return
  end
  if CppEnums.PartyType.ePartyType_Large == self._value.partyType then
    return
  end
  if isPenalty then
    self._ui.static_NoExpAlertBg:SetShow(true)
    self._ui.static_ExpBonusIcon:SetShow(false)
  else
    self._ui.static_NoExpAlertBg:SetShow(false)
    self._ui.static_ExpBonusIcon:SetShow(true)
  end
  if 0 == self._value.partyMemberCount then
    self._ui.static_NoExpAlertBg:SetShow(false)
  end
end
function FromClient_PartySetting_updatePartyLootType(lootType)
  if false == Panel_Window_PartySetting:GetShow() then
    return
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PartySetting_Init")
