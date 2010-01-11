require 'test_helper'

class DistropackagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:distropackages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_distropackage
    assert_difference('Distropackage.count') do
      post :create, :distropackage => { }
    end

    assert_redirected_to distropackage_path(assigns(:distropackage))
  end

  def test_should_show_distropackage
    get :show, :id => distropackages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => distropackages(:one).id
    assert_response :success
  end

  def test_should_update_distropackage
    put :update, :id => distropackages(:one).id, :distropackage => { }
    assert_redirected_to distropackage_path(assigns(:distropackage))
  end

  def test_should_destroy_distropackage
    assert_difference('Distropackage.count', -1) do
      delete :destroy, :id => distropackages(:one).id
    end

    assert_redirected_to distropackages_path
  end
end
