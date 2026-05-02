# j0k3r-pomade

A free, open-source **Hair Pomade script for RedM** built on top of
**VORP Inventory**. The player uses a pomade item from the inventory,
the character plays the in-game pomade interaction — animation, jar
prop and hat handling are all driven by the game's own native — and
the hair material is then flipped to the slick / wet pomaded look you
know from RDR2 Online.

> **Author:** J0K3R-Scripts
> **Discord:** <https://discord.gg/DH8tW6vSxV>

---

## 🙏 Credits

This script is a friendly fork & rework of **[xakra_pomade](https://github.com/XakraD/xakra_pomade)**
by **[XakraD](https://github.com/XakraD)**. All the core RDR2 native
discoveries that make the pomade actually *work* — the
`APPLY_POMADE_WITH_HAT` / `APPLY_POMADE_WITH_NO_HAT` interaction
hashes, the `_UPDATE_SHOP_ITEM_WEARABLE_STATE` call, the helper
functions for finding the player's current hair component — were
shared by the **CFX.re community** and packaged together in
xakra_pomade. Without that work this script would not exist.

A huge thank you to:

- **XakraD** — for releasing `xakra_pomade` for free and being the
  reference implementation we built on top of.
  ➡ <https://github.com/XakraD/xakra_pomade>
- **gottfriedleibniz** — for the
  [DataView library](https://gist.github.com/gottfriedleibniz/8ff6e4f38f97dd43354a60f8494eedff)
  that the hair-component helpers depend on.
- **The CFX.re RedM community** — for figuring out the underlying
  natives in the first place.

What `j0k3r-pomade` adds on top of xakra_pomade:

- Optional Discord webhook logging
- Multi-language support (EN / DE / ES / FR)
- Confirmation notification after applying pomade
- `/pomadetest` debug command
- Verbose debug mode toggle
- Multi-item support out of the box (register as many pomade
  variants as you want with one config entry per item)

If you only want the bare minimum, please go and use
[xakra_pomade](https://github.com/XakraD/xakra_pomade) directly —
it is the original.

---

## ✨ Features

- **In-game native interaction** using
  `APPLY_POMADE_WITH_HAT` / `APPLY_POMADE_WITH_NO_HAT`, so the
  animation, the jar prop and the hat removal all come from RDR2
  itself. Looks identical to singleplayer.
- **Real visual hair change** — flips the current hair component to
  the `POMADE` wearable state.
- **VORP Inventory** — registers as many pomade variants as you want
  as usable items.
- **Discord webhook** logging (optional).
- **Multi-language** — English, German, Spanish, French.
- **Debug mode** — flip `Config.Debug = true` for verbose logs.
- **`/pomadetest` command** — verify the client side independently
  of the inventory hook.

---

## 📦 Requirements

| Resource         | Why                                          |
| ---------------- | -------------------------------------------- |
| `vorp_core`      | Notifications.                               |
| `vorp_inventory` | Item registration, item subtraction.         |

---

## 🚀 Installation

1. **Drop the folder** into your server, e.g.
   `resources/[scripts]/J0K3R-pomade`.

2. **Add the item to your database.** Open `install.sql` and run it
   against the same MySQL database that `vorp_inventory` uses.

   > ⚠️ **Heads up:** the default `Config.PomadeItems` entry is
   > `j0k3r_pomade`. Make sure the `item` column in your `items`
   > table uses the exact same name. If you'd rather keep the
   > shorter classic name `pomade`, change the entry in
   > `config.lua` to match.

3. **Add the icon.** Drop a `pomade.png` (or whatever you named the
   item) into:

   ```
   vorp_inventory/html/img/items/j0k3r_pomade.png
   ```

4. **Add to your `server.cfg`** in this exact order:

   ```cfg
   ensure vorp_core
   ensure vorp_inventory
   ensure J0K3R-pomade
   ```

5. **Restart** the server. The console should show:

   ```
   [j0k3r-pomade] Registered usable item: j0k3r_pomade
   ```

---

## ⚙️ Configuration

Open `config.lua`. The settings are intentionally minimal because
the game does most of the work natively:

| Key                  | Description                                  |
| -------------------- | -------------------------------------------- |
| `Config.PomadeItems` | Item names that trigger the pomade flow.     |
| `Config.Locale`      | `'en'`, `'de'`, `'es'`, `'fr'`.              |
| `Config.Debug`       | Verbose console output.                      |
| `Config.Webhook`     | Discord logging block (off by default).      |

### Adding a new language

Inside `Config.Locales`, copy any existing block, change the language
code and translate the strings:

```lua
['it'] = {
    title   = 'Pomata per Capelli',
    success = 'I tuoi capelli sono ora lisci e ordinati.',
},
```

Then set `Config.Locale = 'it'`.

### Adding more pomade variants

Add as many item names as you want to `Config.PomadeItems`:

```lua
Config.PomadeItems = {
    'j0k3r_pomade',
    'pomade_premium',
    'pomade_lavender',
}
```

Each one must also exist as a row in your `items` table with
`usable = 1`.

---

## 🐛 Troubleshooting

### "Nothing happens when I use the item"

1. **Did `Registered usable item: ...` print on server start?**
   - **No** → make sure `ensure J0K3R-pomade` comes AFTER
     `ensure vorp_inventory` in `server.cfg`.
2. **Is the item in the database?** Run:
   ```sql
   SELECT * FROM items WHERE item = 'j0k3r_pomade';
   ```
   The row must exist AND `usable` must be `1`.
3. **Is the item name in the DB exactly the same as in
   `Config.PomadeItems`?** The names are case-sensitive.
4. **Try `/pomadetest` in the F8 console.**
   If the animation plays but using the item from the inventory
   doesn't, the bug is in the inventory hook (DB row missing or
   wrong `usable` flag).

### "Animation plays but the hair doesn't change"

That's a sign the `_UPDATE_SHOP_ITEM_WEARABLE_STATE` native didn't
find the player's current hair component. This can happen on
heavily-modded ped builds where the hair component category isn't
named `hair`. Drop into the Discord and we can sort it out.

### "I see Lua errors mentioning `DataView`"

The DataView library at the bottom of `client.lua` requires
`lua54 'on'` in `fxmanifest.lua` — make sure it's there.

---

## 🔒 Security model

- The pomade item is registered server-side. The server is what
  triggers the client interaction; the client cannot fake the use
  on its own.
- The item is removed server-side **before** the animation plays —
  this matches xakra_pomade's original behaviour and prevents
  duplicate-click exploits.

---



---

freely, but please keep the credits to **XakraD**, **J0K3R-Scripts**,
and the **CFX.re community** intact.
