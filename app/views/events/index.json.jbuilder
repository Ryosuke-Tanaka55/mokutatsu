json.array! @events do |event|
   json.id event.id
   json.title event.title
   json.description event.description
   json.start event.start_time   
   json.end event.end_time
   json.color event.color
   json.allday event.allday
   
 end

  # json.〇〇は送るデータの型
  # event.〇〇はそれに対応するモデルのカラム
