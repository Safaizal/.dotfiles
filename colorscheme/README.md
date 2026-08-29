# amanojaku

`amanojaku` is a dark colorscheme based on the palette in `../starship.toml`, extended with the status colors used by the Lualine theme.
It uses a black-to-white neutral ramp, terminal green for emphasis, and restrained semantic accents for status states.

## Files

- `palette.json` is the canonical, complete theme definition.
- `amanojaku.css`, `amanojaku.lua`, and `amanojaku.toml` are import-ready exports.

## Palette

| Token | Hex | Intended use |
| --- | --- | --- |
| `black` | `#000000` | Base background |
| `gray_1` | `#333333` | Raised surfaces |
| `gray_2` | `#555555` | Borders and inactive UI |
| `gray_3` | `#777777` | Muted text |
| `gray_4` | `#999999` | Subtle foregrounds and selections |
| `white` | `#ffffff` | Primary foreground |
| `green` | `#00ff11` | Accent, success, focus |
| `red` | `#ff0000` | Errors and destructive states |
| `white_1` | `#aaaaaa` | Soft white |
| `lualine_red` | `#aa1100` | Error status |
| `lualine_green` | `#11aa00` | Success status |
| `lualine_blue` | `#1100aa` | Information status |
| `lualine_yellow` | `#ffcc00` | Warning status |

The Matugen custom-color tokens use the same names and values, allowing generated templates to consume this palette without changing any application configuration.
