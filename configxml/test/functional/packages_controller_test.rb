require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:packages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_package
    assert_difference('Package.count') do
      post :create, :package => { }
    end

    assert_redirected_to package_path(assigns(:package))
  end

  def test_should_show_package
    get :show, :id => packages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => packages(:one).id
    assert_response :success
  end

  def test_should_update_package
    put :update, :id => packages(:one).id, :package => { }
    assert_redirected_to package_path(assigns(:package))
  end

  def test_should_destroy_package
    assert_difference('Package.count', -1) do
      delete :destroy, :id => packages(:one).id
    end

    assert_redirected_to packages_path
  end
end
