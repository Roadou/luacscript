PaGlobal_Contetns_Guide = {
  _ui = {
    btn_Close = nil,
    stc_Keyguide_B = nil,
    stc_guide = nil,
    stc_desc = nil,
    stc_title = nil,
    stc_line = nil,
    stc_multiline = nil
  },
  _guideUi = {
    [1] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_01.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1897,
      y2 = 1055,
      pos = 1
    },
    [2] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_02.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080,
      pos = 1
    },
    [3] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_03.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080,
      pos = 1
    },
    [4] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_04.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1896,
      y2 = 1057,
      pos = 0
    },
    [5] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_05.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1910,
      y2 = 1076,
      pos = 1
    },
    [6] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_06.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1897,
      y2 = 1055,
      pos = 0
    },
    [7] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_07.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1897,
      y2 = 1055,
      pos = 0
    },
    [8] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_09.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080,
      pos = 1
    },
    [9] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_10.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080,
      pos = 2
    },
    [10] = {
      texture = "combine/etc/combine_etc_atoraxion_guide_bg_11.dds",
      x1 = 0,
      y1 = 0,
      x2 = 1920,
      y2 = 1080,
      pos = 1
    }
  },
  _guideTitleText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_8"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_9"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_TITLE_10")
  },
  _guideDescText = {
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_1"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_2"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_3"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_4"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_5"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_6"),
    [7] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_7"),
    [8] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_8"),
    [9] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_9"),
    [10] = PAGetString(Defines.StringSheet_GAME, "LUA_CONTENTS_GUIDE_DESC_10")
  },
  _originalPosY = 0,
  _contentsType = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Contents_Guide_Init")
function FromClient_Contents_Guide_Init()
  PaGlobal_Contetns_Guide:initialize()
end
function PaGlobal_Contetns_Guide:initialize()
  if true == PaGlobal_Contetns_Guide._initialize then
    return
  end
  local self = PaGlobal_Contetns_Guide
  if nil == Panel_Window_Guide_All then
    return
  end
  self._ui.stc_guide = UI.getChildControl(Panel_Window_Guide_All, "Static_Guide_0_0")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_Guide_All, "Button_Close")
  self._ui.stc_Keyguide_B = UI.getChildControl(Panel_Window_Guide_All, "StaticText_B_ConsoleUI")
  self._ui.stc_desc = UI.getChildControl(self._ui.stc_guide, "Static_Desc")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_desc, "StaticText_TItle")
  self._ui.stc_line = UI.getChildControl(self._ui.stc_desc, "Static_Line")
  self._ui.stc_multiline = UI.getChildControl(self._ui.stc_desc, "MultilineText_1")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_Keyguide_B:SetShow(self._isConsole)
  self._ui.btn_Close:SetShow(not self._isConsole)
  PaGlobal_Contetns_Guide:validate()
  PaGlobal_Contetns_Guide:registEventHandler()
  PaGlobalFunc_Contents_Guide_OnScreenResize()
  PaGlobal_Contetns_Guide._originalPosY = self._ui.stc_desc:GetPosY()
  PaGlobal_Contetns_Guide._initialize = true
end
function PaGlobal_Contetns_Guide:registEventHandler()
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Contents_Guide_Close()")
  registerEvent("FromClient_InstanceContentsGuideOpen", "PaGlobalFunc_Contents_Guide_Open")
  registerEvent("onScreenResize", "PaGlobalFunc_Contents_Guide_OnScreenResize")
  if true == self._isConsole then
    Panel_Window_Guide_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_Contents_Guide_Close()")
  end
end
function PaGlobal_Contetns_Guide:prepareOpen()
  local self = PaGlobal_Contetns_Guide
  if self._contentsType == 0 then
    return
  end
  local contentsType = self._contentsType
  local control = self._ui.stc_guide
  if self._guideUi[contentsType] == nil then
    return
  end
  PaGlobalFunc_DialogMain_All_Close()
  control:ChangeTextureInfoNameAsync(self._guideUi[contentsType].texture)
  local x1, y1, x2, y2 = setTextureUV_Func(control, self._guideUi[contentsType].x1, self._guideUi[contentsType].y1, self._guideUi[contentsType].x2, self._guideUi[contentsType].y2)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  self._ui.stc_title:SetShow(false)
  self._ui.stc_desc:SetShow(false)
  self._ui.stc_line:SetShow(false)
  self._ui.stc_multiline:SetShow(false)
  local title = self._ui.stc_title
  local desc = self._ui.stc_desc
  local line = self._ui.stc_line
  local multiline = self._ui.stc_multiline
  title:SetText(self._guideTitleText[contentsType])
  multiline:SetText(self._guideDescText[contentsType])
  title:SetShow(true)
  desc:SetShow(true)
  line:SetShow(true)
  multiline:SetShow(true)
  if 160 < multiline:GetTextSizeY() then
    multiline:SetSpanSize(0, 80)
  elseif multiline:GetTextSizeY() > 130 then
    multiline:SetSpanSize(0, 60)
  elseif multiline:GetTextSizeY() > 100 then
    multiline:SetSpanSize(0, 40)
  else
    multiline:SetSpanSize(0, 20)
  end
  if self._guideUi[contentsType].pos == 0 then
    local totalSize = title:GetSizeY() + line:GetSizeY() + multiline:GetTextSizeY()
    if totalSize > getScreenSizeY() - getScreenSizeY() * 0.5 then
      self._ui.stc_desc:SetPosY(getScreenSizeY() - (totalSize + 30))
    else
      self._ui.stc_desc:SetPosY(getScreenSizeY() * 0.5)
    end
  elseif self._guideUi[contentsType].pos == 2 then
    self._ui.stc_desc:SetPosY(getScreenSizeY() * 0.2)
  else
    self._ui.stc_desc:SetPosY(self._originalPosY)
  end
  self._ui.stc_guide:SetShow(true)
  PaGlobal_Contetns_Guide:open()
end
function PaGlobal_Contetns_Guide:open()
  Panel_Window_Guide_All:SetShow(true, true)
end
function PaGlobal_Contetns_Guide:prepareClose()
  self._contentsType = 0
  PaGlobal_Contetns_Guide:close()
end
function PaGlobal_Contetns_Guide:close()
  Panel_Window_Guide_All:SetShow(false)
end
function PaGlobalFunc_Contents_Guide_Open(contentsType)
  if true == Panel_Window_Guide_All:GetShow() then
    return
  end
  PaGlobal_Contetns_Guide._contentsType = contentsType
  PaGlobal_Contetns_Guide:prepareOpen()
end
function PaGlobalFunc_Contents_Guide_OnScreenResize()
  Panel_Window_Guide_All:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Contetns_Guide._ui.stc_guide:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Contetns_Guide._ui.stc_guide:ComputePosAllChild()
  Panel_Window_Guide_All:ComputePosAllChild()
end
function PaGlobalFunc_Contents_Guide_Close()
  PaGlobal_Contetns_Guide:prepareClose()
end
function PaGlobal_Contetns_Guide:validate()
  local self = PaGlobal_Contetns_Guide
  self._ui.btn_Close:isValidate()
  self._ui.stc_Keyguide_B:isValidate()
  self._ui.stc_guide:isValidate()
  self._ui.stc_title:isValidate()
  self._ui.stc_desc:isValidate()
  self._ui.stc_multiline:isValidate()
end
