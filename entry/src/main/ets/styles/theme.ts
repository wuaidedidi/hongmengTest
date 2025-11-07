/**
 * 主题样式配置
 * 定义应用的颜色、字体、间距、阴影等通用样式
 */

// 颜色主题
export const Colors = {
  // 主色调
  primary: '#FE2C55',      // 抖音红色
  secondary: '#25F4EE',    // 抖音青色
  accent: '#FF0050',       // 强调色

  // 背景色
  background: '#000000',   // 主背景色（黑色）
  surface: '#1A1A1A',      // 表面色（深灰）
  card: '#2A2A2A',         // 卡片色

  // 文本色
  textPrimary: '#FFFFFF',  // 主文本（白色）
  textSecondary: '#A0A0A0', // 次要文本（灰色）
  textTertiary: '#666666', // 三级文本（深灰）
  textHint: '#444444',     // 提示文本（更深灰）

  // 状态色
  success: '#4CAF50',
  warning: '#FF9800',
  error: '#F44336',
  info: '#2196F3',

  // 边框色
  border: '#333333',
  borderLight: '#404040',
  borderDark: '#1A1A1A',

  // 遮罩色
  overlay: 'rgba(0, 0, 0, 0.5)',
  overlayLight: 'rgba(0, 0, 0, 0.3)',
  overlayDark: 'rgba(0, 0, 0, 0.8)',

  // 毛玻璃效果
  frostedGlass: 'rgba(255, 255, 255, 0.1)',
  frostedGlassDark: 'rgba(0, 0, 0, 0.25)',

  // 渐变色配置
  gradientBlack: {
    colors: [
      { color: '#00000000', offset: 0 },
      { color: '#CC000000', offset: 1 }
    ],
    direction: GradientDirection.Bottom
  },
  gradientPrimary: {
    colors: [
      { color: '#FE2C55', offset: 0 },
      { color: '#FF0050', offset: 1 }
    ],
    direction: GradientDirection.Right
  },
  gradientSecondary: {
    colors: [
      { color: '#25F4EE', offset: 0 },
      { color: '#00D4E4', offset: 1 }
    ],
    direction: GradientDirection.Right
  }
};

// 字体配置
export const Typography = {
  // 字体大小
  fontSize: {
    xs: 10,
    sm: 12,
    base: 14,
    lg: 16,
    xl: 18,
    xxl: 20,
    xxxl: 24,
    huge: 32,
    massive: 48
  },

  // 字体权重
  fontWeight: {
    light: 300,
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700,
    extrabold: 800
  },

  // 行高
  lineHeight: {
    tight: 1.2,
    normal: 1.4,
    relaxed: 1.6,
    loose: 1.8
  },

  // 字体族
  fontFamily: {
    primary: 'HarmonyOS Sans',
    secondary: 'HarmonyOS Sans SC',
    mono: 'HarmonyOS Sans Mono'
  }
};

// 间距配置
export const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
  xxxl: 64,
  huge: 96,
  massive: 128
};

// 圆角配置
export const BorderRadius = {
  none: 0,
  xs: 2,
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  xxl: 24,
  full: 9999
};

// 阴影配置
export const Shadows = {
  none: 'none',
  sm: {
    radius: 2,
    color: 'rgba(0, 0, 0, 0.1)',
    offsetX: 0,
    offsetY: 1
  },
  md: {
    radius: 4,
    color: 'rgba(0, 0, 0, 0.15)',
    offsetX: 0,
    offsetY: 2
  },
  lg: {
    radius: 8,
    color: 'rgba(0, 0, 0, 0.2)',
    offsetX: 0,
    offsetY: 4
  },
  xl: {
    radius: 16,
    color: 'rgba(0, 0, 0, 0.25)',
    offsetX: 0,
    offsetY: 8
  },
  glow: {
    radius: 20,
    color: 'rgba(254, 44, 85, 0.3)',
    offsetX: 0,
    offsetY: 0
  }
};

