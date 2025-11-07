/**
 * 数据模型定义
 * 定义应用中使用的所有数据类型
 */

// 创作者信息
export interface Creator {
  id: string;
  name: string;
  avatar: string;
  isFollowed: boolean;
  verified: boolean;
}

// 视频项
export interface VideoItem {
  id: string;
  url: string;        // 视频源
  cover: string;      // 封面
  creator: Creator;
  description: string;
  musicTitle: string;    // 《歌曲名》
  musicAuthor: string;   // - 创作者
  likes: number;
  comments: number;
  shares: number;
  isMuted: boolean;
  isLiked: boolean;
  duration: number;
}

// 好友信息
export interface Friend {
  id: string;
  name: string;
  avatar: string;
  isOnline: boolean;
  lastSeen?: string;
  status?: string;
}

// 通知信息
export interface Notification {
  id: string;
  type: 'like' | 'comment' | 'follow' | 'system';
  content: string;
  time: string;
  read: boolean;
  avatar: string;
}

// 顶部标签类型
export type TopTab = '推荐' | '关注' | '商城' | '团购';

// 底部导航类型
export type BottomTab = 'home' | 'friends' | 'create' | 'messages' | 'profile';

// 手势事件类型
export interface GestureEvent {
  type: 'tap' | 'doubleTap' | 'longPress' | 'swipeUp' | 'swipeDown' | 'swipeLeft' | 'swipeRight';
  velocity?: number;
  distance?: number;
  position?: { x: number; y: number };
}

// 动画配置
export interface AnimationConfig {
  duration: number;
  curve: 'linear' | 'ease' | 'easeIn' | 'easeOut' | 'easeInOut' | 'spring' | 'elastic';
  delay?: number;
}

// 视频播放状态
export interface VideoPlayState {
  currentIndex: number;
  isPlaying: boolean;
  isMuted: boolean;
  progress: number;
  duration: number;
}

// 应用全局状态
export interface AppState {
  // 导航状态
  activeTopTab: TopTab;
  activeBottomTab: BottomTab;

  // 视频状态
  currentVideoIndex: number;
  videos: VideoItem[];
  videoPlayState: VideoPlayState;

  // 交互状态
  isFriendsDrawerOpen: boolean;
  isCreateMenuOpen: boolean;
  isFullscreen: boolean;

  // 数据状态
  unreadCount: number;
  friends: Friend[];
  notifications: Notification[];

  // 用户偏好
  followedCreators: string[];
  likedVideos: string[];
}