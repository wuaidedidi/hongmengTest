import { Colors, Typography, Spacing } from '../styles/theme';
import { LayoutHelper } from '../utils/layout';

/**
 * 顶部标签栏组件
 * 四个标签：推荐、关注、商城、团购
 */

interface TopTabsProps {
  activeTab: string;
  onTabChange: (tab: string) => void;
}

@Component
export struct TopTabs {
  @Prop activeTab: string = '推荐';
  @Prop onTabChange: (tab: string) => void = () => {};

  private tabs = ['推荐', '关注', '商城', '团购'];

  build() {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        Column() {
          // 标签文本
          Text(tab)
            .fontSize(Typography.fontSize.lg)
            .fontColor(this.activeTab === tab ? Colors.textPrimary : Colors.textSecondary)
            .fontWeight(this.activeTab === tab ? FontWeight.Medium : FontWeight.Normal)
            .animation({
              duration: 200,
              curve: Curve.EaseInOut
            })

          // 下划线指示器
          if (this.activeTab === tab) {
            Row()
              .width(20)
              .height(3)
              .backgroundColor(Colors.primary)
              .borderRadius(2)
              .margin({ top: 6 })
              .animation({
                duration: 200,
                curve: Curve.EaseInOut
              })
          } else {
            Row()
              .width(20)
              .height(3)
              .backgroundColor(Color.Transparent)
              .margin({ top: 6 })
          }
        }
        .layoutWeight(1)
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.onTabChange(tab);
        })
        .gesture(
          TapGesture()
            .onAction(() => {
              // 添加轻微的点击反馈动画
              this.createTabClickAnimation(tab);
            })
        )
      })
    }
    .width('100%')
    .height(56)
    .backgroundColor(Colors.background)
    .justifyContent(FlexAlign.SpaceAround)
    .padding({ left: Spacing.md, right: Spacing.md })
    .zIndex(30) // 确保在其他内容之上
    .border({
      width: { bottom: 0.5 },
      color: Colors.border
    })
  }

  /**
   * 创建标签点击动画
   */
  private createTabClickAnimation(tab: string): void {
    // 这里可以添加点击反馈动画
    // 例如：轻微缩放、颜色变化等
  }

  /**
   * 计算指示器位置
   */
  private getIndicatorPosition(tab: string): number {
    const index = this.tabs.indexOf(tab);
    const tabWidth = LayoutHelper.getScreenWidth() / this.tabs.length;
    return index * tabWidth + tabWidth / 2;
  }
}

/**
 * 滑动指示器组件（可选实现）
 */
@Component
export struct TabIndicator {
  @Prop activeTab: string = '推荐';
  @Prop tabs: string[] = ['推荐', '关注', '商城', '团购'];

  @State indicatorPosition: number = 0;

  aboutToAppear(): void {
    this.updateIndicatorPosition(this.activeTab);
  }

  /**
   * 更新指示器位置
   */
  private updateIndicatorPosition(tab: string): void {
    const index = this.tabs.indexOf(tab);
    const screenWidth = LayoutHelper.getScreenWidth();
    const tabWidth = screenWidth / this.tabs.length;
    this.indicatorPosition = index * tabWidth + tabWidth / 2;
  }

  build() {
    Stack() {
      // 背景
      Row()
        .width('100%')
        .height(56)
        .backgroundColor(Colors.background)

      // 指示器
      Circle({ width: 4, height: 4 })
        .fill(Colors.primary)
        .position({ x: this.indicatorPosition - 2, y: 52 })
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
        })
    }
    .width('100%')
    .height(56)
  }
}