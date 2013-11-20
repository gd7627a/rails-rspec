require 'spec_helper'

feature 'User browsing the website' do
  context "on homepage" do
    it "sees a list of recent posts titles" do
      post = Post.new
      visit posts_path
      expect(page).to have_content post.title
      # user visits the homepage
      # user can see the posts titles
    end

    it "can click on titles of recent posts and should be on the post show page" do
      post = Post.create(title: 'title', content: 'content', is_published: "1")
      visit root_path
      click_link(post.title)
      expect(page.current_path).to eq(post_path(post))
      # given a user and a list of posts
      # user visits the homepage
      # when a user can clicks on a post title they should be on the post show page
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      post = Post.create(title: 'title', content: 'content', is_published: "1")
      visit post_path(post)
      expect(page).to have_content post.content
      expect(page).to have_content post.title

     # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
  end
end
