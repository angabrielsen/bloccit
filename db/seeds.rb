include RandomData

15.times do
	Topic.create!(
		name: RandomData.random_sentence,
		description: RandomData.random_paragraph
	)
end
topics = Topic.all

50.times do
	Post.create!(
		title:  RandomData.random_sentence,
		body:   RandomData.random_paragraph
   )
end
posts = Post.all
 
100.times do
	Comment.create!(
 		post: posts.sample,
    	body: RandomData.random_paragraph
   )
end

puts "#{Post.count}"
Post.find_or_create_by(title: "Look at this wacky, unique title!", body: "Look at this wacky, unique body!")
puts "#{Post.count}"

puts "#{Comment.count}"
Comment.find_or_create_by(body: "Look at this wacky, unique body!")
puts "#{Comment.count}"

 
puts "Seed finished"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"