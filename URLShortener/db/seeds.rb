# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

url1 = ShortenedUrl.create(long_url: 'www.espn.com', 
short_url: ShortenedUrl.create_for_user_and_long_url(User.first, 'www.espn.com'), 1)

topic1 = TagTopic.create(topic: "sports")
topic2 = TagTopic.create(topic: "music")
topic3 = TagTopic.create(topic: "news")

tagging1 = Tagging.create(tag_topic_id: 1, 1)
tagging2 = Tagging.create
