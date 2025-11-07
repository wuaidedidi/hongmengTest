import { VideoItem, Friend, Notification, Creator } from '../models/types';

/**
 * 模拟数据服务
 * 提供示例视频、好友、通知等数据
 */

// 模拟创作者数据
const mockCreators: Creator[] = [
  {
    id: '1',
    name: '时尚博主小王',
    avatar: 'https://images.unsplash.com/photo-1494790108755-2616b9120db3?w=48&h=48&fit=crop&crop=face',
    isFollowed: false,
    verified: true
  },
  {
    id: '2',
    name: '美食家阿明',
    avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=48&h=48&fit=crop&crop=face',
    isFollowed: false,
    verified: true
  },
  {
    id: '3',
    name: '旅行达人小李',
    avatar: 'https://images.unsplash.com/photo-1507591064344-4c6ce005b128?w=48&h=48&fit=crop&crop=face',
    isFollowed: true,
    verified: false
  },
  {
    id: '4',
    name: '科技探索者',
    avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=48&h=48&fit=crop&crop=face',
    isFollowed: false,
    verified: true
  },
  {
    id: '5',
    name: '宠物乐园',
    avatar: 'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?w=48&h=48&fit=crop&crop=face',
    isFollowed: true,
    verified: false
  },
  {
    id: '6',
    name: '健身教练阿强',
    avatar: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=48&h=48&fit=crop&crop=face',
    isFollowed: false,
    verified: true
  }
];

// 模拟视频数据
export const mockVideos: VideoItem[] = [
  {
    id: '1',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
    cover: 'https://images.unsplash.com/photo-1603233842167-ff91cab9e6ae?w=1080&h=1920&fit=crop',
    creator: mockCreators[0],
    description: '今天分享一套超显气质的街头穿搭 🔥 #OOTD #穿搭分享 #时尚',
    musicTitle: 'City Lights',
    musicAuthor: 'DJ Star',
    likes: 125000,
    comments: 3200,
    shares: 856,
    isMuted: true,
    isLiked: false,
    duration: 30
  },
  {
    id: '2',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
    cover: 'https://images.unsplash.com/photo-1636647511414-c9ec06da32bc?w=1080&h=1920&fit=crop',
    creator: mockCreators[1],
    description: '今天做个快手早餐 🥐 简单又好吃 #美食 #早餐 #关注更新',
    musicTitle: 'Morning Vibe',
    musicAuthor: 'Chill Beats',
    likes: 82000,
    comments: 1800,
    shares: 567,
    isMuted: true,
    isLiked: false,
    duration: 45
  },
  {
    id: '3',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
    cover: 'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=1080&h=1920&fit=crop',
    creator: mockCreators[2],
    description: '巴厘岛的绝美日落 🌅 这一刻真的太美了 #旅行 #巴厘岛 #日落',
    musicTitle: 'Island Dreams',
    musicAuthor: 'Tropical Vibes',
    likes: 256000,
    comments: 5600,
    shares: 2300,
    isMuted: true,
    isLiked: true,
    duration: 60
  },
  {
    id: '4',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
    cover: 'https://images.unsplash.com/photo-1550745165-9bc0b252726a?w=1080&h=1920&fit=crop',
    creator: mockCreators[3],
    description: '最新科技产品开箱 💫 这次真的太酷了 #科技 #开箱 #数码',
    musicTitle: 'Digital Future',
    musicAuthor: 'Synthwave',
    likes: 98000,
    comments: 2100,
    shares: 890,
    isMuted: true,
    isLiked: false,
    duration: 35
  },
  {
    id: '5',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
    cover: 'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=1080&h=1920&fit=crop',
    creator: mockCreators[4],
    description: '猫咪的日常真是太可爱了 🐱 #宠物 #猫咪 #可爱',
    musicTitle: 'Happy Moments',
    musicAuthor: 'Pet Lovers',
    likes: 320000,
    comments: 8900,
    shares: 4500,
    isMuted: true,
    isLiked: true,
    duration: 25
  },
  {
    id: '6',
    url: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
    cover: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=1080&h=1920&fit=crop',
    creator: mockCreators[5],
    description: '居家健身教程 💪 每天30分钟让你变更强 #健身 #运动 #健康',
    musicTitle: 'Workout Power',
    musicAuthor: 'Gym Beats',
    likes: 156000,
    comments: 3400,
    shares: 1200,
    isMuted: true,
    isLiked: false,
    duration: 40
  }
];

// 模拟好友数据
export const mockFriends: Friend[] = [
  {
    id: '1',
    name: '张小明',
    avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=48&h=48&fit=crop&crop=face',
    isOnline: true,
    status: '正在看视频'
  },
  {
    id: '2',
    name: '李小红',
    avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=48&h=48&fit=crop&crop=face',
    isOnline: true,
    status: '在线'
  },
  {
    id: '3',
    name: '王大锤',
    avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=48&h=48&fit=crop&crop=face',
    isOnline: false,
    lastSeen: '5分钟前'
  },
  {
    id: '4',
    name: '刘小花',
    avatar: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=48&h=48&fit=crop&crop=face',
    isOnline: true,
    status: '正在直播'
  },
  {
    id: '5',
    name: '陈小军',
    avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=48&h=48&fit=crop&crop=face',
    isOnline: false,
    lastSeen: '2小时前'
  }
];

