PaGlobal_OldMoonSmelting = {
  _ui = {
    _stc_titleArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_TitleBarArea"),
    _btn_closeButton = nil,
    _stc_leftTopArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_LeftTopImageArea"),
    _stc_smeltAreaBg = nil,
    _stc_smeltableItemSlot = nil,
    _stc_materialItemSlot = nil,
    _stc_smeltingEffect = nil,
    _prg_smeltingProgressBar = nil,
    _txt_smeltingProgressText = nil,
    _stc_leftBottomButtonArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_LeftBottomButtonArea"),
    _ckb_skipAnimationButton = nil,
    _btn_smeltingButton = nil,
    _btn_keyGuide_Y = nil,
    _stc_leftBottomDescArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_LeftBottomDescArea"),
    _txt_smeltingDesc = nil,
    _stc_rightArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_RightArea"),
    _lst_smeltableItemList = nil,
    _stc_notExistItem = nil,
    _stc_rightBottomArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_RightBottomArea"),
    _btn_useMaterialItemButton = nil,
    _stc_materialItemIcon = nil,
    _txt_materialItemCount = nil,
    _stc_consoleKeyguidArea = UI.getChildControl(Panel_Window_OldMoonSmelting, "Static_BottomKeyguidesArea"),
    _btn_keyGuide_A = nil,
    _btn_keyGuide_B = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _materialSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _listInfo = {_slotNoList = nil, _equipedSlotNoEnd = -1},
  _smeltingSlotInfo = {
    _targetItemSlot = nil,
    _targetItemSlotNoIndex = -1,
    _materialItemSlot = nil,
    _s64_materialItemCount = toInt64(0, 0)
  },
  _animation_accTime = 0,
  _animation_maxTime = 3,
  _isPlayingSmeltingAnimation = false,
  _currentSelectedSlotNoIndex = -1,
  _isConsole = false,
  _isPadMode = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/OldMoon/Panel_Window_OldMoonSmelting_1.lua")
runLua("UI_Data/Script/Window/OldMoon/Panel_Window_OldMoonSmelting_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ContentsNameInit")
function FromClient_ContentsNameInit()
  PaGlobal_OldMoonSmelting:initialize()
end
