import { AnimationConfig } from '../models/types';

/**
 * 动画工具类
 * 提供常用动画效果和配置
 */

// 预定义动画配置
export const ANIMATION_CONFIG = {
  // 弹性缩放动画
  BOUNCE_SCALE: {
    duration: 300,
    curve: 'elastic',
    delay: 0
  } as AnimationConfig,

  // 快速缩放动画
  QUICK_SCALE: {
    duration: 150,
    curve: 'easeOut',
    delay: 0
  } as AnimationConfig,

  // 淡入淡出动画
  FADE: {
    duration: 250,
    curve: 'easeInOut',
    delay: 0
  } as AnimationConfig,

  // 滑动动画
  SLIDE: {
    duration: 200,
    curve: 'easeOut',
    delay: 0
  } as AnimationConfig,

  // 旋转动画（唱片旋转）
  ROTATE: {
    duration: 8000,
    curve: 'linear',
    delay: 0
  } as AnimationConfig,

  // 弹出动画
  POPUP: {
    duration: 220,
    curve: 'easeOut',
    delay: 0
  } as AnimationConfig,

  // 心形飘散动画
  HEART_FLOAT: {
    duration: 1000,
    curve: 'easeOut',
    delay: 0
  } as AnimationConfig
};

// 动画工具类
export class AnimationHelper {
  /**
   * 创建缩放动画
   * @param from 起始缩放值
   * @param to 结束缩放值
   * @param config 动画配置
   */
  static createScaleAnimation(
    from: number = 1,
    to: number = 1.1,
    config: AnimationConfig = ANIMATION_CONFIG.QUICK_SCALE
  ): { scale: { from: number; to: number }; duration: number; curve: string } {
    return {
      scale: { from, to },
      duration: config.duration,
      curve: config.curve
    };
  }

  /**
   * 创建旋转动画
   * @param from 起始角度
   * @param to 结束角度
   * @param config 动画配置
   */
  static createRotateAnimation(
    from: number = 0,
    to: number = 360,
    config: AnimationConfig = ANIMATION_CONFIG.ROTATE
  ): { rotate: { from: number; to: number }; duration: number; curve: string } {
    return {
      rotate: { from, to },
      duration: config.duration,
      curve: config.curve
    };
  }

  /**
   * 创建透明度动画
   * @param from 起始透明度
   * @param to 结束透明度
   * @param config 动画配置
   */
  static createOpacityAnimation(
    from: number = 0,
    to: number = 1,
    config: AnimationConfig = ANIMATION_CONFIG.FADE
  ): { opacity: { from: number; to: number }; duration: number; curve: string } {
    return {
      opacity: { from, to },
      duration: config.duration,
      curve: config.curve
    };
  }

  /**
   * 创建位移动画
   * @param fromX 起始X位置
   * @param fromY 起始Y位置
   * @param toX 结束X位置
   * @param toY 结束Y位置
   * @param config 动画配置
   */
  static createTranslateAnimation(
    fromX: number = 0,
    fromY: number = 0,
    toX: number = 0,
    toY: number = 0,
    config: AnimationConfig = ANIMATION_CONFIG.SLIDE
  ): { translate: { from: { x: number; y: number }; to: { x: number; y: number } }; duration: number; curve: string } {
    return {
      translate: {
        from: { x: fromX, y: fromY },
        to: { x: toX, y: toY }
      },
      duration: config.duration,
      curve: config.curve
    };
  }

  /**
   * 创建复合动画（同时执行多个动画）
   * @param animations 动画数组
   */
  static createCompositeAnimation(animations: any[]): any[] {
    return animations;
  }

  /**
   * 创建序列动画（按顺序执行）
   * @param animations 动画数组
   */
  static createSequenceAnimation(animations: any[]): any[] {
    return animations;
  }
}

// 爱心飘散动画效果
export class HeartFloatAnimation {
  private hearts: Array<{
    id: string;
    x: number;
    y: number;
    opacity: number;
    scale: number;
    velocity: { x: number; y: number };
  }> = [];

  /**
   * 在指定位置创建飘散的爱心
   * @param x X坐标
   * @param y Y坐标
   * @param count 爱心数量
   */
  createHearts(x: number, y: number, count: number = 6): Array<any> {
    const newHearts = [];

    for (let i = 0; i < count; i++) {
      const angle = (Math.PI * 2 * i) / count;
      const velocity = 2 + Math.random() * 2;

      const heart = {
        id: `heart_${Date.now()}_${i}`,
        x: x,
        y: y,
        opacity: 1,
        scale: 0.5 + Math.random() * 0.5,
        velocity: {
          x: Math.cos(angle) * velocity,
          y: Math.sin(angle) * velocity - 2 // 向上偏移
        }
      };

      this.hearts.push(heart);
      newHearts.push(heart);
    }

    return newHearts;
  }

  /**
   * 更新所有爱心的位置和状态
   * @param deltaTime 时间间隔（毫秒）
   */
  updateHearts(deltaTime: number): Array<any> {
    const updatedHearts = [];

    this.hearts = this.hearts.filter(heart => {
      // 更新位置
      heart.x += heart.velocity.x * deltaTime / 16;
      heart.y += heart.velocity.y * deltaTime / 16;

      // 更新透明度
      heart.opacity -= deltaTime / 1000;

      // 更新缩放
      heart.scale += deltaTime / 500;

      // 重力效果
      heart.velocity.y += 0.1;

      // 保留还可见的爱心
      if (heart.opacity > 0) {
        updatedHearts.push(heart);
        return true;
      }

      return false;
    });

    return updatedHearts;
  }

  /**
   * 清除所有爱心
   */
  clearHearts(): void {
    this.hearts = [];
  }

  /**
   * 获取当前所有爱心
   */
  getHearts(): Array<any> {
    return [...this.hearts];
  }
}

// 全局爱心动画实例
export const heartFloatAnimation = new HeartFloatAnimation();

// 动画状态管理
export class AnimationStateManager {
  private animationStates: Map<string, boolean> = new Map();

  /**
   * 设置动画状态
   * @param id 动画ID
   * @param isRunning 是否正在运行
   */
  setAnimationState(id: string, isRunning: boolean): void {
    this.animationStates.set(id, isRunning);
  }

  /**
   * 获取动画状态
   * @param id 动画ID
   */
  getAnimationState(id: string): boolean {
    return this.animationStates.get(id) || false;
  }

  /**
   * 停止指定动画
   * @param id 动画ID
   */
  stopAnimation(id: string): void {
    this.animationStates.set(id, false);
  }

  /**
   * 清除所有动画状态
   */
  clearAllAnimations(): void {
    this.animationStates.clear();
  }
}

// 全局动画状态管理实例
export const animationStateManager = new AnimationStateManager();