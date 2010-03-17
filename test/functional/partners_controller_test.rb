require 'test_helper'

class PartnersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Partner.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Partner.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Partner.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to partner_url(assigns(:partner))
  end
  
  def test_edit
    get :edit, :id => Partner.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Partner.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Partner.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Partner.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Partner.first
    assert_redirected_to partner_url(assigns(:partner))
  end
  
  def test_destroy
    partner = Partner.first
    delete :destroy, :id => partner
    assert_redirected_to partners_url
    assert !Partner.exists?(partner.id)
  end
end
