password = ENV['password']

users = User.create!(
  [
    {
      name: 'ひろ',
      email: 'hiro@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'たろう',
      email: 'taro@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'じろう',
      email: 'jiro@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'さぶろう',
      email: 'saburo@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'けんた',
      email: 'kenta@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'たくや',
      email: 'takuya@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'ゆうり',
      email: 'yuri@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'けい',
      email: 'kei@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'りく',
      email: 'riku@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'ゆうま',
      email: 'yuma@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'ちひろ',
      email: 'tihiro@gmail.com',
      password: password,
      password_confirmation: password
    },
    {
      name: 'ゲストユーザー',
      email: 'guestuser0123@gmail.com',
      password: 'guestuser0123',
      password_confirmation: 'guestuser0123'
    }
  ]
)

posts = Post.create!(
  [
    {
      title: '隅の空間の使い方',
      content: '金沢21世紀美術館に行ってきました。建物が円形で外壁がガラス張りであることからとても開放的な空間になっていました。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[0].id
    },
    {
      title: 'かわいい椅子あった!',
      content: '美術館にめっちゃかわいい椅子があったので投稿します!ラビットチェアっていうみたいでSANNAのお二人がデザインしたみたい。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[0].id
    },
    {
      title: 'モノクロ写真と採光',
      content: 'その美術館で実際に撮影された写真が展示されていて珍しくて少し驚きました。モロクロの写真と館内の光の当たり具合が絶妙で雰囲気 がありました。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[1].id
    },
    {
      title: '岐阜メディアコスモス',
      content: '伊東豊雄さんが設計した図書館のある複合施設にお邪魔してきました。薄い曲面板からなる建築構造のシェル構造をヒントに岐阜産のヒノキを三方向に丸く組み上げ、全体的に包み込まれるような大きな曲線で構成された天井のもとに、
      採光、空調としての機能性、デザイン性を兼ねそろえたグローブが絶妙に配置されていました。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[1].id
    },
    {
      title: '上野観光で西洋美術館へ',
      content: '大学で学んだ近代建築の五原則を実際に観に行こうと思い、上野観光のついでに国立西洋美術館に行きました。「ピロティ」、「自由な平面」、「水平連続窓」、「屋上庭園」のうち、屋上庭園は見れなかったのですが他の部分がしっかり自分の目で見て感じることが出来ました。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[2].id
    },
    {
      title: '西洋美術館の模型あった！',
      content: '西洋美術館内の入ってすぐの展示スペースに他の大学の学生が作った模型が展示されていました。まだ半年しか建築を学習していない私から見たら完成度に驚きまくりでした。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[2].id
    },
    {
      title: '木橋ミュージアムへ',
      content: '日本を代表する建築家の隈研吾さんが設計した梼原 木橋ミュージアムを見に行きました。大学の授業で軸組の模型を作る予定なのでとても参考になりました!',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[3].id
    },
    {
      title: '円形建築の空間',
      content: '円形建築の金沢21世紀美術館は空間の使い方が上手いと思いました。私には円形建築を設計することは難しいと思い知らされました。',
      image: File.open('./public/images/sample.jpg'),
      user_id: users[3].id
    }
  ]
)

PostLike.create!(
  [
    {
      user_id: users[0].id,
      post_id: posts[2].id
    },
    {
      user_id: users[0].id,
      post_id: posts[3].id
    },
    {
      user_id: users[0].id,
      post_id: posts[4].id
    },
    {
      user_id: users[0].id,
      post_id: posts[5].id
    },
    {
      user_id: users[0].id,
      post_id: posts[6].id
    },
    {
      user_id: users[1].id,
      post_id: posts[0].id
    },
    {
      user_id: users[1].id,
      post_id: posts[1].id
    },
    {
      user_id: users[1].id,
      post_id: posts[5].id
    },
    {
      user_id: users[1].id,
      post_id: posts[6].id
    }
  ]
)
