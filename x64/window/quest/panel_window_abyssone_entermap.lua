PaGlobal_AbyssOne_EnterMap = {
  _ui = {
    _btn_City = {},
    _btn_Close = nil,
    _txt_money = nil,
    _txt_CityName = nil,
    _txt_CityDesc = nil,
    _btn_moveToMagnus = nil,
    _stc_KeyGuide = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil
  },
  _contentsOptionKey = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    27
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromCliet_AbyssOne_EnterMap_Init")
function FromCliet_AbyssOne_EnterMap_Init()
  PaGlobal_AbyssOne_EnterMap:initialize()
end
function PaGlobal_AbyssOne_EnterMap:initialize()
  if Panel_Window_AbyssOne_EnterMap == nil then
    return
  end
  for i, v in ipairs(self._contentsOptionKey) do
    local toStringValue = tostring(v)
    if ToClient_IsContentsGroupOpen(toStringValue) == true then
      local tempBtn = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "CheckButton_" .. toStringValue)
      if tempBtn ~= nil then
        self._ui._btn_City[v] = tempBtn
        self._ui._btn_City[v]:SetShow(true)
        self._ui._btn_City[v]:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_EnterMap_Select(" .. toStringValue .. ")")
      end
    end
  end
  local title = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(title, "Button_Close")
  self._ui._stc_KeyGuide = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui._txt_money = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "Button_Money")
  self._ui._btn_moveToMagnus = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "Button_Cancel")
  local desc = UI.getChildControl(Panel_Window_AbyssOne_EnterMap, "Static_DialogBox")
  self._ui._txt_CityName = UI.getChildControl(desc, "StaticText_NPCName")
  self._ui._txt_CityDesc = UI.getChildControl(desc, "StaticText_Dialog")
  PaGlobal_AbyssOne_EnterMap:registerEvent()
  self._initialize = true
end
function PaGlobal_AbyssOne_EnterMap:registerEvent()
  registerEvent("onScreenResize", "FromClient_AbyssOne_EnterMap_Resize")
end
function PaGlobal_AbyssOne_EnterMap:prepareClose()
  PaGlobal_AbyssOne_EnterMap:close()
end
function PaGlobal_AbyssOne_EnterMap:close()
  Panel_Window_AbyssOne_EnterMap:SetShow(false)
end
function PaGlobal_AbyssOne_EnterMap:prepareOpen()
  PaGlobal_AbyssOne_EnterMap:open()
end
function PaGlobal_AbyssOne_EnterMap:open()
  Panel_Window_AbyssOne_EnterMap:SetShow(true)
end
function HandleEventLUp_AbyssOne_EnterMap_Open()
  PaGlobal_AbyssOne_EnterMap:prepareOpen()
end
function HandleEventLUp_AbyssOne_EnterMap_Close()
  PaGlobal_AbyssOne_EnterMap:prepareClose()
end
function HandleEventLUp_AbyssOne_EnterMap_Select(key)
end
function HandleEventLUp_AbyssOne_EnterMap_Cancel()
end
function FromClient_AbyssOne_EnterMap_Resize()
  Panel_Window_AbyssOne_EnterMap:ComputePos()
end
