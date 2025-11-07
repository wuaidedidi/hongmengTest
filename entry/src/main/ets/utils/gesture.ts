import { GestureEvent } from '../models/types';

/**
 * 手势处理工具类
 * 处理各种手势事件和阈值判断
 */

// 手势阈值配置
export const GESTURE_THRESHOLD = {
  SWIPE_MIN_DISTANCE: 50,    // 最小滑动距离
  SWIPE_MIN_VELOCITY: 300,   // 最小滑动速度
  DOUBLE_TAP_TIMEOUT: 300,   // 双击超时时间
  LONG_PRESS_TIMEOUT: 500,   // 长按超时时间
  TAP_MAX_DISTANCE: 10       // 点击最大位移
};

// 手势方向枚举
export enum SwipeDirection {
  UP = 'up',
  DOWN = 'down',
  LEFT = 'left',
  RIGHT = 'right'
}

// 手势事件处理类
export class GestureDetector {
  private lastTapTime: number = 0;
  private longPressTimer?: number;
  private startPosition: { x: number; y: number } = { x: 0, y: 0 };
  private startTime: number = 0;
  private isLongPressTriggered: boolean = false;

  constructor(private onGesture: (event: GestureEvent) => void) {}

  // 处理触摸开始
  onTouchStart(x: number, y: number): void {
    this.startPosition = { x, y };
    this.startTime = Date.now();
    this.isLongPressTriggered = false;

    // 设置长按定时器
    this.longPressTimer = setTimeout(() => {
      this.isLongPressTriggered = true;
      this.onGesture({
        type: 'longPress',
        position: { x, y }
      });
    }, GESTURE_THRESHOLD.LONG_PRESS_TIMEOUT);
  }

  // 处理触摸结束
  onTouchEnd(x: number, y: number): void {
    // 清除长按定时器
    if (this.longPressTimer) {
      clearTimeout(this.longPressTimer);
      this.longPressTimer = undefined;
    }

    // 如果已经触发了长按，不处理其他手势
    if (this.isLongPressTriggered) {
      return;
    }

    const currentTime = Date.now();
    const deltaX = x - this.startPosition.x;
    const deltaY = y - this.startPosition.y;
    const deltaTime = currentTime - this.startTime;
    const distance = Math.sqrt(deltaX * deltaX + deltaY * deltaY);
    const velocity = distance / deltaTime * 1000; // 像素/秒

    // 判断是否为点击
    if (distance < GESTURE_THRESHOLD.TAP_MAX_DISTANCE) {
      // 判断是否为双击
      if (currentTime - this.lastTapTime < GESTURE_THRESHOLD.DOUBLE_TAP_TIMEOUT) {
        this.onGesture({
          type: 'doubleTap',
          position: { x, y }
        });
      } else {
        // 延迟判断单击，等待双击超时
        setTimeout(() => {
          if (currentTime - this.lastTapTime >= GESTURE_THRESHOLD.DOUBLE_TAP_TIMEOUT) {
            this.onGesture({
              type: 'tap',
              position: { x, y }
            });
          }
        }, GESTURE_THRESHOLD.DOUBLE_TAP_TIMEOUT);
      }
      this.lastTapTime = currentTime;
    }
    // 判断是否为滑动
    else if (distance >= GESTURE_THRESHOLD.SWIPE_MIN_DISTANCE &&
             velocity >= GESTURE_THRESHOLD.SWIPE_MIN_VELOCITY) {
      const direction = this.getSwipeDirection(deltaX, deltaY);
      const eventType = `swipe${direction.charAt(0).toUpperCase() + direction.slice(1)}` as any;

      this.onGesture({
        type: eventType,
        velocity,
        distance,
        position: { x, y }
      });
    }
  }

  // 获取滑动方向
  private getSwipeDirection(deltaX: number, deltaY: number): SwipeDirection {
    const absDeltaX = Math.abs(deltaX);
    const absDeltaY = Math.abs(deltaY);

    if (absDeltaY > absDeltaX) {
      return deltaY > 0 ? SwipeDirection.DOWN : SwipeDirection.UP;
    } else {
      return deltaX > 0 ? SwipeDirection.RIGHT : SwipeDirection.LEFT;
    }
  }
}

// 手势处理器工厂函数
export function createGestureHandler(onGesture: (event: GestureEvent) => void): GestureDetector {
  return new GestureDetector(onGesture);
}

// 垂直滑动处理器
export function createVerticalSwipeHandler(
  onSwipeUp: () => void,
  onSwipeDown: () => void,
  threshold?: number
): (event: GestureEvent) => void {
  const minDistance = threshold || GESTURE_THRESHOLD.SWIPE_MIN_DISTANCE;

  return (event: GestureEvent) => {
    switch (event.type) {
      case 'swipeUp':
        if ((event.distance || 0) >= minDistance) {
          onSwipeUp();
        }
        break;
      case 'swipeDown':
        if ((event.distance || 0) >= minDistance) {
          onSwipeDown();
        }
        break;
    }
  };
}

// 横向滑动处理器
export function createHorizontalSwipeHandler(
  onSwipeLeft: () => void,
  onSwipeRight: () => void,
  threshold?: number
): (event: GestureEvent) => void {
  const minDistance = threshold || GESTURE_THRESHOLD.SWIPE_MIN_DISTANCE;

  return (event: GestureEvent) => {
    switch (event.type) {
      case 'swipeLeft':
        if ((event.distance || 0) >= minDistance) {
          onSwipeLeft();
        }
        break;
      case 'swipeRight':
        if ((event.distance || 0) >= minDistance) {
          onSwipeRight();
        }
        break;
    }
  };
}

// 双击处理器
export function createDoubleTapHandler(onDoubleTap: (position?: { x: number; y: number }) => void): (event: GestureEvent) => void {
  return (event: GestureEvent) => {
    if (event.type === 'doubleTap') {
      onDoubleTap(event.position);
    }
  };
}

// 长按处理器
export function createLongPressHandler(onLongPress: (position?: { x: number; y: number }) => void): (event: GestureEvent) => void {
  return (event: GestureEvent) => {
    if (event.type === 'longPress') {
      onLongPress(event.position);
    }
  };
}