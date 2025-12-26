PaGlobal_Atoraxion_MapSelecter = {
  _ui = {
    stc_Bg = nil,
    stc_controlBg = nil,
    stc_Line = nil,
    stc_Shadow = nil,
    stc_LeftTop = nil,
    btn_Close = nil,
    btn_Enter = nil,
    btn_Enter_Solo = nil,
    btn_Enter_Party = nil,
    stc_SlotBg = nil,
    stc_Icon = {},
    mapSelectBtn = {},
    stc_KeyguideBG = nil,
    stc_Keyguide_A = nil,
    stc_Keyguide_B = nil,
    stc_Keyguide_X = nil,
    txt_Title = nil,
    multiline_Desc = nil,
    needSelectMap = nil
  },
  _mapData = {
    [__eInstanceAtoraxion_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_0"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_0"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_01.dds"
    },
    [__eInstanceAtoraxionSea_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_1"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_1"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_02.dds"
    },
    [__eInstanceAtoraxionValley_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_2"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_2"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_03.dds"
    },
    [__eInstanceAtoraxionThorn_Hadum] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_3"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_3"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_05.dds"
    },
    [__eInstancePersonalAtoraxion_Illezra] = {
      _itemKey = 66012,
      _title = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_TITLE_4"),
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXION_SELECTREGION_DESC_4"),
      _bg = "Combine/Etc/Combine_Etc_Atoraxion_BG_06.dds"
    }
  },
  _eAtoraxionType = {
    DESERT = 1,
    SEA = 2,
    VALLEY = 3,
    THORN = 4,
    ILLEZRA = 5,
    COUNT = 6
  },
  _personalMapKey = {
    [__eInstanceAtoraxion_Hadum] = __eInstancePersonalAtoraxion_Desert,
    [__eInstanceAtoraxionSea_Hadum] = __eInstancePersonalAtoraxion_Sea,
    [__eInstanceAtoraxionValley_Hadum] = __eInstancePersonalAtoraxion_Valley,
    [__eInstanceAtoraxionThorn_Hadum] = __eInstancePersonalAtoraxion_Thorn,
    [__eInstancePersonalAtoraxion_Illezra] = __eInstancePersonalAtoraxion_Illezra
  },
  _personalContentsOption = {
    [__eInstanceAtoraxion_Hadum] = _ContentsGroup_PersonalAtoraxion,
    [__eInstanceAtoraxionSea_Hadum] = _ContentsGroup_PersonalAtoraxion_Sea,
    [__eInstanceAtoraxionValley_Hadum] = _ContentsGroup_PersonalAtoraxion_Valley,
    [__eInstanceAtoraxionThorn_Hadum] = _ContentsGroup_PersonalAtoraxion_Thorn,
    [__eInstancePersonalAtoraxion_Illezra] = _ContentsGroup_AtoraxionIllezra
  },
  _slotConfig = {createIcon = true, createCount = true},
  _initializeAnimation = false,
  _initializeScaleChange = false,
  _currentScale = 1,
  _leftTopDescOriginSpanX = 0,
  _currentSelect = nil,
  _isConsole = false,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Atoraxion_MapSelecter_Init")
function FromClient_Atoraxion_MapSelecter_Init()
  PaGlobal_Atoraxion_MapSelecter:initialize()