// 动画配置
export const Animations = {
  duration: {
    fast: 150,
    normal: 250,
    slow: 350,
    slower: 500
  },
  easing: {
    ease: 'cubic-bezier(0.25, 0.1, 0.25, 1)',
    easeIn: 'cubic-bezier(0.42, 0, 1, 1)',
    easeOut: 'cubic-bezier(0, 0, 0.58, 1)',
    easeInOut: 'cubic-bezier(0.42, 0, 0.58, 1)',
    spring: 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
    elastic: 'cubic-bezier(0.68, -0.6, 0.32, 1.6)'
  }
};

// 组件尺寸
export const ComponentSizes = {
  // 按钮尺寸
  button: {
    sm: { width: 32, height: 32 },
    md: { width: 48, height: 48 },
    lg: { width: 64, height: 64 },
    xl: { width: 80, height: 80 }
  },

  // 头像尺寸
  avatar: {
    xs: 24,
    sm: 32,
    md: 48,
    lg: 64,
    xl: 96
  },

  // 图标尺寸
  icon: {
    xs: 12,
    sm: 16,
    md: 24,
    lg: 32,
    xl: 48
  },

  // 导航栏尺寸
  navigation: {
    top: { height: 56 },
    bottom: { height: 64 }
  },

  // 视频操作栏尺寸
  videoAction: {
    buttonSize: 48,
    spacing: 16,
    avatarSize: 48,
    rightWidth: 60
  },

  // 圆角尺寸
  borderRadius: {
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    full: 999
  }
};

// 毛玻璃效果样式
export const FrostedGlassStyle = {
  background: Colors.frostedGlassDark,
  backdropBlur: 12,
  border: {
    width: 1,
    color: Colors.borderLight
  }
};

// 暗色主题配置
export const DarkTheme = {
  ...Colors,
  background: '#000000',
  surface: '#1A1A1A',
  card: '#2A2A2A',
  textPrimary: '#FFFFFF',
  textSecondary: '#A0A0A0',
  textTertiary: '#666666'
};

// 亮色主题配置（备用）
export const LightTheme = {
  ...Colors,
  background: '#FFFFFF',
  surface: '#F5F5F5',
  card: '#FFFFFF',
  textPrimary: '#000000',
  textSecondary: '#666666',
  textTertiary: '#999999'
};

// 主题工具函数
export const ThemeUtils = {
  /**
   * 获取当前主题颜色
   */
  getColor(colorName: keyof typeof Colors): string | { colors: Array<{ color: string; offset: number }>; direction: GradientDirection } {
    return Colors[colorName];
  },

  /**
   * 获取字体大小
   */
  getFontSize(size: keyof typeof Typography.fontSize): number {
    return Typography.fontSize[size];
  },

  /**
   * 获取间距
   */
  getSpacing(size: keyof typeof Spacing): number {
    return Spacing[size];
  },

  /**
   * 获取圆角
   */
  getBorderRadius(size: keyof typeof BorderRadius): number {
    return BorderRadius[size];
  },

  /**
   * 获取阴影样式
   */
  getShadow(shadowName: keyof typeof Shadows): any {
    return Shadows[shadowName];
  },

  /**
   * 创建渐变色配置
   */
  createGradient(colors: Array<{ color: string; offset: number }>, direction: 'top' | 'bottom' | 'left' | 'right' = 'bottom') {
    return {
      colors,
      direction: {
        top: GradientDirection.Top,
        bottom: GradientDirection.Bottom,
        left: GradientDirection.Left,
        right: GradientDirection.Right
      }[direction]
    };
  },

  /**
   * 创建毛玻璃样式
   */
  createFrostedGlass(blurRadius: number = 12, opacity: number = 0.1) {
    return {
      backgroundColor: `rgba(255, 255, 255, ${opacity})`,
      backdropBlur: blurRadius,
      border: {
        width: 1,
        color: Colors.borderLight
      }
    };
  }
};

// 主题切换钩子（如果需要支持主题切换）
export function useTheme() {
  const isDark = true; // 默认使用暗色主题

  return {
    theme: isDark ? DarkTheme : LightTheme,
    isDarkMode: isDark,
    colors: isDark ? DarkTheme : Colors,
    toggleTheme: () => {
      // 主题切换逻辑（如果需要）
    }
  };
}