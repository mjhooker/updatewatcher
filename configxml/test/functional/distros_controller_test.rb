require 'test_helper'

class DistrosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:distros)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_distro
    assert_difference('Distro.count') do
      post :create, :distro => { }
    end

    assert_redirected_to distro_path(assigns(:distro))
  end

  def test_should_show_distro
    get :show, :id => distros(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => distros(:one).id
    assert_response :success
  end

  def test_should_update_distro
    put :update, :id => distros(:one).id, :distro => { }
    assert_redirected_to distro_path(assigns(:distro))
  end

  def test_should_destroy_distro
    assert_difference('Distro.count', -1) do
      delete :destroy, :id => distros(:one).id
    end

    assert_redirected_to distros_path
  end
end