end
function PaGlobal_Atoraxion_MapSelecter:initialize()
  if true == PaGlobal_Atoraxion_MapSelecter._initialize or nil == Panel_Atoraxion_Select then
    return
  end
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self._ui.stc_Bg = UI.getChildControl(Panel_Atoraxion_Select, "Static_BG")
  self._ui.stc_controlBg = UI.getChildControl(Panel_Atoraxion_Select, "Static_Select_Set")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_controlBg, "StaticText_TItle")
  self._ui.stc_Line = UI.getChildControl(self._ui.stc_controlBg, "Static_Line")
  self._ui.stc_Shadow = UI.getChildControl(self._ui.stc_controlBg, "Static_Shadow")
  self._ui.stc_LeftTop = UI.getChildControl(self._ui.stc_controlBg, "Static_LeftTop")
  local descBG = UI.getChildControl(self._ui.stc_controlBg, "Static_Desc")
  self._ui.multiline_Desc = UI.getChildControl(descBG, "MultilineEdit_1")
  self._ui.needSelectMap = UI.getChildControl(descBG, "StaticText_1")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_controlBg, "Button_Close")
  self._ui.btn_Enter = UI.getChildControl(self._ui.stc_controlBg, "Button_Enter")
  self._ui.btn_Enter_Solo = UI.getChildControl(self._ui.stc_controlBg, "Button_Enter_Solo")
  self._ui.btn_Enter_Party = UI.getChildControl(self._ui.stc_controlBg, "Button_Enter_Party")
  local rdoBG = UI.getChildControl(self._ui.stc_controlBg, "Static_SelectArea_Group")
  self._ui.showAni1 = UI.getChildControl(rdoBG, "Static_1")
  self._ui.showAni2 = UI.getChildControl(rdoBG, "Static_2")
  self._ui.showAni3 = UI.getChildControl(rdoBG, "Static_3")
  self._ui.showAni4 = UI.getChildControl(rdoBG, "Static_4")
  self._ui.showAni5 = UI.getChildControl(rdoBG, "Static_5")
  for idx = self._eAtoraxionType.DESERT, self._eAtoraxionType.COUNT - 1 do
    local tempTable = {}
    tempTable._lock = UI.getChildControl(rdoBG, "Static_LockedArea_" .. tostring(idx))
    tempTable._rdoBtn = UI.getChildControl(rdoBG, "RadioButton_" .. tostring(idx))
    self._ui.mapSelectBtn[idx] = tempTable
  end
  self._ui.tag_update = UI.getChildControl(self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._rdoBtn, "Static_Update")
  self._ui.tag_update:SetShow(isGameTypeCH() == false and (self._isPadSnapping == false or _ContentsGroup_AtoraxionIllezra == true))
  self._ui.mapSelectBtn[self._eAtoraxionType.DESERT]._lock:SetShow(_ContentsGroup_AtoraxionDesert == false)
  self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._lock:SetShow(_ContentsGroup_AtoraxionSea == false)
  self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._lock:SetShow(_ContentsGroup_AtoraxionForest == false)
  self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._lock:SetShow(_ContentsGroup_AtoraxionThorn == false)
  self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._lock:SetShow(_ContentsGroup_AtoraxionIllezra == false)
  if self._isPadSnapping == true then
    self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._rdoBtn:SetIgnore(_ContentsGroup_AtoraxionSea == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._rdoBtn:SetIgnore(_ContentsGroup_AtoraxionForest == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._rdoBtn:SetIgnore(_ContentsGroup_AtoraxionThorn == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._rdoBtn:SetIgnore(_ContentsGroup_AtoraxionIllezra == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._lock:SetIgnore(_ContentsGroup_AtoraxionSea == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._lock:SetIgnore(_ContentsGroup_AtoraxionForest == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._lock:SetIgnore(_ContentsGroup_AtoraxionThorn == false)
    self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._lock:SetIgnore(_ContentsGroup_AtoraxionIllezra == false)
  end
  self._isConsole = ToClient_isConsole()
  if self._isConsole == true then
    local tagNew = UI.getChildControl(self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._rdoBtn, "Static_Update")
    tagNew:SetShow(_ContentsGroup_AtoraxionForest == true)
    tagNew = UI.getChildControl(self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._rdoBtn, "Static_Update")
    tagNew:SetShow(_ContentsGroup_AtoraxionThorn == true)
  end
  self._ui.stc_KeyguideBG = UI.getChildControl(self._ui.stc_controlBg, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_Keyguide_A = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_A_ConsoleUI")
  self._ui.stc_Keyguide_B = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_B_ConsoleUI")
  self._ui.stc_Keyguide_X = UI.getChildControl(self._ui.stc_KeyguideBG, "StaticText_X_ConsoleUI")
  local itemIconBg = UI.getChildControl(self._ui.stc_controlBg, "Static_ItemSlot_1")
  self._ui.stc_SlotBg = UI.getChildControl(itemIconBg, "Static_Icon")
  self._ui.stc_Icon = {}
  local temp = {}
  SlotItem.new(temp, "AtoraxionSelectICon_Enter", 0, self._ui.stc_SlotBg, self._slotConfig)
  temp:createChild()
  temp.icon:ComputePos()
  temp.count:ComputePos()
  self._ui.stc_Icon = temp
  PaGlobal_Atoraxion_MapSelecter:validate()
  PaGlobal_Atoraxion_MapSelecter:registEventHandler()
  PaGlobal_Atoraxion_MapSelecter:swichPlatform(self._isPadSnapping)
  PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize()
  self._leftTopDescOriginSpanX = self._ui.stc_LeftTop:GetSpanSize().x
  PaGlobal_Atoraxion_MapSelecter._initialize = true
end
function PaGlobal_Atoraxion_MapSelecter:registEventHandler()
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Atoraxion_MapSelecter_Close()")
  if _ContentsGroup_PersonalAtoraxion == true then
    self._ui.btn_Enter_Solo:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_Enter(true)")
    self._ui.btn_Enter_Party:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_Enter(false)")
  else
    self._ui.btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_Enter(false)")
  end
  self._ui.btn_Enter_Solo:SetShow(_ContentsGroup_PersonalAtoraxion == true)
  self._ui.btn_Enter_Party:SetShow(_ContentsGroup_PersonalAtoraxion == true)
  self._ui.btn_Enter:SetShow(_ContentsGroup_PersonalAtoraxion == false)
  self._ui.mapSelectBtn[self._eAtoraxionType.DESERT]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxion_Hadum .. ")")
  if _ContentsGroup_AtoraxionSea == true then
    self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxionSea_Hadum .. ")")
  end
  if _ContentsGroup_AtoraxionForest == true then
    self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxionValley_Hadum .. ")")
  end
  if _ContentsGroup_AtoraxionThorn == true then
    self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstanceAtoraxionThorn_Hadum .. ")")
  end
  if _ContentsGroup_AtoraxionIllezra == true then
    self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._rdoBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_Atoraxion_MapSelecter_MapSelect(" .. __eInstancePersonalAtoraxion_Illezra .. ")")
  end
  registerEvent("FromClient_InstanceContentsMapSelectOpen", "PaGlobalFunc_Atoraxion_MapSelecter_Open")
  registerEvent("onScreenResize", "PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize")
  Panel_Atoraxion_Select:RegisterShowEventFunc(true, "PaGlobal_Atoraxion_MapSelecter_ShowAni()")
end
function PaGlobal_Atoraxion_MapSelecter:swichPlatform(isConsole)
  self._ui.btn_Close:SetShow(not isConsole)
  self._ui.stc_KeyguideBG:SetShow(isConsole)
end
function PaGlobal_Atoraxion_MapSelecter:prepareOpen()
  self._initializeAnimation = false
  self._initializeScaleChange = false
  self._currentSelect = nil
  PaGlobal_Atoraxion_MapSelecter:initializeControlSetForAni(0)
  Panel_Atoraxion_Select:RegisterUpdateFunc("FromClient_Atoraxion_MapSelecter_PerframeEvent")
  for idx = self._eAtoraxionType.DESERT, self._eAtoraxionType.COUNT - 1 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:SetCheck(false)
      self._ui.mapSelectBtn[idx]._rdoBtn:SetIgnore(true)
    end
  end
  self._ui.showAni1:SetShow(false)
  self._ui.showAni2:SetShow(false)
  self._ui.showAni3:SetShow(false)
  self._ui.showAni4:SetShow(false)
  self._ui.showAni5:SetShow(false)
  self._ui.stc_Bg:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Atoraxion_BG_04.dds")
  x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Bg, 0, 0, 1920, 1080)
  self._ui.stc_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_Bg:setRenderTexture(self._ui.stc_Bg:getBaseTexture())
  self._ui.stc_Bg:ComputePos()
  self._ui.txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PARTYMATCHING_ATORAXXION_MATCH"))
  self._ui.multiline_Desc:SetShow(self._currentSelect ~= nil)
  self._ui.needSelectMap:SetShow(self._currentSelect == nil)
  self._ui.needSelectMap:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXION_ENTER_SELECT_MAP"))
  self._ui.stc_KeyguideBG:SetPosX(self._ui.btn_Enter_Solo:GetPosX() + self._ui.btn_Enter_Solo:GetSizeX())
  self._ui.btn_Enter_Party:ComputePos()
  PaGlobal_Atoraxion_MapSelecter:open()
end
function PaGlobal_Atoraxion_MapSelecter:open()
  Panel_Atoraxion_Select:SetShow(true, true)
end
function PaGlobal_Atoraxion_MapSelecter:prepareClose()
  Panel_Atoraxion_Select:ClearUpdateLuaFunc()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Atoraxion_MapSelecter:close()
end
function PaGlobal_Atoraxion_MapSelecter:close()
  Panel_Atoraxion_Select:SetShow(false)
end
function PaGlobal_Atoraxion_MapSelecter:initializeControlSetForAni(value)
  self._ui.txt_Title:SetFontAlpha(value)
  self._ui.needSelectMap:SetFontAlpha(value)
  self._ui.btn_Close:SetAlpha(value)
  self._ui.stc_Line:SetAlpha(value)
  self._ui.stc_Shadow:SetAlpha(value)
  self._ui.stc_LeftTop:SetAlpha(value)
  self._ui.stc_SlotBg:SetAlpha(value)
  self._ui.stc_Icon.icon:SetAlpha(value)
  self._ui.stc_Icon.count:SetFontAlpha(value)
  for idx = self._eAtoraxionType.DESERT, self._eAtoraxionType.COUNT - 1 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:SetAlpha(value)
      self._ui.mapSelectBtn[idx]._lock:SetAlpha(value)
    end
  end
  if _ContentsGroup_PersonalAtoraxion == true then
    self._ui.btn_Enter_Solo:SetAlpha(value)
    self._ui.btn_Enter_Party:SetAlpha(value)
  else
    self._ui.btn_Enter:SetAlpha(value)
  end
  if value <= 0 then
    self._ui.stc_Line:SetShow(false)
    self._ui.stc_Shadow:SetShow(false)
    self._ui.stc_LeftTop:SetShow(false)
    self._ui.txt_Title:SetShow(false)
    self._ui.needSelectMap:SetShow(false)
    self._ui.stc_SlotBg:SetShow(false)
    if _ContentsGroup_PersonalAtoraxion == true then
      self._ui.btn_Enter_Solo:SetShow(false)
      self._ui.btn_Enter_Party:SetShow(false)
    else
      self._ui.btn_Enter:SetShow(false)
    end
    if false == self._isPadSnapping then
      self._ui.btn_Close:SetShow(false)
    end
    self._ui.stc_LeftTop:SetSpanSize(self._leftTopDescOriginSpanX - self._ui.stc_LeftTop:GetSizeX(), self._ui.stc_LeftTop:GetSpanSize().y)
  end
end
function PaGlobalFunc_Atoraxion_MapSelecter_Open(type, mode)
  if true == Panel_Atoraxion_Select:GetShow() then
    return
  end
  if __eInstanceContentsType_AtoraxionBoss ~= type then
    return
  end
  PaGlobal_Atoraxion_MapSelecter:prepareOpen()
end
function PaGlobalFunc_Atoraxion_MapSelecter_OnScreenResize()
  Panel_Atoraxion_Select:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Atoraxion_MapSelecter._ui.stc_Bg:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Atoraxion_MapSelecter._ui.stc_controlBg:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Atoraxion_Select:ComputePosAllChild()
  PaGlobal_Atoraxion_MapSelecter._ui.stc_Bg:ComputePosAllChild()
  PaGlobal_Atoraxion_MapSelecter._ui.stc_controlBg:ComputePosAllChild()
  if true == PaGlobal_Atoraxion_MapSelecter._isPadSnapping then
    local tempTable = {
      PaGlobal_Atoraxion_MapSelecter._ui.stc_Keyguide_A,
      PaGlobal_Atoraxion_MapSelecter._ui.stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempTable, PaGlobal_Atoraxion_MapSelecter._ui.stc_KeyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_LEFT)
  end
end
function PaGlobalFunc_Atoraxion_MapSelecter_Close()
  PaGlobal_Atoraxion_MapSelecter:prepareClose()
end
function HandleEventOnOut_Atoraxion_MapSelecter_IconTooltip(show)
  if false == show or nil == show then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[self._currentSelect] then
    return
  end
  local mapData = self._mapData[self._currentSelect]
  local itemEnchantKey = ItemEnchantKey(mapData._itemKey, 0)
  if nil == itemEnchantKey then
    return
  end
  if false == itemEnchantKey:isDefined() then
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemWrapper then
    return
  end
  Panel_Tooltip_Item_Show(itemWrapper, self._ui.stc_Icon.icon, true, false, nil)
end
function HandleEventLUp_Atoraxion_MapSelecter_MapSelect(mapType)
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[mapType] then
    return
  end
  if self._initializeAnimation == false then
    return
  end
  local mapData = self._mapData[mapType]
  self._initializeScaleChange = false
  self._ui.stc_Icon:clearItem()
  self._ui.txt_Title:SetText(mapData._title)
  self._ui.multiline_Desc:SetShow(true)
  self._ui.multiline_Desc:SetText(mapData._desc)
  self._ui.needSelectMap:SetShow(false)
  self._ui.stc_Bg:ChangeTextureInfoNameAsync(mapData._bg)
  x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Bg, 0, 0, 1920, 1080)
  self._ui.stc_Bg:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_Bg:setRenderTexture(self._ui.stc_Bg:getBaseTexture())
  self._ui.stc_Bg:ComputePos()
  self._currentSelect = mapType
  if _ContentsGroup_PersonalAtoraxion == true then
    if self._personalContentsOption[self._currentSelect] == nil or self._personalContentsOption[self._currentSelect] == false then
      self._ui.btn_Enter_Solo:SetAlpha(1)
      self._ui.btn_Enter_Solo:SetShow(false)
    else
      self._ui.btn_Enter_Solo:SetShow(true)
    end
  end
  self._ui.btn_Enter_Party:ComputePos()
  if self._currentSelect == __eInstancePersonalAtoraxion_Illezra then
    self._ui.btn_Enter_Solo:SetShow(false)
    self._ui.btn_Enter_Party:SetPosX(self._ui.btn_Enter_Party:GetPosX() + 105)
  elseif self._currentSelect == __eInstanceAtoraxionThorn_Hadum then
    self._ui.btn_Enter_Solo:SetShow(false)
    self._ui.btn_Enter_Party:SetPosX(self._ui.btn_Enter_Party:GetPosX() + 105)
  elseif _ContentsGroup_PersonalAtoraxion == true then
    self._ui.btn_Enter_Solo:SetShow(true)
  end
  local aniInfo1 = self._ui.stc_Bg:addScaleAnimation(0, 20, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1.AxisX = 1
  aniInfo1.AxisY = 1
  aniInfo1.ScaleType = 0
  aniInfo1:SetStartScale(1)
  aniInfo1:SetEndScale(1.025)
end
function HandleEventLUp_Atoraxion_MapSelecter_Enter(isSolo)
  local self = PaGlobal_Atoraxion_MapSelecter
  if nil == self._mapData or nil == self._mapData[self._currentSelect] then
    PaGlobal_Atoraxion_MapSelecter_ShowColorAni()
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_TITLE"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ATORAXION_ENTER_SELECT_MAP"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if _ContentsGroup_PersonalAtoraxion == false then
    ToClient_InstanceContentNormalFieldEnter(__eInstanceContentsType_AtoraxionBoss, 0, self._currentSelect)
  else
    do
      local selectMapKey = self._currentSelect
      if isSolo == true then
        if self._personalContentsOption[selectMapKey] == nil or self._personalContentsOption[selectMapKey] == false then
          return
        end
        selectMapKey = self._personalMapKey[selectMapKey]
      end
      if selectMapKey == nil then
        return
      end
      local function funcEnter()
        if isSolo == true then
          local curChannelData = getCurrentChannelServerData()
          if curChannelData == nil then
            return
          end
          local mode = __ePersonalAtoraxionMode_Normal
          if curChannelData._isSeasonChannel == true then
            mode = __ePersonalAtoraxionMode_Season
          end
          ToClient_InstanceContentsJoin(__eInstanceContentsType_PersonalAtoraxion, mode, selectMapKey)
          PaGlobalFunc_Atoraxion_MapSelecter_Close()
          if Defines.UIMode.eUIMode_NpcDialog == GetUIMode() and HandleEventLUp_DialogMain_All_ExitClick ~= nil then
            HandleEventLUp_DialogMain_All_ExitClick()
          end
        else
          ToClient_InstanceContentNormalFieldEnter(__eInstanceContentsType_AtoraxionBoss, 0, selectMapKey)
        end
      end
      local msg = ""
      if isSolo == true then
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXXION_POPUP_ENTER_SOLO_DESC")
      elseif selectMapKey ~= __eInstancePersonalAtoraxion_Illezra then
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXXION_POPUP_ENTER_DEFAULT_DESC")
      else
        msg = PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXXION_POPUP_ENTER_DEFAULT_DESC2")
      end
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_MESSAGEBOX_TITLE"),
        content = msg,
        functionYes = funcEnter,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function FromClient_Atoraxion_MapSelecter_PerframeEvent(deltaTime)
  if false == Panel_Atoraxion_Select:GetShow() then
    return
  end
  local self = PaGlobal_Atoraxion_MapSelecter
  if false == self._initializeAnimation and nil ~= self._ui.mapSelectBtn then
    local value = 0.5 * deltaTime
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.DESERT]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._rdoBtn, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.DESERT]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.SEA]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.VALLEY]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.THORN]._lock, 2.5 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.mapSelectBtn[self._eAtoraxionType.ILLEZRA]._lock, 2.5 * deltaTime)
    if _ContentsGroup_PersonalAtoraxion == true then
      UIAni.perFrameAlphaAnimation(1, self._ui.btn_Enter_Solo, 2.8 * deltaTime)
      UIAni.perFrameAlphaAnimation(1, self._ui.btn_Enter_Party, 2.8 * deltaTime)
    else
      UIAni.perFrameAlphaAnimation(1, self._ui.btn_Enter, 2.8 * deltaTime)
    end
    if false == self._isPadSnapping then
      UIAni.perFrameAlphaAnimation(1, self._ui.btn_Close, 2.8 * deltaTime)
    end
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_Line, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_Shadow, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_LeftTop, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimation(1, self._ui.stc_SlotBg, 2.8 * deltaTime)
    UIAni.perFrameAlphaAnimationNotControlShow(1, self._ui.stc_Icon.icon, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.stc_Icon.count, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.txt_Title, 2.8 * deltaTime)
    UIAni.perFrameFontAlphaAnimation(1, self._ui.needSelectMap, 1.8 * deltaTime)
    local pos = self._ui.stc_LeftTop:GetSpanSize().x + 340 * deltaTime
    self._ui.stc_LeftTop:SetSpanSize(pos, self._ui.stc_LeftTop:GetSpanSize().y)
    if self._leftTopDescOriginSpanX <= self._ui.stc_LeftTop:GetSpanSize().x then
      self._initializeAnimation = true
      for idx = self._eAtoraxionType.DESERT, self._eAtoraxionType.COUNT - 1 do
        if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
          self._ui.mapSelectBtn[idx]._rdoBtn:SetIgnore(false)
        end
      end
    end
  end
