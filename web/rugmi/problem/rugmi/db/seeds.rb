# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  email = ('a'..'z').to_a.shuffle.join
  password = ('a'..'z').to_a.shuffle.join
  User.create!({
    email: "#{email}@gmail.com",
    name: if i == 0 then 'admin' else "user#{i}" end,
    password: password,
    password_confirmation: password,
  })
end

%w(
  https://i.imgur.com/hRrWkGsb.jpg
  https://i.imgur.com/xdhsKx6b.jpg
  https://i.imgur.com/qmM1KtXb.jpg
  https://i.imgur.com/YC3FwDMb.jpg
  https://i.imgur.com/AERSTGjb.jpg
  https://i.imgur.com/EUclemSb.jpg
  https://i.imgur.com/koOEYVDb.jpg
  https://i.imgur.com/V0vU1XAb.jpg
  https://i.imgur.com/LFDcKFAb.jpg
  https://i.imgur.com/YDIIrkSb.jpg
  https://i.imgur.com/ZUCL3dQb.jpg
  https://i.imgur.com/QsKz1Uxb.jpg
  https://i.imgur.com/3IabgeOb.jpg
  https://i.imgur.com/r6sEQvJb.jpg
  https://i.imgur.com/SJUPA9qb.jpg
  https://i.imgur.com/M4bHoSGb.jpg
  https://i.imgur.com/qu34ynmb.jpg
  https://i.imgur.com/G1I6w5Mb.jpg
  https://i.imgur.com/TFvWJJWb.jpg
  https://i.imgur.com/044IdZmb.jpg
  https://i.imgur.com/fX63Vbjb.jpg
  https://i.imgur.com/DKLikRLb.jpg
  https://i.imgur.com/P9pc83tb.jpg
  https://i.imgur.com/Gw3e6tLb.jpg
  https://i.imgur.com/8yORJBZb.jpg
  https://i.imgur.com/42jRgpob.jpg
  https://i.imgur.com/dM4PJkHb.jpg
  https://i.imgur.com/pRmXiY0b.jpg
  https://i.imgur.com/3cPb62Fb.jpg
  https://i.imgur.com/GFc8H9Zb.jpg
  https://i.imgur.com/VbKygXSb.jpg
  https://i.imgur.com/JLeS8Rub.jpg
  https://i.imgur.com/jrawy5ab.jpg
  https://i.imgur.com/SJZ1EOAb.jpg
  https://i.imgur.com/IsPdoCqb.jpg
  https://i.imgur.com/ahH5CACb.jpg
  https://i.imgur.com/uznBHsYb.jpg
  https://i.imgur.com/WtCX0xkb.jpg
  https://i.imgur.com/8F6qw7Bb.jpg
  https://i.imgur.com/t4qoMAZb.jpg
  https://i.imgur.com/3DeQMOUb.jpg
  https://i.imgur.com/gTP9X5Eb.jpg
  https://i.imgur.com/y0cOK2Lb.jpg
  https://i.imgur.com/7ZayHvmb.jpg
  https://i.imgur.com/I6dl649b.jpg
  https://i.imgur.com/IfeKtyab.jpg
  https://i.imgur.com/LbzNtw3b.jpg
  https://i.imgur.com/CoDlGqub.jpg
  https://i.imgur.com/YrtUNdKb.jpg
  https://i.imgur.com/NJHF4jNb.jpg
  https://i.imgur.com/B3nOX34b.jpg
  https://i.imgur.com/NnOOIFjb.jpg
  https://i.imgur.com/KMdSOUfb.jpg
  https://i.imgur.com/NvfHdzrb.jpg
  https://i.imgur.com/YEh78k8b.jpg
  https://i.imgur.com/XsbRA3db.jpg
  https://i.imgur.com/xr3jeNpb.jpg
).each do |image|
  filename = image.split('/').last
  user_id = rand(10)
  FileUtils.mkdir_p(Rails.root.join('public', 'uploads', user_id.to_s))
  `wget #{image} -O #{Rails.root.join('public', 'uploads', user_id.to_s, filename)}`
  Image.create!(
    user_id: user_id,
    filename: filename,
    is_public: true,
  )
end

flagfile = "flag_#{('a'..'z').to_a.shuffle.join}.png"
FileUtils.mkdir_p(Rails.root.join('public', 'uploads', '1'))
FileUtils.move(Rails.root.join('flag.png'), Rails.root.join('public', 'uploads', '1', flagfile))
Image.create!(
  user_id: 1,
  filename: flagfile,
  is_public: false,
)
