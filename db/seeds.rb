Master.create(id: 1, name: 'Root', email: 'root@cb-singles.com', password:'secret', password_confirmation:'secret')
Master.create(name: 'Yosei', email: 'yousei.itou@gmail.com', password:'secret', password_confirmation:'secret')

case Rails.env
when 'development'
  (1..5).each do |n|
    o = "#{Rails.root}/db/samples/sample#{n}.jpg"
    t = "#{Rails.root}/db/samples/sample#{n}-thumb.jpg"
    Picture.create(origin: File.read(o),thumb: File.read(t))
  end

  b = Master.create(name: 'マスターA', email: 'foo@bar.com', password:'secret', password_confirmation:'secret')

  def d(offset)
    t = Time.now + (offset * 24 * 60 * 60)
    t.strftime("%Y-%m-%d")
  end

  Event.create(opendate: d(-1), opentime: 1, title: '昨日バー',short_desc: '句をひねりつつ、胃に優しい大根めしをどうぞ。',master_id: b.id, picture_id: 1)
  Event.create(opendate: d(0), opentime: 1, title: '説教バー' ,short_desc: '新しくマスターになりたい方の 講習をします。(オープン19:30開始20:00)担当:XXX',master_id: 1, picture_id: 2)
  Event.create(opendate: d(1), opentime: 0, title: '昼営業バー' ,short_desc: '映画をサカナに飲みます。詳細はネット・FBページ検索で',master_id: b.id, picture_id: 3)
  Event.create(opendate: d(1), opentime: 1, title: '夜営業バー' ,short_desc: '映画をサカナに飲みます。詳細はネット・FBページ検索で ',master_id: b.id, picture_id: 4)
  Event.create(opendate: d(2), opentime: 2, title: '昼夜営業バー' ,short_desc: '店内に張り巡らせた謎を全て解いて脱出しないと死にます。カレーあり。参加費五百円。 ■開店時間11:30～14:00。ゲーム開始12:00。■開店時間15:30～18:00。ゲーム開始16:00。■開店時間19:30～23:00。ゲーム開始20:00。',master_id: 1, picture_id: 5)
end