end
function PaGlobal_Atoraxion_MapSelecter:validate()
  self._ui.stc_Bg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.multiline_Desc:isValidate()
  self._ui.needSelectMap:isValidate()
  self._ui.btn_Enter:isValidate()
  self._ui.btn_Enter_Solo:isValidate()
  self._ui.btn_Enter_Party:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.stc_Line:isValidate()
  self._ui.stc_Shadow:isValidate()
  self._ui.stc_LeftTop:isValidate()
  for idx = self._eAtoraxionType.DESERT, self._eAtoraxionType.COUNT - 1 do
    if nil ~= self._ui.mapSelectBtn and nil ~= self._ui.mapSelectBtn[idx] then
      self._ui.mapSelectBtn[idx]._rdoBtn:isValidate()
      self._ui.mapSelectBtn[idx]._lock:isValidate()
    end
  end
  self._ui.stc_KeyguideBG:isValidate()
  self._ui.stc_Keyguide_A:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
  self._ui.stc_Keyguide_X:isValidate()
end
function PaGlobal_Atoraxion_MapSelecter_ShowAni()
  Panel_Atoraxion_Select:ChangeSpecialTextureInfoName("new_ui_common_forlua/Default/Mask_Gradient_toBottom.dds")
  local FadeMaskAni = Panel_Atoraxion_Select:addTextureUVAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  FadeMaskAni:SetTextureType(CppEnums.PAUI_TEXTURE_TYPE.PAUI_TEXTURE_TYPE_MASK)
  FadeMaskAni:SetStartUV(0, 0.6, 0)
  FadeMaskAni:SetEndUV(0, 0.1, 0)
  FadeMaskAni:SetStartUV(1, 0.6, 1)
  FadeMaskAni:SetEndUV(1, 0.1, 1)
  FadeMaskAni:SetStartUV(0, 1, 2)
  FadeMaskAni:SetEndUV(0, 0.4, 2)
  FadeMaskAni:SetStartUV(1, 1, 3)
  FadeMaskAni:SetEndUV(0, 0.4, 3)
  local aniInfo3 = Panel_Atoraxion_Select:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
  local aniInfo8 = Panel_Atoraxion_Select:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo8:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo8:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo8:SetStartIntensity(3)
  aniInfo8:SetEndIntensity(1)
