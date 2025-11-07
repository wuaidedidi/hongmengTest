/**
 * 布局工具类
 * 处理屏幕适配、安全区域、比例计算等
 */

// 屏幕尺寸信息
export interface ScreenSize {
  width: number;
  height: number;
  density: number;
  scale: number;
}

// 安全区域信息
export interface SafeArea {
  top: number;
  bottom: number;
  left: number;
  right: number;
}

// 布局工具类
export class LayoutHelper {
  private static screenSize: ScreenSize = {
    width: 390,
    height: 844,
    density: 2,
    scale: 1
  };

  private static safeArea: SafeArea = {
    top: 44,
    bottom: 34,
    left: 0,
    right: 0
  };

  /**
   * 设置屏幕尺寸信息
   */
  static setScreenSize(screenSize: Partial<ScreenSize>): void {
    this.screenSize = { ...this.screenSize, ...screenSize };
  }

  /**
   * 获取屏幕尺寸
   */
  static getScreenSize(): ScreenSize {
    return { ...this.screenSize };
  }

  /**
   * 设置安全区域
   */
  static setSafeArea(safeArea: Partial<SafeArea>): void {
    this.safeArea = { ...this.safeArea, ...safeArea };
  }

  /**
   * 获取安全区域
   */
  static getSafeArea(): SafeArea {
    return { ...this.safeArea };
  }

  /**
   * 获取屏幕宽度
   */
  static getScreenWidth(): number {
    return this.screenSize.width;
  }

  /**
   * 获取屏幕高度
   */
  static getScreenHeight(): number {
    return this.screenSize.height;
  }

  /**
   * 获取可用内容高度（减去安全区域）
   */
  static getContentHeight(): number {
    return this.screenSize.height - this.safeArea.top - this.safeArea.bottom;
  }

  /**
   * 获取状态栏高度
   */
  static getStatusBarHeight(): number {
    return this.safeArea.top;
  }

  /**
   * 获取底部指示器高度
   */
  static getIndicatorHeight(): number {
    return this.safeArea.bottom;
  }

  /**
   * 根据屏幕尺寸进行尺寸适配
   * @param value 设计稿中的尺寸
   * @param baseWidth 基准宽度（默认375，对应iPhone 6/7/8）
   */
  static scaleSize(value: number, baseWidth: number = 375): number {
    return (value * this.screenSize.width) / baseWidth;
  }

  /**
   * 适配字体大小
   * @param fontSize 字体大小
   */
  static scaleFontSize(fontSize: number): number {
    return this.scaleSize(fontSize);
  }

  /**
   * 计算视频显示区域（保持16:9比例，居中裁剪）
   */
  static getVideoDisplayArea(): { width: number; height: number; offsetX: number; offsetY: number } {
    const screenWidth = this.screenSize.width;
    const screenHeight = this.getContentHeight();

    // 16:9比例
    const aspectRatio = 16 / 9;

    let displayWidth = screenWidth;
    let displayHeight = screenWidth / aspectRatio;

    // 如果高度不够，则以高度为准
    if (displayHeight > screenHeight) {
      displayHeight = screenHeight;
      displayWidth = screenHeight * aspectRatio;
    }

    const offsetX = (screenWidth - displayWidth) / 2;
    const offsetY = (screenHeight - displayHeight) / 2;

    return {
      width: displayWidth,
      height: displayHeight,
      offsetX,
      offsetY
    };
  }

  /**
   * 计算视频在屏幕中的显示位置（全屏居中裁剪）
   */
  static getFullScreenVideoArea(): { width: number; height: number } {
    const screenWidth = this.screenSize.width;
    const screenHeight = this.getContentHeight();

    // 以宽度为准，保持视频比例
    const videoAspectRatio = 9 / 16; // 竖屏视频比例
    let videoWidth = screenWidth;
    let videoHeight = screenWidth * videoAspectRatio;

    // 如果高度不够填满屏幕，则以高度为准
    if (videoHeight < screenHeight) {
      videoHeight = screenHeight;
      videoWidth = screenHeight / videoAspectRatio;
    }

    return {
      width: videoWidth,
      height: videoHeight
    };
  }

