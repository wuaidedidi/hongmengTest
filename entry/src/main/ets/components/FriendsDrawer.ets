import { Colors, Typography, Spacing, ComponentSizes } from '../styles/theme';
import { LayoutHelper } from '../utils/layout';
import { mockFriends } from '../services/mockData';

/**
 * 好友抽屉组件
 * 右侧滑出的好友列表
 */

interface FriendsDrawerProps {
  onClose: () => void;
}

@Component
export struct FriendsDrawer {
  @Prop onClose: () => void = () => {};

  @State friends: Array<{ id: string; name: string; avatar: string; isOnline: boolean; lastSeen?: string; status?: string }> = [];
  @State isLoading: boolean = true;

  aboutToAppear(): void {
    this.loadFriends();
  }

  /**
   * 加载好友列表
   */
  private async loadFriends(): Promise<void> {
    try {
      this.isLoading = true;
      // 模拟加载好友数据
      setTimeout(() => {
        this.friends = mockFriends;
        this.isLoading = false;
      }, 500);
    } catch (error) {
      console.error('Failed to load friends:', error);
      this.isLoading = false;
    }
  }

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

      // 抽屉内容
      Row() {
        Blank()

        Column() {
          // 头部
          this.DrawerHeader()

          // 好友列表
          if (this.isLoading) {
            this.LoadingView()
          } else if (this.friends.length === 0) {
            this.EmptyView()
          } else {
            this.FriendsList()
          }
        }
        .width(LayoutHelper.getDrawerSize().width)
        .height('100%')
        .backgroundColor(Colors.frostedGlassDark)
        .backdropBlur(12)
        .border({
          width: { left: 0.5 },
          color: Colors.borderLight
        })
        .animation({
          duration: 220,
          curve: Curve.EaseOut
        })
      }
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .zIndex(40)
  }

  /**
   * 抽屉头部
   */
  @Builder
  DrawerHeader() {
    Row() {
      Text('好友动态')
        .fontSize(Typography.fontSize.xl)
        .fontColor(Colors.textPrimary)
        .fontWeight(FontWeight.Medium)

      Blank()

      Text('✕')
        .fontSize(20)
        .fontColor(Colors.textSecondary)
        .onClick(() => {
          this.onClose();
        })
    }
    .width('100%')
    .padding(Spacing.md)
    .border({
      width: { bottom: 0.5 },
      color: Colors.borderLight
    })
  }

  /**
   * 加载视图
   */
  @Builder
  LoadingView() {
    Column() {
      LoadingProgress()
        .width(32)
        .height(32)
        .color(Colors.primary)

      Text('加载中...')
        .fontSize(Typography.fontSize.base)
        .fontColor(Colors.textSecondary)
        .margin({ top: Spacing.sm })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 空状态视图
   */
  @Builder
  EmptyView() {
    Column() {
      Text('暂无好友动态')
        .fontSize(Typography.fontSize.lg)
        .fontColor(Colors.textSecondary)

      Text('关注更多好友，发现精彩内容')
        .fontSize(Typography.fontSize.base)
        .fontColor(Colors.textTertiary)
        .margin({ top: Spacing.xs })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 好友列表
   */
  @Builder
  FriendsList() {
    List({ space: 0 }) {
      ForEach(this.friends, (friend: any) => {
        ListItem() {
          this.FriendItem(friend)
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
    .divider({
      strokeWidth: 0.5,
      color: Colors.borderLight,
      startMargin: Spacing.md,
      endMargin: Spacing.md
    })
  }

  /**
   * 好友项
   */
  @Builder
  FriendItem(friend: { id: string; name: string; avatar: string; isOnline: boolean; lastSeen?: string; status?: string }) {
    Row() {
      // 头像
      Stack() {
        Image(friend.avatar || '')
          .width(ComponentSizes.avatar.md)
          .height(ComponentSizes.avatar.md)
          .borderRadius(ComponentSizes.borderRadius.full)
          .objectFit(ImageFit.Cover)

        // 在线状态指示器
        if (friend.isOnline) {
          Circle({ width: 12, height: 12 })
            .fill(Colors.success)
            .position({ x: ComponentSizes.avatar.md - 6, y: ComponentSizes.avatar.md - 6 })
            .border({
              width: 2,
              color: Colors.background
            })
        }
      }
      .margin({ right: Spacing.md })

      // 好友信息
      Column() {
        Text(friend.name || '未知用户')
          .fontSize(Typography.fontSize.lg)
          .fontColor(Colors.textPrimary)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        if (friend.isOnline && friend.status) {
          Text(friend.status)
            .fontSize(Typography.fontSize.sm)
            .fontColor(Colors.success)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        } else if (!friend.isOnline && friend.lastSeen) {
          Text(friend.lastSeen)
            .fontSize(Typography.fontSize.sm)
            .fontColor(Colors.textTertiary)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // 操作按钮
      Button('查看')
        .fontSize(Typography.fontSize.sm)
        .fontColor(Colors.textPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(ComponentSizes.borderRadius.sm)
        .height(32)
        .padding({ left: Spacing.md, right: Spacing.md })
        .onClick(() => {
          // 跳转到好友详情页
        })
    }
    .width('100%')
    .padding(Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      // 查看好友主页
    })
  }
}