// 模拟通知数据
export const mockNotifications: Notification[] = [
  {
    id: '1',
    type: 'like',
    content: '张小明 赞了你的视频',
    time: '2分钟前',
    read: false,
    avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=48&h=48&fit=crop&crop=face'
  },
  {
    id: '2',
    type: 'comment',
    content: '李小红 评论了你的视频：太棒了！',
    time: '5分钟前',
    read: false,
    avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=48&h=48&fit=crop&crop=face'
  },
  {
    id: '3',
    type: 'follow',
    content: '王大锤 开始关注你了',
    time: '1小时前',
    read: true,
    avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=48&h=48&fit=crop&crop=face'
  },
  {
    id: '4',
    type: 'system',
    content: '你的视频获得了1000个赞！',
    time: '3小时前',
    read: true,
    avatar: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=48&h=48&fit=crop&crop=face'
  },
  {
    id: '5',
    type: 'like',
    content: '刘小花 赞了你的视频',
    time: '5小时前',
    read: false,
    avatar: 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=48&h=48&fit=crop&crop=face'
  }
];

// 音乐数据
export const mockMusic = [
  {
    id: '1',
    title: 'City Lights',
    author: 'DJ Star',
    cover: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200&h=200&fit=crop'
  },
  {
    id: '2',
    title: 'Morning Vibe',
    author: 'Chill Beats',
    cover: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=200&h=200&fit=crop'
  },
  {
    id: '3',
    title: 'Island Dreams',
    author: 'Tropical Vibes',
    cover: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=200&h=200&fit=crop'
  }
];

// 数据服务类
export class DataService {
  /**
   * 获取推荐视频列表
   */
  static async getRecommendedVideos(): Promise<VideoItem[]> {
    // 模拟网络请求延迟
    await new Promise(resolve => setTimeout(resolve, 500));
    return [...mockVideos];
  }

  /**
   * 获取关注视频列表
   */
  static async getFollowingVideos(): Promise<VideoItem[]> {
    await new Promise(resolve => setTimeout(resolve, 500));
    // 返回已关注创作者的视频
    return mockVideos.filter(video => video.creator.isFollowed);
  }

  /**
   * 获取商城视频列表
   */
  static async getShopVideos(): Promise<VideoItem[]> {
    await new Promise(resolve => setTimeout(resolve, 500));
    return mockVideos.slice(0, 3);
  }

  /**
   * 获取团购视频列表
   */
  static async getGroupBuyVideos(): Promise<VideoItem[]> {
    await new Promise(resolve => setTimeout(resolve, 500));
    return mockVideos.slice(3, 6);
  }

  /**
   * 获取好友列表
   */
  static async getFriends(): Promise<Friend[]> {
    await new Promise(resolve => setTimeout(resolve, 300));
    return [...mockFriends];
  }

  /**
   * 获取通知列表
   */
  static async getNotifications(): Promise<Notification[]> {
    await new Promise(resolve => setTimeout(resolve, 300));
    return [...mockNotifications];
  }

  /**
   * 根据标签获取视频
   */
  static async getVideosByTab(tab: string): Promise<VideoItem[]> {
    switch (tab) {
      case '推荐':
        return this.getRecommendedVideos();
      case '关注':
        return this.getFollowingVideos();
      case '商城':
        return this.getShopVideos();
      case '团购':
        return this.getGroupBuyVideos();
      default:
        return this.getRecommendedVideos();
    }
  }

  /**
   * 搜索用户
   */
  static async searchUsers(query: string): Promise<Creator[]> {
    await new Promise(resolve => setTimeout(resolve, 300));
    return mockCreators.filter(creator =>
      creator.name.toLowerCase().includes(query.toLowerCase())
    );
  }

  /**
   * 加载更多视频
   */
  static async loadMoreVideos(currentVideos: VideoItem[], tab: string): Promise<VideoItem[]> {
    await new Promise(resolve => setTimeout(resolve, 800));

    // 模拟加载更多视频（在实际应用中这里会调用API）
    const moreVideos = mockVideos.map((video, index) => ({
      ...video,
      id: `${video.id}_more_${currentVideos.length + index}`,
      description: video.description + ' (新内容)'
    }));

    return [...currentVideos, ...moreVideos];
  }

  /**
   * 上报用户行为
   */
  static async trackUserAction(action: string, data: any): Promise<void> {
    // 模拟数据上报
    console.log('User Action:', action, data);
    await new Promise(resolve => setTimeout(resolve, 100));
  }
}