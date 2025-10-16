# 🏗️ Dotfiles — Hyprland, Zsh, Neovim & More

My personal Arch Linux **dotfiles**, managed cleanly with **GNU Stow**.  
Everything here is version-controlled and portable — one command sets up a full environment on any new machine.

---

## 📦 What’s Inside

| Component | Purpose |
|------------|----------|
| **Hyprland** | Wayland compositor / window manager |
| **Waybar** | Status bar and system monitor |
| **Kitty** | Terminal emulator |
| **Zsh** | Shell configuration and aliases |
| **Neovim** | Editor setup |
| **Solaar** | Logitech device manager |
| **Misc. scripts** | Helper utilities for everyday use |

---

## 🗂️ Repository Structure

Each folder inside the repo mirrors the file paths under `$HOME`.  
For example:

```
dotfiles/
├── hypr/.config/hypr/
├── waybar/.config/waybar/
├── kitty/.config/kitty/
├── nvim/.config/nvim/
├── zsh/.zshrc
└── solaar/.config/solaar/
```

That way, Stow knows exactly where to symlink each file.

---

## ⚙️ How It Works

[GNU Stow](https://www.gnu.org/software/stow/) creates symbolic links from these folders into your home directory.

Example:

```bash
stow -t ~ zsh
```

creates the symlink:

```
~/.zshrc → ~/dotfiles/zsh/.zshrc
```

Clean, reversible, and safe.

---

## 🚀 Bootstrapping on a New Machine

### 1️⃣ Install prerequisites
```bash
sudo pacman -S git stow
```

### 2️⃣ Clone this repository
```bash
git clone git@github.com:<yourusername>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

*(If you haven’t set up SSH keys yet, see the section below.)*

### 3️⃣ Apply your configs
```bash
stow -t ~ hypr waybar kitty nvim zsh solaar
```

### 4️⃣ Reload
- Re-log into your session, or  
- `exec hyprctl reload` (Hyprland)  
- `source ~/.zshrc` (Zsh)

Done — your system now mirrors your preferred environment.

---

## 🔁 Managing Changes

| Task | Command |
|------|----------|
| Add a new config | Move it into the right package folder and run `stow -t ~ <pkg>` |
| Remove a package | `stow -D -t ~ <pkg>` |
| Preview links | `stow -n -v -t ~ <pkg>` |
| Re-link everything | `stow -R -t ~ *` |

---

## 🧠 Best Practices

- **One package = one app** (e.g., `zsh`, `nvim`, `hypr`).
- **Keep secrets out.** Add `.ssh/`, `.gnupg/`, `.env`, tokens, etc., to `.gitignore`.
- **Host-specific configs:** use `host-<hostname>/` and only stow them where needed.
- **System-wide files:** if you track `/etc` or `/usr/share` stuff, create a `root/` package and stow it with `sudo stow -t / root`.

---

## 🪄 Quick One-Line Setup

```bash
git clone git@github.com:<yourusername>/dotfiles.git ~/dotfiles && cd ~/dotfiles && stow -t ~ hypr waybar kitty nvim zsh solaar
```

---

## 🧰 Optional Dependencies

| Component | Arch package |
|------------|---------------|
| Hyprland | `hyprland` |
| Waybar | `waybar` |
| Kitty | `kitty` |
| Zsh | `zsh`, `zinit` or `oh-my-zsh` |
| Neovim | `neovim` |
| Solaar | `solaar` |
| Stow | `stow` |
| Git | `git` |

---

## 📝 .gitignore Recommendations

```
# caches
**/.cache/
**/cache/
.local/share/**

# secrets
.ssh/
.gnupg/
.env
*.key
*.pem
*.token
.git-credentials

# editor junk
*.swp
*.tmp
```

---

## 🧩 Troubleshooting

- **Stow says “existing target”** → move that file into your repo package, then restow.
- **Configs not loading** → check that symlinks actually exist in `$HOME`.
- **SSH push fails** → verify your key is added (`ssh -T git@github.com`).





