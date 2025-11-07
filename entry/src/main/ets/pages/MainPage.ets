import { appStore } from '../store/appStore';
import { TopTabs } from '../components/TopTabs';
import { BottomNavBar } from '../components/BottomNavBar';
import { VideoCard } from '../components/VideoCard';
import { FriendsDrawer } from '../components/FriendsDrawer';
import { CreateMenu } from '../components/CreateMenu';
import { DataService } from '../services/mockData';
import { LayoutHelper } from '../utils/layout';
import { Colors } from '../styles/theme';
import { VideoItem } from '../models/types';

/**
 * 主页面 - 抖音风格的短视频应用
 * 全屏沉浸式视频流界面
 */

@Entry
@Component
struct MainPage {
  @State currentTab: string = '推荐';
  @State videos: VideoItem[] = [];
  @State isLoading: boolean = true;
  @State currentVideoIndex: number = 0;
  @State isFriendsDrawerOpen: boolean = false;
  @State isCreateMenuOpen: boolean = false;

  private swiperController: SwiperController = new SwiperController();

  aboutToAppear(): void {
    // 订阅状态变化
    appStore.subscribe(() => {
      this.updateFromStore();
    });

    // 初始化数据
    this.initializeData();
  }

  aboutToDisappear(): void {
    // 清理资源
  }

  /**
   * 从 store 更新状态
   */
  private updateFromStore(): void {
    const state = appStore.state;
    this.currentTab = state.activeTopTab;
    this.currentVideoIndex = state.currentVideoIndex;
    this.isFriendsDrawerOpen = state.isFriendsDrawerOpen;
    this.isCreateMenuOpen = state.isCreateMenuOpen;
  }

  /**
   * 初始化数据
   */
  private async initializeData(): Promise<void> {
    try {
      this.isLoading = true;
      const videos = await DataService.getVideosByTab(this.currentTab);
      appStore.setVideos(videos);
      this.videos = videos;
    } catch (error) {
      console.error('Failed to load videos:', error);
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 切换顶部标签
   */
  private async onTabChange(tab: string): Promise<void> {
    if (tab === this.currentTab) return;

    this.currentTab = tab;
    appStore.setActiveTopTab(tab as '推荐' | '关注' | '商城' | '团购');

    // 重新加载对应标签的视频
    await this.initializeData();

    // 重置到第一个视频
    this.currentVideoIndex = 0;
    appStore.goToVideo(0);
    this.swiperController.showNext();
  }

  /**
   * 视频切换处理
   */
  private onVideoIndexChanged(index: number): void {
    this.currentVideoIndex = index;
    appStore.goToVideo(index);
  }

  /**
   * 切换到下一个视频
   */
  private nextVideo(): void {
    const nextIndex = Math.min(this.currentVideoIndex + 1, this.videos.length - 1);
    this.swiperController.showNext();
  }

  /**
   * 切换到上一个视频
   */
  private prevVideo(): void {
    const prevIndex = Math.max(this.currentVideoIndex - 1, 0);
    this.swiperController.showPrevious();
  }

  /**
   * 切换好友抽屉
   */
  private toggleFriendsDrawer(): void {
    appStore.toggleFriendsDrawer();
  }

  /**
   * 切换创建菜单
   */
  private toggleCreateMenu(): void {
    appStore.toggleCreateMenu();
  }

  build() {
    Stack() {
      // 主内容区域
      Column() {
        // 视频播放区域
        Stack() {
          if (this.isLoading) {
            // 加载中状态
            this.LoadingView()
          } else if (this.videos.length === 0) {
            // 空状态
            this.EmptyView()
          } else {
            // 视频轮播
            this.VideoPlayerView()
          }
        }
        .layoutWeight(1)
        .width('100%')

        // 顶部标签栏
        TopTabs({
          activeTab: this.currentTab,
          onTabChange: (tab: string) => this.onTabChange(tab)
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // 底部导航栏
      BottomNavBar({
        activeTab: appStore.state.activeBottomTab,
        onTabChange: (tab: string) => appStore.setActiveBottomTab(tab as 'home' | 'friends' | 'create' | 'messages' | 'profile'),
        onFriendsClick: () => this.toggleFriendsDrawer(),
        onCreateClick: () => this.toggleCreateMenu()
      })

      // 好友抽屉
      if (this.isFriendsDrawerOpen) {
        FriendsDrawer({
          onClose: () => appStore.toggleFriendsDrawer()
        })
      }

      // 创建菜单
      if (this.isCreateMenuOpen) {
        CreateMenu({
          onClose: () => appStore.toggleCreateMenu()
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  /**
   * 加载视图
   */
  @Builder
  LoadingView() {
    Column() {
      LoadingProgress()
        .width(48)
        .height(48)
        .color(Colors.primary)

      Text('加载中...')
        .fontSize(16)
        .fontColor(Colors.textSecondary)
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 空状态视图
   */
  @Builder
  EmptyView() {
    Column() {
      Text('暂无内容')
        .fontSize(20)
        .fontColor(Colors.textSecondary)

      Text('当前标签下还没有视频')
        .fontSize(14)
        .fontColor(Colors.textTertiary)
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  /**
   * 视频播放器视图
   */
  @Builder
  VideoPlayerView() {
    Swiper(this.swiperController) {
      ForEach(this.videos, (video: VideoItem, index: number) => {
        VideoCard({
          video: video,
          isActive: index === this.currentVideoIndex,
          onLike: () => appStore.toggleLike(video.id),
          onFollow: () => appStore.toggleFollow(video.creator.id),
          onVideoEnd: () => {
            // 自动播放下一个视频
            if (index < this.videos.length - 1) {
              this.nextVideo();
            }
          },
          onSwipeUp: () => this.nextVideo(),
          onSwipeDown: () => this.prevVideo(),
          onDoubleTap: (position) => {
            // 双击点赞
            appStore.toggleLike(video.id);
          },
          onLongPress: (position) => {
            // 长按暂停/播放
            appStore.togglePlayState();
          }
        })
      })
    }
    .width('100%')
    .height('100%')
    .loop(false)
    .vertical(true)
    .indicator(false)
    .duration(300)
    .curve(Curve.EaseInOut)
    .onChange((index: number) => this.onVideoIndexChanged(index))
  }
}