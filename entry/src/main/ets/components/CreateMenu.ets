import { Colors, Typography, Spacing, ComponentSizes } from '../styles/theme';
import { LayoutHelper } from '../utils/layout';

/**
 * 创建菜单组件
 * 底部弹出的创建选项菜单
 */

interface CreateMenuProps {
  onClose: () => void;
}

@Component
export struct CreateMenu {
  @Prop onClose: () => void = () => {};

  build() {
    Stack() {
      // 背景遮罩
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.overlayDark)
        .onClick(() => {
          this.onClose();
        })

      // 菜单内容
      Column() {
        Blank()

        Column({ space: Spacing.lg }) {
          // 标题
          Row() {
            Text('创作中心')
              .fontSize(Typography.fontSize.xxl)
              .fontColor(Colors.textPrimary)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: Spacing.md })

          // 创建选项
          Column({ space: Spacing.md }) {
            this.CreateOption({
              icon: '🎥',
              title: '拍摄视频',
              description: '录制精彩瞬间',
              color: Colors.primary,
              onClick: () => {
                this.handleCreateVideo();
              }
            })

            this.CreateOption({
              icon: '📹',
              title: '上传视频',
              description: '分享你的作品',
              color: Colors.secondary,
              onClick: () => {
                this.handleUploadVideo();
              }
            })

            this.CreateOption({
              icon: '🔴',
              title: '开启直播',
              description: '与粉丝互动',
              color: Colors.accent,
              onClick: () => {
                this.handleStartLive();
              }
            })

            this.CreateOption({
              icon: '✏️',
              title: '图文创作',
              description: '分享图文故事',
              color: Colors.textSecondary,
              onClick: () => {
                this.handleCreatePost();
              }
            })
          }

          // 取消按钮
          Button('取消')
            .width('100%')
            .height(48)
            .fontSize(Typography.fontSize.lg)
            .fontColor(Colors.textPrimary)
            .backgroundColor(Colors.surface)
            .borderRadius(ComponentSizes.borderRadius.md)
            .margin({ top: Spacing.md })
            .onClick(() => {
              this.onClose();
            })
        }
        .width('100%')
        .backgroundColor(Colors.frostedGlassDark)
        .backdropBlur(12)
        .borderRadius({
          topLeft: ComponentSizes.borderRadius.xl,
          topRight: ComponentSizes.borderRadius.xl
        })
        .padding({ top: Spacing.xl, bottom: Spacing.xxl })
        .border({
          width: { top: 0.5 },
          color: Colors.borderLight,
          opacity: 0.3
        })
        .animation({
          duration: 220,
          curve: Curve.EaseOut
        })
      }
    }
    .width('100%')
    .height('100%')
    .zIndex(40)
  }

  /**
   * 创建选项
   */
  @Builder
  CreateOption(params: {
    icon: string;
    title: string;
    description: string;
    color: string;
    onClick: () => void;
  }) {
    Row() {
      // 图标
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(params.color + '20') // 20% 透明度

        Text(params.icon)
          .fontSize(24)
          .fontColor(params.color)
      }
      .margin({ right: Spacing.md })

      // 文字信息
      Column() {
        Text(params.title)
          .fontSize(Typography.fontSize.lg)
          .fontColor(Colors.textPrimary)
          .fontWeight(FontWeight.Medium)

        Text(params.description)
          .fontSize(Typography.fontSize.base)
          .fontColor(Colors.textSecondary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 箭头图标
      Text('>')
        .fontSize(20)
        .fontColor(Colors.textTertiary)
    }
    .width('100%')
    .height(64)
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(ComponentSizes.borderRadius.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      params.onClick();
    })
    .gesture(
      TapGesture()
        .onAction(() => {
          // 添加点击反馈动画
        })
    )
  }

  /**
   * 处理拍摄视频
   */
  private handleCreateVideo(): void {
    console.log('Create video clicked');
    this.onClose();
    // 跳转到拍摄页面
  }

  /**
   * 处理上传视频
   */
  private handleUploadVideo(): void {
    console.log('Upload video clicked');
    this.onClose();
    // 跳转到上传页面
  }

  /**
   * 处理开始直播
   */
  private handleStartLive(): void {
    console.log('Start live clicked');
    this.onClose();
    // 跳转到直播页面
  }

  /**
   * 处理图文创作
   */
  private handleCreatePost(): void {
    console.log('Create post clicked');
    this.onClose();
    // 跳转到图文创作页面
  }
}