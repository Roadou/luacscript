PaGlobal_ServantSummonBoss = {
  _eStack = {
    non = 0,
    stack1 = 1,
    stack2 = 2,
    stack3 = 3,
    loopCount = 3
  },
  _ui = {
    _stc_progressBG = nil,
    _stc_progressBar = nil,
    _stc_commandBG = nil,
    _stc_moveTitle = nil,
    _stc_attackTitle = nil,
    _stc_actionTitle = nil,
    _moveList = {},
    _attackList = {},
    _actionList = {},
    _txt_hp = nil,
    _stc_stackGroup_crio = nil,
    _stc_stackIcon_crio = {},
    _stc_stackGroup_papu = nil,
    _stc_stackIcon_papu = {}
  },
  _bossInfo = {
    [1] = {
      _actorkey = 29880,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMPBASIC"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_STOMACH")
      },
      _actionText = {}
    },
    [2] = {
      _actorkey = 29800,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMPBASIC"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_STOMACH")
      },
      _actionText = {}
    },
    [3] = {
      _actorkey = 29805,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_PROMPTLY"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      },
      _actionText = {}
    },
    [4] = {
      _actorkey = 29806,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASEATTACK")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DOWNWARD"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_TAPPING_FOOT"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      },
      _actionText = {}
    },
    [5] = {
      _actorkey = 29819,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [6] = {
      _actorkey = 26041,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [7] = {
      _actorkey = 26042,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [8] = {
      _actorkey = 29811,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [9] = {
      _actorkey = 29812,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICIAN_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [10] = {
      _actorkey = 26043,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [11] = {
      _actorkey = 29820,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [12] = {
      _actorkey = 26044,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [13] = {
      _actorkey = 26045,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [14] = {
      _actorkey = 29817,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_PRIEST_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [15] = {
      _actorkey = 26046,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [16] = {
      _actorkey = 29818,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_FIGHTER_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_FIGHTER_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_MAGICSWORD_ATTACK_3"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [17] = {
      _actorkey = 29951,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FOOT"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_PROMPTLY"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      },
      _actionText = {}
    },
    [18] = {
      _actorkey = 29952,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASEATTACK")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DOWNWARD"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RUN"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_TAPPING_FOOT"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_ROAR")
      },
      _actionText = {}
    },
    [19] = {
      _actorkey = 29901,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE2")
      },
      _attackText = {},
      _actionText = {}
    },
    [20] = {
      _actorkey = 29912,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_HIDE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_DIE"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [21] = {
      _actorkey = 29914,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_HIDE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_DIE"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [22] = {
      _actorkey = 29830,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FASTMOVE")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_FLYATTCK")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_FLYSTART"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_FLYEND"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_FLYUP"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_FLYDOWN"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      }
    },
    [23] = {
      _actorkey = 29831,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FASTMOVE")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RIGHTROUND"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_SHOULDER"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_JUMPBASIC"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_RANGED"),
        [6] = " ",
        [7] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [24] = {
      _actorkey = 29928,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_JUMP3"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_CUTE"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ACTION_NORMALHIDE"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [25] = {
      _actorkey = 29364,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FASTMOVE")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK2")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      }
    },
    [26] = {
      _actorkey = 29834,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [27] = {
      _actorkey = 29905,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [28] = {
      _actorkey = 29906,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [29] = {
      _actorkey = 29907,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [30] = {
      _actorkey = 29908,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [31] = {
      _actorkey = 29909,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK1") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_MOUSE_ATTACK2") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_PAPU_CITIZEN_MOTION_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_KEYBOARD_KICK") .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_CRIO_CITIZEN_MOTION_3"),
        [4] = " ",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [32] = {
      _actorkey = 28929,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [33] = {
      _actorkey = 28930,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [34] = {
      _actorkey = 28931,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [35] = {
      _actorkey = 28932,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [36] = {
      _actorkey = 28933,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [37] = {
      _actorkey = 28934,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [38] = {
      _actorkey = 28966,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_KEYBIND_Q")
      },
      _isHideServantHP = true
    },
    [39] = {
      _actorkey = 28968,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_KEYBIND_UG_Q"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _isHideServantHP = true
    },
    [40] = {
      _actorkey = 28969,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK1_UG"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK2_UG")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK_UG1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _isHideServantHP = true
    },
    [41] = {
      _actorkey = 22545,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK1_UG"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK2_UG")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK_UG2"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _isHideServantHP = true
    },
    [42] = {
      _actorkey = 22546,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK1_UG"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK2_UG")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_COMMAND_ATTACK_UG3"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _isHideServantHP = true
    },
    [43] = {
      _actorkey = 26037,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [44] = {
      _actorkey = 26038,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_DESC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_4"),
        [5] = " ",
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _actionText = {}
    },
    [45] = {
      _actorkey = 26030,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [46] = {
      _actorkey = 26031,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [47] = {
      _actorkey = 26032,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [48] = {
      _actorkey = 26033,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [49] = {
      _actorkey = 26034,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [50] = {
      _actorkey = 26035,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3")
      },
      _actionText = {}
    },
    [51] = {
      _actorkey = 26024,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [52] = {
      _actorkey = 26025,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [53] = {
      _actorkey = 26026,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [54] = {
      _actorkey = 26027,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [55] = {
      _actorkey = 26028,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [56] = {
      _actorkey = 26029,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_TERMIAN_ATTACK_3"),
        [4] = "",
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_GETOFF")
      },
      _actionText = {}
    },
    [57] = {
      _actorkey = 26018,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_BASIC_MOVE")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26018_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26018_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26018_DASH"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26018_DASH_ING")
      },
      _actionText = {}
    },
    [58] = {
      _actorkey = 26019,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_BASIC_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26019_JUMP")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26019_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26019_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26019_ATTACK_3"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26019_ATTACK_4")
      },
      _actionText = {}
    },
    [59] = {
      _actorkey = 26020,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_BASIC_MOVE")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26020_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26020_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26020_ATTACK_3"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26020_ATTACK_4")
      },
      _actionText = {}
    },
    [60] = {
      _actorkey = 26021,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_BASIC_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26021_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26021_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26021_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26021_ATTACK_3"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26021_ATTACK_4")
      },
      _actionText = {}
    },
    [61] = {
      _actorkey = 26022,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_BASIC_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26022_DASH")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26022_ATTACK_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26022_ATTACK_2"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26022_ATTACK_3"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_YORU_26022_ATTACK_4")
      },
      _actionText = {}
    },
    [62] = {
      _actorkey = 27778,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_SOCIALACTION"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [63] = {
      _actorkey = 27779,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_SOCIALACTION"),
        [2] = " ",
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [64] = {
      _actorkey = 27781,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_WALKING"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_RUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_BALLOON"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK1"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [65] = {
      _actorkey = 27782,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_WALKING")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_DASH")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_HIDELIVER"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ESCAPE"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_WIDERANGEATTACK"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_RABBIT_QUEST")
      }
    },
    [66] = {
      _actorkey = 27783,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_WALKING")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONT_DASH"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_TURTLE_QUEST")
      },
      _actionText = {}
    },
    [67] = {
      _actorkey = 27794,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTRUN"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_AUTORUN")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_HALLOWEEN_KEYBIND_UG_Q"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      },
      _isHideServantHP = true
    },
    [68] = {
      _actorkey = 25472,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_SLOW"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTFAST")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_HIDDENATTACK")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_SOCIALACTION"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [69] = {
      _actorkey = 25428,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_BASIC"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_SLOW"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOVE_FRONTFAST")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_ATTACK_BASIC_LEFT"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_HIDDENATTACK")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_SOCIALACTION"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_RELEASE")
      }
    },
    [70] = {
      _actorkey = 31622,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_DIR"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_SPRINT"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_HEIGHT_CONTROL_2"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_HEIGHT_CONTROL_1")
      },
      _attackText = {},
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_RIDE_OFF")
      }
    },
    [71] = {
      _actorkey = 31125,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_DIR"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_SPRINT"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_HEIGHT_CONTROL_2"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_HEIGHT_CONTROL_1")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_FIREBALL"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_FEAR"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_MOVE_BREATH")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_DRAGON_COMMAND_RIDE_OFF")
      },
      _isHideServantHP = true
    },
    [72] = {
      _actorkey = 31629,
      _moveText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_MOVE"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_MOVE_DIR"),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_MOVE_SPRINT"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_HEIGHT_CONTROL_2"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_HEIGHT_CONTROL_1")
      },
      _attackText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_FIREBALL"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_MOVE_FEAR")
      },
      _actionText = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_FLY"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GRIFFON_COMMAND_RIDE_OFF")
      },
      _isHideServantHP = true
    }
  },
  _motionTitleMonsterKey = {
    [1] = 29819,
    [2] = 29820,
    [3] = 29834,
    [4] = 29905,
    [5] = 29906,
    [6] = 29907,
    [7] = 29908,
    [8] = 29909
  },
  _flyTitleMonsterKey = {
    [1] = 29830
  },
  _MAX_MOVE_COUNT = 5,
  _MAX_ATTACK_COUNT = 10,
  _MAX_ACTION_COUNT = 10,
  _attackTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSUMMONBOSS_COMMAND_ATTACK_TITLE"),
  _motionTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_MOTION_TITLE"),
  _actionTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSUMMONBOSS_COMMAND_ACTION_TITLE"),
  _flyTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_COMMAND_FLY_TITLE"),
  _crio_disable = {
    x1 = 103,
    y1 = 60,
    x2 = 130,
    y2 = 87
  },
  _crio_active = {
    x1 = 131,
    y1 = 60,
    x2 = 158,
    y2 = 87
  },
  _papu_disable = {
    x1 = 47,
    y1 = 60,
    x2 = 74,
    y2 = 87
  },
  _papu_active = {
    x1 = 75,
    y1 = 60,
    x2 = 102,
    y2 = 87
  },
  _isShowSkillCommand = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_ServantSummonBossInit")
function FromClient_PaGlobal_ServantSummonBossInit()
  PaGlobal_ServantSummonBoss:initialize()
end
