json.array! @events do |event|
  json.id event.id
  json.title event.title
  json.description event.description
  json.start event.start_time   
  json.end event.end_time
  json.allday event.allday

  # json.color 色分け
  if event.color == "緑色"
    json.color '#33CC33'
  elsif event.color == "青色"
    json.color '#1E90FF'
  elsif event.color == "黄色"
    json.color '#FFFF00'
  elsif event.color == "赤色"
    json.color '#F00'
  elsif event.color == "水色"
    json.color '#0FF'
  elsif event.color == "桃色"
    json.color '#FF33CC'
  else
    json.color '#A9A9A9'
  end

 end

  # json.〇〇は送るデータの型
  # event.〇〇はそれに対応するモデルのカラム
