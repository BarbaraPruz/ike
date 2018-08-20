u1 = User.create(:name => "Joe", :email => "joe@domain.com", :password => "test")
u2 = User.create(:name => "Lily", :email => "lily@domain.com", :password => "test", :admin => "true")

s1 = Topic.create(:name => "Succulents")
h1 = Topic.create(:name => "Herbs")
f1 = Topic.create(:name => "Ferns")

a1 = Article.create(
                :title => "Types of Succulents",
                :content => "Succulent types - Lorem ipsum dolor sit amet, an oratio legendos prodesset est, at mea magna consequuntur. No elit legimus duo, ei erant ridens assentior quo. Ea qui dolorem democritum. Per deleniti gubergren ex, latine ullamcorper nam at.")
a2 = Article.create(:title => "Succulent Care",
                :content => "Succulent care - Lorem ipsum dolor sit amet, an oratio legendos prodesset est, at mea magna consequuntur. No elit legimus duo, ei erant ridens assentior quo. Ea qui dolorem democritum. Per deleniti gubergren ex, latine ullamcorper nam at.")
a3 = Article.create(:title => "Herb Types",
                :content => "Herb types - Lorem ipsum dolor sit amet, an oratio legendos prodesset est, at mea magna consequuntur. No elit legimus duo, ei erant ridens assentior quo. Ea qui dolorem democritum. Per deleniti gubergren ex, latine ullamcorper nam at.")
a1.update(:topic_id => s1.id)
a2.update(:topic_id => s1.id)
a3.update(:topic_id => h1.id)

b1 = Bookmark.create(:user_id => u1.id, :article_id => a2.id, :title => "Take Care of Cacti")

