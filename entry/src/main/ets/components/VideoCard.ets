import { Colors, Typography, Spacing, ComponentSizes } from '../styles/theme';
import { LayoutHelper } from '../utils/layout';
import { AnimationHelper, heartFloatAnimation, ANIMATION_CONFIG } from '../utils/anim';
import { appStore } from '../store/appStore';
import { VideoItem } from '../models/types';

/**
 * 视频卡片组件
 * 包含视频播放、信息展示、交互操作等
 */

interface Position {
  x: number;
  y: number;
}

interface ActionButtonParams {
  icon: string;
  count: string;
  isActive: boolean;
  onClick: () => void;
}

interface FriendItemParams {
  id: string;
  name: string;
  avatar: string;
  isOnline: boolean;
  lastSeen?: string;
  status?: string;
}

interface VideoCardProps {
  video: VideoItem;
  isActive: boolean;
  onLike: () => void;
  onFollow: () => void;
  onVideoEnd: () => void;
  onSwipeUp: () => void;
  onSwipeDown: () => void;
  onDoubleTap: (position?: Position) => void;
  onLongPress: (position?: Position) => void;
}

@Component
export struct VideoCard {
  @Prop video: VideoItem;
  @Prop isActive: boolean = false;
  @Prop onLike: () => void = () => {};
  @Prop onFollow: () => void = () => {};
  @Prop onVideoEnd: () => void = () => {};
  @Prop onSwipeUp: () => void = () => {};
  @Prop onSwipeDown: () => void = () => {};
  @Prop onDoubleTap: (position?: { x: number; y: number }) => void = () => {};
  @Prop onLongPress: (position?: { x: number; y: number }) => void = () => {};

  @State isPlaying: boolean = true;
  @State isMuted: boolean = true;
  @State showControls: boolean = false;
  @State progress: number = 0;
  @State floatingHearts: Array<{ id: string; x: number; y: number; opacity: number; scale: number }> = [];

  private videoController: VideoController = new VideoController();

  aboutToAppear(): void {
    if (this.isActive) {
      this.playVideo();
    }
  }

  aboutToDisappear(): void {
    this.pauseVideo();
  }

  /**
   * 播放视频
   */
  private playVideo(): void {
    this.isPlaying = true;
    this.videoController.start();
  }

  /**
   * 暂停视频
   */
  private pauseVideo(): void {
    this.isPlaying = false;
    this.videoController.pause();
  }

  /**
   * 切换播放状态
   */
  private togglePlayState(): void {
    if (this.isPlaying) {
      this.pauseVideo();
    } else {
      this.playVideo();
    }
  }

  /**
   * 切换静音状态
   */
  private toggleMuteState(): void {
    this.isMuted = !this.isMuted;
  }

  /**
   * 视频进度更新
   */
  private onProgressUpdate(time: number): void {
    if (this.video && this.video.duration) {
      this.progress = (time / this.video.duration) * 100;
    }
  }

  /**
   * 视频播放结束
   */
  private onPlaybackEnd(): void {
    this.onVideoEnd();
  }

  /**
   * 创建爱心飘散效果
   */
  private createFloatingHearts(x: number, y: number): void {
    const hearts = heartFloatAnimation.createHearts(x, y, 6);
    this.floatingHearts = [...this.floatingHearts, ...hearts];

    // 3秒后清除爱心
    setTimeout(() => {
      this.floatingHearts = this.floatingHearts.filter(h => !hearts.includes(h));
    }, 1000);
  }

