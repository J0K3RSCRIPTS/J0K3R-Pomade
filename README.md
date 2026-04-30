# j0k3r-pomade

A free, open-source **Hair Pomade script for RedM** built on top of
**VORP Inventory**. The player uses a `pomade` item, the character
plays the in-game pomade interaction (animation, jar prop, hat
removal — all handled by the game's own native), and the hair
material is flipped to the slick / wet pomaded look you see in
RDR2 Online.

> Author : **J0K3R-Scripts**
> Discord: **<https://discord.gg/DH8tW6vSxV>**
> License: GPL-3.0

---

## ✨ Features

- **In-game native interaction** — uses
  `APPLY_POMADE_WITH_HAT` / `APPLY_POMADE_WITH_NO_HAT` so the
  animation, the jar prop and the hat removal all come from RDR2
  itself. Looks identical to singleplayer.
- **Real visual hair change** — flips the current hair component
  to the `POMADE` wearable state, so the hair actually becomes slick.
- **VORP Inventory** — registers as many pomade variants as you
  want as usable items.
- **Discord webhook** logging (optional).
- **Multi-language** — English, German, Spanish, French.
- **Debug mode** — flip `Config.Debug = true` for verbose logs.
- **`/pomadetest` command** — verify the client side independently.

---

## 📦 Requirements

| Resource         | Why                                          |
| ---------------- | -------------------------------------------- |
| `vorp_core`      | Notifications.                               |
| `vorp_inventory` | Item registration, item subtraction.         |

---

## 🚀 Installation

1. **Drop the folder** into your server, e.g.
   `resources/[scripts]/j0k3r-pomade`.

2. **Run `install.sql`** against your VORP database. It creates the
   `pomade` item.

3. **Add the icon.** A `pomade.png` is included in the `img/` folder
   — copy it to:

   ```
   vorp_inventory/html/img/items/pomade.png
   ```

4. **Add to your `server.cfg`** *in this exact order*:

   ```cfg
   ensure vorp_core
   ensure vorp_inventory
   ensure j0k3r-pomade
   ```

5. **Restart** the server. The console should show:

   ```
   [j0k3r-pomade] Registered usable item: pomade
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
| `Config.Webhook`     | Discord logging block.                       |

---

## 🐛 Troubleshooting

### "Nothing happens when I use the item"

1. **Did `Registered usable item: pomade` print on server start?**
   - **No** → check that `ensure j0k3r-pomade` comes AFTER
     `ensure vorp_inventory` in `server.cfg`.
2. **Is the item in the database?**
   - Run: `SELECT * FROM items WHERE item = 'pomade';`
   - The row must exist AND `usable = 1`.
3. **Try `/pomadetest` in the F8 console.**
   - If the animation plays → the bug is in the inventory hook
     (DB row missing or wrong `usable` flag).

### "Animation plays but the hair doesn't change"

That's a sign the `_UPDATE_SHOP_ITEM_WEARABLE_STATE` native didn't
find your current hair component. This can happen on heavily-modded
ped builds where the hair component category isn't named `hair`.
Open an issue on Discord and we'll figure it out.

---

## 🔒 Security model

- The pomade item is registered server-side. The server is what
  triggers the client interaction; the client cannot fake the use
  on its own.
- The item is removed server-side **before** the animation plays —
  this matches  and prevents duplicate-click
  exploits.

---

## 📝 Credits

- The DataView library used by those helpers is by
  **gottfriedleibniz**
  ([gist](https://gist.github.com/gottfriedleibniz/8ff6e4f38f97dd43354a60f8494eedff)).
- VORP integration, multi-language support, Discord webhook,
  cleanup and packaging by **J0K3R-Scripts**.

If you build something cool on top of this, hop into our Discord
and let us know!

➡ **<https://discord.gg/DH8tW6vSxV>**

---