end
function PaGlobal_Atoraxion_MapSelecter_ShowColorAni()
  local self = PaGlobal_Atoraxion_MapSelecter
  self._ui.showAni1:SetShow(true)
  self._ui.showAni2:SetShow(true)
  self._ui.showAni3:SetShow(true)
  self._ui.showAni4:SetShow(true)
  self._ui.showAni5:SetShow(true)
  local aniInfo1 = self._ui.showAni1:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo1.IsChangeChild = false
  local aniInfo11 = self._ui.showAni1:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetHideAtEnd(true)
  local aniInfo2 = self._ui.showAni2:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo2.IsChangeChild = false
  local aniInfo22 = self._ui.showAni2:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo22:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo22:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo22:SetHideAtEnd(true)
  local aniInfo3 = self._ui.showAni3:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
  local aniInfo33 = self._ui.showAni3:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo33:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo33:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo33:SetHideAtEnd(true)
  local aniInfo4 = self._ui.showAni4:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo4.IsChangeChild = false
  local aniInfo44 = self._ui.showAni4:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo44:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo44:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo44:SetHideAtEnd(true)
  local aniInfo5 = self._ui.showAni5:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo5.IsChangeChild = false
  local aniInfo55 = self._ui.showAni5:addColorAnimation(0.5, 1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo55:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo55:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo55:SetHideAtEnd(true)
end
