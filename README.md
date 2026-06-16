# raymarch-dd

Small SDL3 raymarcher written in Dudu.

This is a test repo for dogfooding Dudu on a real graphics use case. It is not a
polished renderer. The point is to stress ordinary systems-code shapes: multiple
Dudu source files, SDL3 imports, native C headers, value types, operator
overloads, threads, a low-resolution framebuffer, and a simple render loop.

![raymarch-dd screenshot](assets/screenshot.png)

## Requirements

- Dudu compiler built at `~/Coding/GameDev/dudu/build/dudu`
- SDL3 development files
- `pkg-config`

This repo is intentionally local-machine specific right now. The script points
at the Dudu checkout and one known SDL3 install path:

```bash
PKG_CONFIG_PATH=~/Coding/GameDev/duduplayground/third_party/install/lib/pkgconfig
```

## Run

```bash
./scripts/run.sh
```

That emits C++, builds the binary, and runs it.

## What This Tests

- Direct native C imports:
  ```python
  import c "SDL3/SDL.h"
  ```
- SDL3 types and functions discovered from headers.
- Dudu value types with generated constructors.
- Dudu-native operator overloads on `Vec3`.
- A camera type composed from `Vec3` values.
- Multithreaded CPU rendering through imported `std.thread`.
- Updating an SDL streaming texture from a Dudu `list[u32]` framebuffer.

## Dudu Shortcomings Exposed

This repo found real Dudu issues:

- Native Dudu module identity needed work. Importing the same physical module
  through multiple routes could create duplicate declarations.
- `from module import Name as Alias` did not work for Dudu-native modules when
  this repo first hit it.
- Transitive imports and re-export behavior need a stricter design. User code
  should not have to care how another module imports its dependencies.
- VS Code LSP behavior is not reliable enough yet. Go-to-definition,
  find-all-references, and hover can spin or show `Loading...` in this
  workspace.
- The current build script is local-machine specific. It points at the local
  Dudu checkout and local SDL3 install instead of being portable.

Those issues are documented in Dudu's `le_plan.md` and language-server plan.

## Notes

The renderer is intentionally simple. It raymarches a sphere and floor into a
low-resolution intermediate buffer and scales it with nearest filtering.
