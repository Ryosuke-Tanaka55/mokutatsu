#複数結果が取得できる可能性があるため、繰り返し処理を行う
json.array! @posts do | post |
  json.post_id            post.post_user_id
  json.post_nickname      post.post_user.nickname

  # イメージ有無で仕込むデータを切り替え。
  # 本番環境はフィンガープリントがくっつくので、それも付加してファイル名記載
  if post.post_user.image.attached?
    json.post_image        url_for(post.post_user.image)
  else
    json.post_image        "/assets/common/member_photo_noimage_thumb-224a733c50d48aba6d9fdaded809788bbeb5ea5f6d6b8368adaebb95e58bcf53.png"
  end

  json.comment             post.comment
  #javascript内でrubyのフォーマットヘルパーが使えないので、jbuilder内で事前に整形。
  json.created_at          post.created_at.strftime("%m月%d日 %H:%M")

  # font-awesomeの指定をここで割り当てる。
  # 普通に文字列として指定したらいけました。ヘルパーメソッド にしてあげたほうが親切かも。。
  case post.post
  when 1
    json.post 'fa-smile good'
  when 2
    json.post 'fa-meh normal'
  when 3
    json.post 'fa-frown bad'
  end

end
