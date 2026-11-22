# FFXI Addon — Autotarget

> [!NOTE]
> **Quick Reference**
> - **Path:** `C:\Windower\addons\Autotarget\`
> - **Author / Version:** Gimlic / v0.1
> - **Commands:** `//AutoTarget`, `//AT`
> - **Load Status:** On-Demand (unloaded)
> - **Origin:** Custom / Modified (written locally by Gimlic)

Custom target-cycling and auto-engage bot script that spams `Tab` until it targets an `Apex Toad`, then sends `/attack <t>`.

## What the Code Does
- `loop()` runs a `while running == true` coroutine loop: if `player.status == 1` (engaged), sleeps `0.5s`; otherwise calls `target1()`.
- `target1()` presses and releases `TAB` via `setkey`, sleeps `0.1s`, and checks `windower.ffxi.get_mob_by_target('t')`:
  - If `nil` or name is not `"Apex Toad"`, recursively calls `target1()` after `0.1s` (note: unbounded recursion if no Apex Toad is found).
  - If `target.name == "Apex Toad"`, prints `"AutoTarget: Found Depthswalker Crab"` (leftover message string), sleeps `0.5s`, inputs `/attack <t>`, and sleeps `2s`.
- Contains an unused/commented-out `AssistParty()` function (with an uninterpolated literal string `'/assist ..party[i].name..'`), and an unhandled `ki` command calling undefined `Check_KI()` (from a template/harvesting script).
- `stop` and `abort` force `lua reload AutoTarget` to break out of the blocking `while`/`target1` loop.

## Commands & Usage
- `//at start` — Sets `running = true` and enters `loop()`.
- `//at stop` / `//at abort` — Reloads the addon (`lua reload AutoTarget`) to halt execution.
- `//at help` — Prints command list.

## Events, Packets & Technical Hooks
- **Windower Events:** `addon command`
- **Packets:** None — uses `setkey TAB` and `windower.chat.input('/attack <t>')`.
- **Dependencies / Libraries:** `logger`, `coroutine`

## Local Settings & Customizations
- No `data/settings.xml`; target name (`"Apex Toad"`) is hardcoded directly in `Autotarget.lua`.

## Related Notes
- `FFXI Windower Overview`
- `FFXI Windower Addons Catalog`
