@Entry
@Component
struct VideoApp {
  @State activeTab: string = '推荐';
  @State activeBottomTab: string = 'home';
  @State isFriendsDrawerOpen: boolean = false;
  @State isCreateMenuOpen: boolean = false;

  build() {
    Stack() {
      // 主内容区域
      Column() {
        // 顶部导航栏
        Row() {
          ForEach(['团购', '关注', '商城', '推荐'], (tab: string) => {
            Button() {
              Text(tab)
                .fontSize(16)
                .fontColor(this.activeTab === tab ? Color.White : Color.Gray)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.activeTab = tab;
            })
            .margin({ left: 8, right: 8 })
          })
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.SpaceAround)
        .backgroundColor(Color.Black)
        .zIndex(30);

        // 视频流核心区域
        Stack() {
          // 显示当前视频
          if (this.activeTab === '推荐') {
            this.VideoItem(
              'https://images.unsplash.com/photo-1603233842167-ff91cab9e6ae?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx1cmJhbiUyMHN0cmVldCUyMGZhc2hpb258ZW58MXx8fHwxNzYyNDU1ODk3fDA&ixlib=rb-4.1.0&q=80&w=1080',
              '时尚博主小王',
              '今天分享一套超显气质的街头穿搭 🔥 #OOTD #穿搭分享',
              '《City Lights》 - DJ Star',
              '12.5万'
            )
          } else if (this.activeTab === '关注') {
            this.VideoItem(
              'https://images.unsplash.com/photo-1636647511414-c9ec06da32bc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjb29raW5nJTIwZm9vZCUyMGtpdGNoZW58ZW58MXx8fHwxNzYyNDU1ODA0fDA&ixlib=rb-4.1.0&q=80&w=1080',
              '美食家阿明',
              '今天做个快手早餐 🥐 #关注更新',
              '《Morning Vibe》 - Chill Beats',
              '8.2万'
            )
          } else {
            // 空状态
            Column() {
              Text('暂无内容')
                .fontSize(20)
                .fontColor(Color.White)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(Color.Black);

        // 底部导航栏
        Row() {
          // 首页
          Column() {
            Text('🏠')
              .fontSize(24)
              .fontColor(this.activeBottomTab === 'home' ? Color.White : Color.Gray)
            Text('首页')
              .fontSize(12)
              .fontColor(this.activeBottomTab === 'home' ? Color.White : Color.Gray)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.activeBottomTab = 'home';
          })

          // 好友
          Column() {
            Stack() {
              Text('👥')
                .fontSize(24)
                .fontColor(Color.Gray)
              Circle({ width: 8, height: 8 })
                .fill(Color.Green)
                .position({ x: 16, y: -2 })
            }
            Text('好友')
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.isFriendsDrawerOpen = true;
          })

          // 创建
          Column() {
            Text('+')
              .fontSize(28)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.isCreateMenuOpen = true;
          })

          // 消息
          Column() {
            Stack() {
              Text('💬')
                .fontSize(24)
                .fontColor(this.activeBottomTab === 'messages' ? Color.White : Color.Gray)
              Text('8')
                .fontSize(10)
                .fontColor(Color.White)
                .backgroundColor(Color.Red)
                .borderRadius(8)
                .width(16)
                .height(16)
                .textAlign(TextAlign.Center)
                .position({ x: 16, y: -4 })
            }
            Text('消息')
              .fontSize(12)
              .fontColor(this.activeBottomTab === 'messages' ? Color.White : Color.Gray)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.activeBottomTab = 'messages';
          })

          // 我
          Column() {
            Text('👤')
              .fontSize(24)
              .fontColor(this.activeBottomTab === 'profile' ? Color.White : Color.Gray)
            Text('我')
              .fontSize(12)
              .fontColor(this.activeBottomTab === 'profile' ? Color.White : Color.Gray)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.activeBottomTab = 'profile';
          })
        }
        .width('100%')
        .height(64)
        .backgroundColor(Color.Black)
        .opacity(0.9)
        .justifyContent(FlexAlign.SpaceAround)
        .border({ width: { top: 1 }, color: Color.White })
      }
      .width('100%')
      .height('100%')

      // 好友抽屉
      if (this.isFriendsDrawerOpen) {
        this.FriendsDrawer()
      }

      // 创建菜单
      if (this.isCreateMenuOpen) {
        this.CreateMenu()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }

  @Builder
  VideoItem(imageUrl: string, author: string, description: string, music: string, likes: string) {
    Stack() {
      // 背景图片
      Image(imageUrl)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .alt('视频内容')

      // 渐变遮罩
      Column() {
        Blank()
        Row() {
          Column() {
            Text(`@${author}`)
              .fontSize(16)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 8 })

            Text(description)
              .fontSize(14)
              .fontColor(Color.White)
              .maxLines(3)
              .margin({ bottom: 8 })

            Row() {
              Text('🎵')
                .fontSize(16)
              Text(music)
                .fontSize(14)
                .fontColor(Color.White)
                .margin({ left: 4 })
            }
          }
          .alignItems(HorizontalAlign.Start)
          .width('70%')

          // 右侧操作栏
          Column({ space: 16 }) {
            // 头像
            Circle({ width: 48, height: 48 })
              .fill(Color.Gray)
              .border({ width: 2, color: Color.White })

            // 点赞
            Column() {
              Text('🤍')
                .fontSize(32)
              Text(likes)
                .fontSize(12)
                .fontColor(Color.White)
            }

            // 评论
            Column() {
              Text('💬')
                .fontSize(32)
              Text('3.2千')
                .fontSize(12)
                .fontColor(Color.White)
            }

            // 分享
            Column() {
              Text('↗️')
                .fontSize(32)
              Text('856')
                .fontSize(12)
                .fontColor(Color.White)
            }
          }
          .alignItems(HorizontalAlign.Center)
          .width('30%')
        }
        .padding(16)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        colors: [
          [Color.Transparent, 0],
          [Color.Black, 0.8]
        ],
        direction: GradientDirection.Bottom
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  FriendsDrawer() {
    Stack() {
      // 背景
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Black)
        .opacity(0.5)
        .onClick(() => {
          this.isFriendsDrawerOpen = false;
        })

      // 抽屉内容
      Row() {
        Blank()
        Column() {
          Row() {
            Text('好友动态')
              .fontSize(18)
              .fontColor(Color.White)
            Blank()
            Text('✕')
              .fontSize(20)
              .fontColor(Color.White)
              .onClick(() => {
                this.isFriendsDrawerOpen = false;
              })
          }
          .width('100%')
          .padding(16)
          .border({ width: { bottom: 1 }, color: Color.White })

          Text('好友功能开发中...')
            .fontSize(16)
            .fontColor(Color.Gray)
            .margin({ top: 50 })
        }
        .width('80%')
        .height('100%')
        .backgroundColor(Color.Gray)
        .opacity(0.9)
      }
    }
    .width('100%')
    .height('100%')
    .zIndex(40)
  }

  @Builder
  CreateMenu() {
    Stack() {
      // 背景
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Black)
        .opacity(0.5)
        .onClick(() => {
          this.isCreateMenuOpen = false;
        })

      // 菜单内容
      Column() {
        Blank()
        Column({ space: 16 }) {
          Text('🎵 创建功能')
            .fontSize(20)
            .fontColor(Color.White)
            .margin({ bottom: 20 })

          Button('拍摄视频')
            .width('80%')
            .height(48)
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(Color.Pink)

          Button('上传视频')
            .width('80%')
            .height(48)
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(Color.Blue)

          Button('开启直播')
            .width('80%')
            .height(48)
            .fontSize(16)
            .fontColor(Color.White)
            .backgroundColor(Color.Orange)
        }
        .width('100%')
        .backgroundColor(Color.Gray)
        .opacity(0.9)
        .borderRadius({ topLeft: 20, topRight: 20 })
        .padding({ top: 20, bottom: 40 })
      }
    }
    .width('100%')
    .height('100%')
    .zIndex(40)
  }
}