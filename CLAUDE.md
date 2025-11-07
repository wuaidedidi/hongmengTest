# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a HarmonyOS application project that contains two main components:

1. **HarmonyOS Native App**: A mobile application built with HarmonyOS SDK and ArkTS language
2. **React/TypeScript Figma Components**: A web-based component library built with React, TypeScript, and Tailwind CSS, designed for a video social media interface similar to TikTok

## Architecture

### HarmonyOS Application Structure
- **Entry Module** (`entry/`): Main application module containing the UI and logic
  - `src/main/ets/`: Source code in ArkTS
  - `src/main/ets/entryability/EntryAbility.ets`: Main application entry point
  - `src/main/ets/pages/`: UI pages (currently contains Index.ets)
  - `src/main/resources/`: Application resources (images, strings, colors)
  - `src/test/`: Unit tests using @ohos/hypium framework
  - `src/ohosTest/`: UI automation tests

### Figma Components Structure
- **Components** (`figma/components/`): React/TypeScript UI components
  - `VideoFeed.tsx`: Main video feed component
  - `VideoPlayer.tsx`: Video player component
  - `TopNavigation.tsx`, `BottomNavigation.tsx`: Navigation components
  - `FriendsDrawer.tsx`, `CreateMenu.tsx`: Interactive overlay components
  - `ui/`: Reusable UI component library (shadcn/ui components)
- **Styles** (`figma/styles/`): Global CSS and Tailwind configuration
- **Guidelines** (`figma/guidelines/`): Development guidelines and design system rules

## Development Commands

### HarmonyOS Development
```bash
# Build the project
hvigorw assembleApp

# Build for debug
hvigorw assembleApp --mode debug

# Build for release
hvigorw assembleApp --mode release

# Run tests
hvigorw test

# Run specific test modules
hvigorw test --module entry
```

### React/TypeScript Components
The Figma components use standard React development tooling:
- Components are built with TypeScript and Tailwind CSS
- Uses shadcn/ui component library for consistent design
- No build commands found - likely integrated with external build system

## Key Technologies

### HarmonyOS Stack
- **Language**: ArkTS (TypeScript-based)
- **UI Framework**: ArkUI (declarative UI framework)
- **Build System**: Hvigor
- **Testing**: @ohos/hypium for unit tests, @ohos/hamock for mocking

### React/TypeScript Stack
- **Language**: TypeScript
- **UI Library**: React
- **Styling**: Tailwind CSS
- **Component Library**: shadcn/ui (MIT license)
- **Images**: Unsplash (license terms apply)

## Configuration Files

- `build-profile.json5`: Main build configuration
- `AppScope/app.json5`: Application metadata and permissions
- `entry/src/main/module.json5`: Module configuration for entry module
- `hvigor/hvigor-config.json5`: Build tool configuration
- `oh-package.json5`: Package dependencies for HarmonyOS

## Testing

### Unit Tests
- Located in `entry/src/test/` directory
- Uses @ohos/hypium testing framework
- Test files follow pattern `*.test.ets`

### UI Tests
- Located in `entry/src/ohosTest/ets/test/` directory
- Tests UI interactions and application lifecycle
- Uses same @ohos/hypium framework with additional UI testing capabilities

## Development Notes

- The project supports multiple device types: phone, tablet, and 2in1
- Color mode is set to COLOR_MODE_NOT_SET in EntryAbility
- The app uses Chinese UI text in the React components
- The HarmonyOS app currently has minimal functionality (Hello World display)
- The React components implement a full-featured video social media interface
- Both parts of the project appear to be separate implementations of similar concepts