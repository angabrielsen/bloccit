module UsersHelper
	def user_has_posts?
		@user.posts.empty?
	end

	def user_has_comments?
		@user.comments.empty?
	end
end