  build() {
    Stack() {
      // 视频背景
      this.VideoBackground()

      // 渐变遮罩
      this.GradientOverlay()

      // 视频内容
      Column() {
        Blank()

        // 主要内容区域
        Row() {
          // 左侧信息区域
          Column() {
            this.VideoInfo()
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .padding({ left: Spacing.md })

          // 右侧操作栏
          Column() {
            this.VideoActions()
          }
          .width(ComponentSizes.videoAction.rightWidth)
          .alignItems(HorizontalAlign.Center)
          .padding({ right: Spacing.md })
        }
        .padding({ bottom: Spacing.lg + LayoutHelper.getIndicatorHeight() })
      }

      // 静音图标
      if (this.isMuted) {
        this.MuteIndicator()
      }

      // 播放/暂停指示器
      if (!this.isPlaying) {
        this.PlayIndicator()
      }

      // 浮动爱心
      ForEach(this.floatingHearts, (heart: any) => {
        this.FloatingHeart(heart)
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    .onClick(() => {
      // 单击点赞
      this.onLike();
    })
  }

  /**
   * 视频背景
   */
  @Builder
  VideoBackground() {
    Stack() {
      // 使用封面图片作为背景
      Image(this.video.cover || '')
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .alt('视频封面')
        .onClick(() => {
          this.togglePlayState();
        })
    }
    .width('100%')
    .height('100%')
  }

  /**
   * 渐变遮罩
   */
  @Builder
  GradientOverlay() {
    Column() {
      Blank()
      Row() {
        Column() {
          Blank()
          Column()
            .width('100%')
            .height(200)
            .linearGradient({
              colors: [
                ['#00000000', 0.0],
                ['#CC000000', 0.8]
              ],
              direction: GradientDirection.Bottom
            })
        }
      }
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }

  /**
   * 视频信息
   */
  @Builder
  VideoInfo() {
    Column() {
      // 创作者信息
      Row() {
        Text(`@${this.video.creator?.name || '用户'}`)
          .fontSize(Typography.fontSize.lg)
          .fontColor(Colors.textPrimary)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (!this.video.creator?.isFollowed) {
          Button('关注')
            .fontSize(Typography.fontSize.sm)
            .fontColor(Colors.textPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(ComponentSizes.borderRadius.sm)
            .margin({ left: Spacing.sm })
            .height(28)
            .padding({ left: Spacing.md, right: Spacing.md })
            .onClick(() => {
              this.onFollow();
            })
        }
      }
      .margin({ bottom: Spacing.sm })
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 视频描述
      Text(this.video.description || '')
        .fontSize(Typography.fontSize.base)
        .fontColor(Colors.textPrimary)
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .lineHeight(Typography.lineHeight.normal)
        .margin({ bottom: Spacing.sm })

      // 音乐信息
      Row() {
        Text('🎵')
          .fontSize(16)
          .fontColor(Colors.textPrimary)

        Text(`${this.video.musicTitle || '未知音乐'} - ${this.video.musicAuthor || '未知艺术家'}`)
          .fontSize(Typography.fontSize.base)
          .fontColor(Colors.textPrimary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ left: Spacing.xs })
      }
    }
    .width('70%')
    .alignItems(HorizontalAlign.Start)
  }

  /**
   * 视频操作按钮
   */
  @Builder
  VideoActions() {
    Column({ space: Spacing.md }) {
      // 头像
      this.AvatarButton()

      // 点赞
      this.ActionButton({
        icon: this.video.isLiked ? '❤️' : '🤍',
        count: this.formatCount(this.video.likes || 0),
        isActive: this.video.isLiked,
        onClick: () => this.onLike()
      })

      // 评论
      this.ActionButton({
        icon: '💬',
        count: this.formatCount(this.video.comments || 0),
        isActive: false,
        onClick: () => {
          // 打开评论面板
        }
      })

      // 分享
      this.ActionButton({
        icon: '↗️',
        count: this.formatCount(this.video.shares || 0),
        isActive: false,
        onClick: () => {
          // 分享功能
        }
      })

      // 音乐唱片
      this.MusicDisc()
    }
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 头像按钮
   */
  @Builder
  AvatarButton() {
    Stack() {
      // 头像
      Image(this.video.creator?.avatar || '')
        .width(ComponentSizes.videoAction.avatarSize)
        .height(ComponentSizes.videoAction.avatarSize)
        .borderRadius(ComponentSizes.borderRadius.full)
        .objectFit(ImageFit.Cover)
        .border({
          width: 2,
          color: Colors.textPrimary
        })

      // 关注按钮
      if (!this.video.creator?.isFollowed) {
        Circle({ width: 16, height: 16 })
          .fill(Colors.primary)
          .position({ x: ComponentSizes.videoAction.avatarSize - 8, y: ComponentSizes.videoAction.avatarSize - 8 })
          .onClick(() => {
            this.onFollow();
          })
      }
    }
    .onClick(() => {
      // 跳转到用户主页
    })
  }

  /**
   * 操作按钮
   */
  @Builder
  ActionButton(params: ActionButtonParams) {
    Column({ space: Spacing.xs }) {
      Text(params.icon)
        .fontSize(32)
        .fontColor(params.isActive ? Colors.primary : Colors.textPrimary)
        .animation({
          duration: ANIMATION_CONFIG.QUICK_SCALE.duration,
          curve: ANIMATION_CONFIG.QUICK_SCALE.curve
        })

      Text(params.count)
        .fontSize(Typography.fontSize.sm)
        .fontColor(Colors.textPrimary)
        .fontWeight(FontWeight.Medium)
    }
    .onClick(() => {
      params.onClick();
    })
    .gesture(
      TapGesture()
        .onAction(() => {
          // 添加点击缩放动画
        })
    )
  }

  /**
   * 音乐唱片
   */
  @Builder
  MusicDisc() {
    Stack() {
      // 唱片背景
      Circle({ width: 48, height: 48 })
        .fill(Colors.surface)
        .border({
          width: 2,
          color: Colors.textPrimary
        })

      // 唱片中心
      Circle({ width: 16, height: 16 })
        .fill(Colors.primary)
    }
    .onClick(() => {
      // 跳转到音乐页面
    })
  }

  /**
   * 静音指示器
   */
  @Builder
  MuteIndicator() {
    Row() {
      Text('🔇')
        .fontSize(24)
        .fontColor(Colors.textPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor('rgba(0, 0, 0, 0.5)')
    .borderRadius(ComponentSizes.borderRadius.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .position({ x: Spacing.md, y: LayoutHelper.getStatusBarHeight() + Spacing.md })
    .onClick(() => {
      this.toggleMuteState();
    })
  }

  /**
   * 播放指示器
   */
  @Builder
  PlayIndicator() {
    Stack() {
      Circle({ width: 64, height: 64 })
        .fill('rgba(0, 0, 0, 0.7)')

      Text(this.isPlaying ? '⏸️' : '▶️')
        .fontSize(24)
        .fontColor(Colors.textPrimary)
    }
    .alignContent(Alignment.Center)
  }

  /**
   * 飘动的爱心
   */
  @Builder
  FloatingHeart(heart: { id: string; x: number; y: number; opacity: number; scale: number }) {
    Text('❤️')
      .fontSize(20 + heart.scale * 10)
      .fontColor(Colors.primary)
      .opacity(heart.opacity)
      .position({ x: heart.x, y: heart.y })
      .animation({
        duration: 1000,
        curve: Curve.EaseOut
      })
  }

  /**
   * 格式化数字显示
   */
  private formatCount(count: number): string {
    if (count < 1000) {
      return count.toString();
    } else if (count < 10000) {
      return (count / 1000).toFixed(1) + 'k';
    } else {
      return (count / 10000).toFixed(1) + '万';
    }
  }
}