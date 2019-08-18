# frozen_string_literal: true

u1 = User.create(name: 'Johnny Appleseed', email: 'johnny@domain.com',
                 password: 'test')
User.create(name: 'Lily', email: 'lily@domain.com', password: 'test',
            admin: 'true')
u3 = User.create(name: 'Daisy', email: 'daisy@domain.com', password: 'test')

s1 = Topic.create(name: 'Succulents')
h1 = Topic.create(name: 'Herbs')
f1 = Topic.create(name: 'Fruit Trees')

latin1 = '<p>Lorem ipsum dolor sit amet, per dicunt regione scripserit ad, id'\
         'ius quodsi appareat, unum erat legendos eos in. Duis animal ei vel.'\
         ' Vis debitis mandamus ut, dolorem fastidii at sit, unum vidit malis'\
         ' eu mei. Eam deserunt appellantur et, vis soluta placerat cu. Has '\
         'ea corpora dissentiunt liberavisse, legere moderatius nec in, ne '\
         'cum debitis adipiscing.</p>'
latin2 = '<p>Quaeque offendit ut qui. At posse vocent qui, vix numquam '\
         'pericula petentium ad. Mea ad amet liberavisse. At vidit error '\
         'percipitur pri, ius ei quod fugit concludaturque, ad duo detraxit '\
         'efficiantur neglegentur. Ex pro quod animal conclusionemque, in mel'\
         ' facilisis intellegat temporibus, per ut nusquam indoctum. Usu ad '\
         ' affert virtute, deleniti posidonium ad mel.</p>'
latin3 = '<p>Est alii consequat constituam ne. Mel no diam invidunt '\
         'interpretaris. Id mel atomorum voluptatum, scriptorem complectitur '\
         'cu his. Errem quando postulant vel et. Sumo unum ius ei, unum '\
         'platonem duo ea.</p>'
latin4 = '<p>Best Article Ever - Noster cotidieque cum an, scripta nostrum '\
         'ius te, bonorum elaboraret nam eu. Sed tibique similique '\
         'deterruisset ea. Te quo probo audire senserit, natum suavitate at '\
         'vix, indoctum iudicabit vis ea. Pro ea probo posidonium percipitur,'\
         ' eos invenire maluisset ei. Dicta complectitur nam ex, nam no '\
         'rationibus deterruisset. Te timeam oportere vel.<p>'

Article.create(title: 'Types of Succulents', topic_id: s1.id,
               content: '<h2>Succulent types info...</h2>' + latin1 + latin2)
a2 = Article.create(title: 'Succulent Care', topic_id: s1.id,
                    content: '<h3>Succulent Care info</h3>' + latin1 + latin3)
Article.create(title: 'Herb Types', topic_id: h1.id,
               content: '<h2>Herb types</h2>' + latin1 + latin2 + latin3)
a4 = Article.create(title: 'Apple Trees', topic_id: f1.id,
                    content: '<h2>Apple trees are best' + latin1 + latin2)

Bookmark.create(user_id: u3.id, article_id: a2.id,
                title: "I don't like to water")
Bookmark.create(user_id: u1.id, article_id: a4.id,
                title: 'My favorite tree')

Comment.create(user_id: u1.id, article_id: a4.id, content: latin4)
Comment.create(user_id: u3.id, article_id: a2.id,
               content: 'I prefer plants that need water')