  /**
   * 计算毛玻璃背景尺寸
   */
  static getFrostedGlassSize(): { width: number; height: number } {
    return {
      width: this.screenSize.width,
      height: this.screenSize.height
    };
  }

  /**
   * 计算导航栏高度
   */
  static getNavigationBarHeight(): number {
    return this.scaleSize(56); // 56pt导航栏
  }

  /**
   * 计算底部导航栏高度
   */
  static getBottomBarHeight(): number {
    return this.scaleSize(64) + this.safeArea.bottom; // 64pt底部导航 + 安全区域
  }

  /**
   * 计算视频操作栏尺寸
   */
  static getVideoActionBarSize(): {
    buttonSize: number;
    buttonSpacing: number;
    avatarSize: number;
    rightWidth: number;
  } {
    return {
      buttonSize: this.scaleSize(48),
      buttonSpacing: this.scaleSize(16),
      avatarSize: this.scaleSize(48),
      rightWidth: this.scaleSize(60)
    };
  }

  /**
   * 计算文本信息区域尺寸
   */
  static getVideoInfoAreaSize(): {
    maxWidth: string;
    lineHeight: number;
    fontSize: {
      name: number;
      description: number;
      music: number;
    };
  } {
    return {
      maxWidth: '70%',
      lineHeight: this.scaleSize(1.4),
      fontSize: {
        name: this.scaleSize(16),
        description: this.scaleSize(14),
        music: this.scaleSize(14)
      }
    };
  }

  /**
   * 计算抽屉尺寸
   */
  static getDrawerSize(): {
    width: string;
    maxWidth: number;
    height: string;
  } {
    return {
      width: '80%',
      maxWidth: this.scaleSize(320),
      height: '100%'
    };
  }

  /**
   * 检查是否为横屏
   */
  static isLandscape(): boolean {
    return this.screenSize.width > this.screenSize.height;
  }

  /**
   * 检查是否为竖屏
   */
  static isPortrait(): boolean {
    return this.screenSize.height > this.screenSize.width;
  }

  /**
   * 获取屏幕方向
   */
  static getOrientation(): 'portrait' | 'landscape' {
    return this.isPortrait() ? 'portrait' : 'landscape';
  }

  /**
   * 计算按钮最小点击区域
   */
  static getMinTouchArea(): { width: number; height: number } {
    return {
      width: Math.max(44, this.scaleSize(44)),
      height: Math.max(44, this.scaleSize(44))
    };
  }

  /**
   * 计算卡片圆角
   */
  static getBorderRadius(): {
    small: number;
    medium: number;
    large: number;
    full: number;
  } {
    return {
      small: this.scaleSize(4),
      medium: this.scaleSize(8),
      large: this.scaleSize(12),
      full: this.scaleSize(999)
    };
  }

  /**
   * 计算间距值
   */
  static getSpacing(): {
    xs: number;
    sm: number;
    md: number;
    lg: number;
    xl: number;
    xxl: number;
  } {
    return {
      xs: this.scaleSize(4),
      sm: this.scaleSize(8),
      md: this.scaleSize(16),
      lg: this.scaleSize(24),
      xl: this.scaleSize(32),
      xxl: this.scaleSize(48)
    };
  }
}

// 响应式布局辅助函数
export function useResponsive() {
  return {
    screenWidth: LayoutHelper.getScreenWidth(),
    screenHeight: LayoutHelper.getScreenHeight(),
    isPortrait: LayoutHelper.isPortrait(),
    isLandscape: LayoutHelper.isLandscape(),
    scaleSize: LayoutHelper.scaleSize.bind(LayoutHelper),
    scaleFontSize: LayoutHelper.scaleFontSize.bind(LayoutHelper)
  };
}

// 安全区域辅助函数
export function useSafeArea() {
  return {
    safeArea: LayoutHelper.getSafeArea(),
    statusBarHeight: LayoutHelper.getStatusBarHeight(),
    indicatorHeight: LayoutHelper.getIndicatorHeight(),
    contentHeight: LayoutHelper.getContentHeight()
  };
}