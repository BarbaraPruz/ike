# ike
ike is a general knowledgebase web app built using Rails.

Anyone can login through GitHub or by signing up for ike.  The sign up uses email for login and a and password (secure).  The user "name" is used for informational purposes.  Administration privileges can only be granted by another administrator.

Once logged in, all users can 
- browse articles and topics (including sorting by topic, title, likes or last update date)
- "like" an article
- Comment on an article
- bookmark an article (and delete bookmarks)

Admin users have additional functionality
- User admin - index, edit and delete functions
- Create, edit or delete an article
- Create, edit or delete a topic

Installation Instructions
-------------------------
Fork and clone this GIT repo.

Running ike
------------------
Use rake to migrate and seed database.   
Run rails server.

Test user logins:
    johnny@domain.com  password: test
    daisy@domain.com password: test
    lilyy@domain.com password: test  --- Admin
or use Google to login or Sign Up to create a different id.

Contributing
------------
Bug reports and pull requests are welcome on GitHub at https://github.com/'BarbaraPruz'/ike. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

License
-------
Open source under the terms of the MIT License.

Code of Conduct
---------------
Everyone interacting in the ike project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.

