module PostsHelper
	def user_is_authorized_for_post?(post)
		current user && (current_user == post.user || current_user.admin?)
	end
end