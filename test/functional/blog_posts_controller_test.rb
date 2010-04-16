require 'test_helper'

class BlogPostsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => BlogPost.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    BlogPost.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    BlogPost.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to blog_post_url(assigns(:blog_post))
  end
  
  def test_edit
    get :edit, :id => BlogPost.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    BlogPost.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BlogPost.first
    assert_template 'edit'
  end
  
  def test_update_valid
    BlogPost.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BlogPost.first
    assert_redirected_to blog_post_url(assigns(:blog_post))
  end
  
  def test_destroy
    blog_post = BlogPost.first
    delete :destroy, :id => blog_post
    assert_redirected_to blog_posts_url
    assert !BlogPost.exists?(blog_post.id)
  end
end
