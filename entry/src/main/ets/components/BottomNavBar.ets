import { Colors, Typography, Spacing, ComponentSizes } from '../styles/theme';
import { LayoutHelper } from '../utils/layout';
import { appStore } from '../store/appStore';

/**
 * 底部导航栏组件
 * 五个图标：首页、好友、创建、消息、我的
 */

interface BottomNavBarProps {
  activeTab: string;
  onTabChange: (tab: string) => void;
  onFriendsClick: () => void;
  onCreateClick: () => void;
}

@Component
export struct BottomNavBar {
  @Prop activeTab: string = 'home';
  @Prop onTabChange: (tab: string) => void = () => {};
  @Prop onFriendsClick: () => void = () => {};
  @Prop onCreateClick: () => void = () => {};

  @State unreadCount: number = 0;

  aboutToAppear(): void {
    // 订阅未读数变化
    appStore.subscribe(() => {
      this.unreadCount = appStore.state.unreadCount;
    });
    this.unreadCount = appStore.state.unreadCount;
  }

  build() {
    Row() {
      // 首页
      this.NavItem({
        icon: '🏠',
        label: '首页',
        isActive: this.activeTab === 'home',
        onClick: () => this.onTabChange('home')
      })

      // 好友
      this.NavItem({
        icon: '👥',
        label: '好友',
        isActive: this.activeTab === 'friends',
        onClick: () => this.onFriendsClick(),
        showBadge: true,
        badgeCount: this.unreadCount
      })

      // 创建按钮
      this.CreateButton()

      // 消息
      this.NavItem({
        icon: '💬',
        label: '消息',
        isActive: this.activeTab === 'messages',
        onClick: () => this.onTabChange('messages'),
        showBadge: this.unreadCount > 0,
        badgeCount: this.unreadCount
      })

      // 我的
      this.NavItem({
        icon: '👤',
        label: '我',
        isActive: this.activeTab === 'profile',
        onClick: () => this.onTabChange('profile')
      })
    }
    .width('100%')
    .height(LayoutHelper.getBottomBarHeight())
    .backgroundColor(Colors.frostedGlassDark)
    .backdropBlur(12)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Bottom)
    .border({
      width: { top: 0.5 },
      color: Colors.borderLight,
      opacity: 0.3
    })
    .padding({ bottom: LayoutHelper.getIndicatorHeight() })
    .zIndex(30)
  }

  /**
   * 导航项组件
   */
  @Builder
  NavItem(params: {
    icon: string;
    label: string;
    isActive: boolean;
    onClick: () => void;
    showBadge?: boolean;
    badgeCount?: number;
  }) {
    Column() {
      Stack() {
        // 图标
        Text(params.icon)
          .fontSize(ComponentSizes.icon.lg)
          .fontColor(params.isActive ? Colors.textPrimary : Colors.textSecondary)
          .animation({
            duration: 200,
            curve: Curve.EaseInOut
          })

        // 徽章
        if (params.showBadge && params.badgeCount && params.badgeCount > 0) {
          this.Badge({ count: params.badgeCount })
        }
      }
      .alignContent(Alignment.TopEnd)

      // 标签
      Text(params.label)
        .fontSize(Typography.fontSize.sm)
        .fontColor(params.isActive ? Colors.textPrimary : Colors.textSecondary)
        .margin({ top: 4 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .layoutWeight(1)
    .height(ComponentSizes.navigation.bottom.height)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      params.onClick();
    })
    .gesture(
      TapGesture()
        .onAction(() => {
          // 添加点击反馈动画
          this.createClickAnimation();
        })
    )
    .padding({ vertical: Spacing.xs })
  }

  /**
   * 创建按钮（中间的加号）
   */
  @Builder
  CreateButton() {
    Column() {
      Stack({
        alignContent: Alignment.Center
      }) {
        // 背景圆圈
        Circle({ width: 48, height: 48 })
          .fill(Colors.primary)
          .shadow({
            radius: 8,
            color: Colors.primary,
            offsetX: 0,
            offsetY: 2
          })

        // 加号图标
        Text('+')
          .fontSize(28)
          .fontColor(Colors.textPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .onClick(() => {
        this.onCreateClick();
        this.createButtonClickAnimation();
      })
    }
    .layoutWeight(1)
    .height(ComponentSizes.navigation.bottom.height)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 徽章组件
   */
  @Builder
  Badge(params: { count: number }) {
    if (params.count <= 99) {
      Text(params.count.toString())
        .fontSize(10)
        .fontColor(Colors.textPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(8)
        .width(16)
        .height(16)
        .textAlign(TextAlign.Center)
        .position({ x: 12, y: -4 })
    } else {
      Text('99+')
        .fontSize(8)
        .fontColor(Colors.textPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(10)
        .width(20)
        .height(16)
        .textAlign(TextAlign.Center)
        .position({ x: 14, y: -4 })
    }
  }

  /**
   * 创建点击动画
   */
  private createClickAnimation(): void {
    // 轻微缩放反馈动画
  }

  /**
   * 创建按钮点击动画
   */
  private createButtonClickAnimation(): void {
    // 创建按钮的弹性动画
  }
}

/**
 * 毛玻璃效果容器
 */
@Component
export struct FrostedGlassContainer {
  @BuilderParam content: () => void;

  build() {
    Stack() {
      // 毛玻璃背景
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.frostedGlassDark)
        .backdropBlur(12)
        .border({
          width: { top: 0.5 },
          color: Colors.borderLight,
          opacity: 0.3
        })

      // 内容
      this.content()
    }
  }
}