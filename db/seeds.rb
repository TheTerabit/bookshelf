5.times do
  Book.create! title: Forgery::LoremIpsum.sentence, thoughts: Forgery::LoremIpsum.paragraphs(3)
  Admin.create! login: 'username', password: 'password', password_confirmation: 'password'
end