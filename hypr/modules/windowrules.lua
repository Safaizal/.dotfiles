--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)www

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
-- hl.window_rule({
--     name  = "move-hyprland-run",
--     match = { class = "hyprland-run" },

--     move  = "20 monitor_h-120",
--     float = true,
-- })

hl.window_rule({
  match = {
    class = "floating_control"
  },
  float = true,
  size = { 700, 600 },
  move = { "(monitor_w - 720)", 50 }
})

hl.layer_rule({
  match = {
    namespace = "rofi",
  },
  animation = "slide top",
  dim_around = true,
  blur = true,
  ignore_alpha = 0.1
})

hl.layer_rule({
  name = "swaync",
  match = {
    namespace = "swaync-control-center"
  },
  animation = "slide bottom",
  dim_around = true,
})

hl.window_rule({
  match = { title = "^(Picture-in-Picture)" },
  float = true,
  move = { "monitor_w * 1 - 433", "monitor_h * 1 - 273" },
  size = { "426", "240" },
  no_initial_focus=true, suppress_event="maximize"
})
