require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do
    it "can see a list of recent posts" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_posts_path
      expect(page).to have_content post.title
    end

    it "can edit a post by clicking the edit link next to a post" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_posts_path
      click_link('Edit')
      expect(page.current_path).to eq(edit_admin_post_path(post))
    end

    it "can delete a post by clicking the delete link next to a post" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_posts_path
      click_link('Delete')
      expect(page.current_path).to eq(admin_posts_path)
    end

    it "can create a new post and view it" do
       visit new_admin_post_path

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      post = Post.create(title: 'title', content: 'content', is_published: "1")
      visit edit_admin_post_path(post)
      page.uncheck('post_is_published')
      click_button('Save')
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_posts_path
      click_link(post.title)
      expect(page.current_path).to eq(admin_post_path(post))
    end

    it "can see an edit link that takes you to the edit post path" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_post_path(post)
      click_link('Edit post')
      expect(page.current_path).to eq(edit_admin_post_path(post))
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      post = Post.create(title: 'title', content: 'content')
      visit admin_post_path(post)
      click_link('Admin welcome page')
      expect(page.current_path).to eq(admin_posts_path)
    end
  end
end
