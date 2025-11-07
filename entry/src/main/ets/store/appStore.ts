import { AppState, VideoItem, Friend, Notification, TopTab, BottomTab } from '../models/types';

/**
 * 应用全局状态管理
 * 使用简单的观察者模式实现状态响应式更新
 */

class AppStore {
  private _state: AppState;
  private _listeners: Set<() => void> = new Set();

  constructor() {
    this._state = {
      // 导航状态
      activeTopTab: '推荐',
      activeBottomTab: 'home',

      // 视频状态
      currentVideoIndex: 0,
      videos: [],
      videoPlayState: {
        currentIndex: 0,
        isPlaying: true,
        isMuted: true,
        progress: 0,
        duration: 0
      },

      // 交互状态
      isFriendsDrawerOpen: false,
      isCreateMenuOpen: false,
      isFullscreen: false,

      // 数据状态
      unreadCount: 8,
      friends: [],
      notifications: [],

      // 用户偏好
      followedCreators: [],
      likedVideos: []
    };
  }

  // 获取当前状态
  get state(): AppState {
    return this._state;
  }

  // 订阅状态变化
  subscribe(listener: () => void): () => void {
    this._listeners.add(listener);
    return () => {
      this._listeners.delete(listener);
    };
  }

  // 通知状态更新
  private notify(): void {
    this._listeners.forEach(listener => listener());
  }

  // 更新状态的通用方法
  private updateState(updates: Partial<AppState>): void {
    this._state = { ...this._state, ...updates };
    this.notify();
  }

  // 顶部标签切换
  setActiveTopTab(tab: TopTab): void {
    if (this._state.activeTopTab !== tab) {
      this.updateState({
        activeTopTab: tab,
        currentVideoIndex: 0 // 切换标签时重置视频索引
      });
    }
  }

  // 底部导航切换
  setActiveBottomTab(tab: BottomTab): void {
    if (this._state.activeBottomTab !== tab) {
      this.updateState({ activeBottomTab: tab });
    }
  }

  // 设置视频列表
  setVideos(videos: VideoItem[]): void {
    this.updateState({
      videos,
      currentVideoIndex: 0
    });
  }

  // 切换到下一个视频
  nextVideo(): void {
    const newIndex = Math.min(this._state.currentVideoIndex + 1, this._state.videos.length - 1);
    this.updateState({
      currentVideoIndex: newIndex,
      videoPlayState: {
        ...this._state.videoPlayState,
        currentIndex: newIndex,
        progress: 0
      }
    });
  }

  // 切换到上一个视频
  prevVideo(): void {
    const newIndex = Math.max(this._state.currentVideoIndex - 1, 0);
    this.updateState({
      currentVideoIndex: newIndex,
      videoPlayState: {
        ...this._state.videoPlayState,
        currentIndex: newIndex,
        progress: 0
      }
    });
  }

  // 跳转到指定视频
  goToVideo(index: number): void {
    if (index >= 0 && index < this._state.videos.length) {
      this.updateState({
        currentVideoIndex: index,
        videoPlayState: {
          ...this._state.videoPlayState,
          currentIndex: index,
          progress: 0
        }
      });
    }
  }

  // 切换播放状态
  togglePlayState(): void {
    this.updateState({
      videoPlayState: {
        ...this._state.videoPlayState,
        isPlaying: !this._state.videoPlayState.isPlaying
      }
    });
  }

  // 设置播放状态
  setPlayingState(isPlaying: boolean): void {
    this.updateState({
      videoPlayState: {
        ...this._state.videoPlayState,
        isPlaying
      }
    });
  }

  // 切换静音状态
  toggleMuteState(): void {
    this.updateState({
      videoPlayState: {
        ...this._state.videoPlayState,
        isMuted: !this._state.videoPlayState.isMuted
      }
    });
  }

  // 设置静音状态
  setMuteState(isMuted: boolean): void {
    this.updateState({
      videoPlayState: {
        ...this._state.videoPlayState,
        isMuted
      }
    });
  }

  // 更新播放进度
  updateProgress(progress: number): void {
    this.updateState({
      videoPlayState: {
        ...this._state.videoPlayState,
        progress: Math.min(progress, 100)
      }
    });
  }

  // 点赞操作
  toggleLike(videoId: string): void {
    const likedVideos = [...this._state.likedVideos];
    const isLiked = likedVideos.includes(videoId);

    if (isLiked) {
      // 取消点赞
      const index = likedVideos.indexOf(videoId);
      likedVideos.splice(index, 1);
    } else {
      // 添加点赞
      likedVideos.push(videoId);
    }

    // 更新视频列表中的点赞状态
    const videos = this._state.videos.map(video =>
      video.id === videoId
        ? { ...video, isLiked: !isLiked, likes: video.likes + (isLiked ? -1 : 1) }
        : video
    );

    this.updateState({
      videos,
      likedVideos
    });
  }

  // 关注操作
  toggleFollow(creatorId: string): void {
    const followedCreators = [...this._state.followedCreators];
    const isFollowed = followedCreators.includes(creatorId);

    if (isFollowed) {
      // 取消关注
      const index = followedCreators.indexOf(creatorId);
      followedCreators.splice(index, 1);
    } else {
      // 添加关注
      followedCreators.push(creatorId);
    }

    // 更新视频列表中的关注状态
    const videos = this._state.videos.map(video =>
      video.creator.id === creatorId
        ? {
            ...video,
            creator: { ...video.creator, isFollowed: !isFollowed }
          }
        : video
    );

    this.updateState({
      videos,
      followedCreators
    });
  }

  // 好友抽屉开关
  toggleFriendsDrawer(): void {
    this.updateState({
      isFriendsDrawerOpen: !this._state.isFriendsDrawerOpen
    });
  }

  // 创建菜单开关
  toggleCreateMenu(): void {
    this.updateState({
      isCreateMenuOpen: !this._state.isCreateMenuOpen
    });
  }

  // 设置好友列表
  setFriends(friends: Friend[]): void {
    this.updateState({ friends });
  }

  // 设置通知列表
  setNotifications(notifications: Notification[]): void {
    this.updateState({ notifications });
  }

  // 清除未读数
  clearUnreadCount(): void {
    this.updateState({ unreadCount: 0 });
  }

  // 设置全屏状态
  setFullscreen(isFullscreen: boolean): void {
    this.updateState({ isFullscreen });
  }

  // 获取当前视频
  getCurrentVideo(): VideoItem | null {
    return this._state.videos[this._state.currentVideoIndex] || null;
  }
}

// 创建全局 store 实例
export const appStore = new AppStore();