module ApplicationHelper

  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "MOKU・TATSU"
    if page_name.empty?
      base_title
    else
      page_name + "|" + base_title
    end
  end

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
