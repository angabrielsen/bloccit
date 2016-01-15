module UsersHelper
	def user_has_posts?
		not @user.posts.empty?
	end

	def user_has_comments?
		not @user.comments.empty?
	end

	def user_has_favorites?
		not @user.favorites.empty?
	end
end
