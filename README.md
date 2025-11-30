```
███████╗  ████████╗   ██████╗   ███████╗  ███████╗
██╔════╝  ██╔═══██║  ██╔══██║  ██╔══╗██║  ██╔════╝
██║       ██║   ██║  ██║  ██║  ██║  ╚══╝  ██║ 
█████╗    ██║   ██║  ██████╔╝  ██║        █████╗  
██╔══╝    ██║   ██║  ██╔══██╗  ██║  ███╗  ██╔══╝  
██║       ██║   ██║  ██║  ██║  ██║   ██║  ██║  
██║       ╚██████╔╝  ██║  ██║  ╚██████╔╝  ███████╗
╚═╝        ╚═════╝   ╚═╝  ╚═╝   ╚═════╝   ╚══════╝
              ForGE — Fortran Graphics Engine
```

---

# 🔥 ForGE — Fortran Graphics Engine

> **ForGE (Fortran Graphics Engine)** — a minimal 3D engine and educational example  
> demonstrating how to use **OpenGL** and **GLFW** directly from **Fortran**,  
> without any external C/C++ wrappers.

---

## ⬇ Скачать готовый демо-билд

Если не хочешь собирать из исходников, можно просто скачать архив:

[👉 ForGE Space Demo v0.1.0 (Windows x64)](https://github.com/valdislaf/forge/releases/latest)

**Как запустить:**

1. Распаковать `forge-space-demo-v0.1.0-win64.zip` в любую папку.
2. Запустить `forge-demo.exe`.
3. Убедиться, что рядом лежат `glfw3.dll`, `top.png` и папка `textures/`.

> Исходный код полного демо-проекта не публикуется,  
> в этом репозитории лежит учебный минимальный пример (`forge.f90`)  
> и готовая бинарная сборка движка.

---

## 🧩 Features

- 🚀 Create 3D windows using **GLFW**
- 🎮 **FPS-style camera control** (WASD + mouse)
- 🔄 Perspective projection & **LookAt** matrix
- 🧱 Wireframe cube rendering and basic geometry
- ⚙️ Pure **Fortran 2008** — no external dependencies
- 🪶 Lightweight and perfect as a 3D boilerplate

---

## 🖥️ Build Instructions

**Windows (MSYS2 + MinGW-w64):**

```bash
del /q *.mod 2>nul
gfortran forge.f90 -o forge.exe -lglfw3 -lopengl32 -lgdi32 -luser32 -lkernel32
```

If the linker cannot find `-lglfw3`, specify the library path manually:

```bash
gfortran forge.f90 -o forge.exe ^
    -L"C:\msys64\mingw64\lib" ^
    -lglfw3 -lopengl32 -lgdi32 -luser32 -lkernel32
```

---

## 🛠️ Installing GLFW on MSYS2 (Windows)

If you don't have GLFW installed, open **MSYS2 MinGW x64** (not the MSYS shell) and run:

```bash
pacman -Syu           # update the system, restart shell if prompted
pacman -Su            # finish pending updates (if needed)

pacman -S mingw-w64-x86_64-glfw mingw-w64-x86_64-pkgconf
# optional: mingw-w64-x86_64-gcc-fortran

---

## 🕹️ Controls

| Key | Action |
|-----|---------|
| **W / S** | Move forward / backward |
| **A / D** | Strafe left / right |
| **Space** | Move up |
| **Shift** | Speed boost |
| **Mouse** | Rotate camera |
| **Esc** | Exit |

---

## 🧠 Camera Architecture

ForGE implements a classical **LookAt view matrix**,  
constructed manually from the camera’s basis vectors (`front`, `up`, `right`):

```fortran
f = camFront
r = cross3(f, camUp)
u = cross3(r, f)
call glMultMatrixf( view_matrix(f, r, u, camPos) )
```

Camera movement and rotation share the same coordinate space —  
W/S moves along the view direction, and A/D strafes sideways,  
independent of camera pitch or yaw.

---

## 🧰 Dependencies

- [GLFW 3.x](https://www.glfw.org/)
- [OpenGL 1.1+](https://www.khronos.org/opengl/)
- [GNU Fortran (GFortran)](https://gcc.gnu.org/fortran/)

---

[![build-windows](https://github.com/valdislaf/forge/actions/workflows/build.yml/badge.svg)](https://github.com/valdislaf/forge/actions/workflows/build.yml)

## 📚 About

**ForGE** serves as a learning project and minimal engine foundation,  
demonstrating that modern **3D rendering and simulation** can be done purely in **Fortran**.

Potential extensions:
- 📦 `.obj` model loading  
- 💡 basic lighting and normals  
- 🧵 simple scene renderer  

---

## 🧑‍💻 Author

**Vladislav Berestenko**  
💻 Fortran / C++ / Qt Developer  
🌐 [github.com/valdislaf](https://github.com/valdislaf)

---

## 📜 License

**MIT License © 2025 Vladislav Berestenko**  
Feel free to use ForGE in your own projects — attribution appreciated 🤝
