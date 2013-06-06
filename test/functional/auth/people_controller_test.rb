require 'test_helper'

class Auth::PeopleControllerTest < ActionController::TestCase
  setup do
    @auth_person = auth_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auth_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auth_person" do
    assert_difference('Auth::Person.count') do
      post :create, auth_person: { email: @auth_person.email, fail_count: @auth_person.fail_count, last_login_ip: @auth_person.last_login_ip, login_count: @auth_person.login_count, pass: @auth_person.pass, salt: @auth_person.salt }
    end

    assert_redirected_to auth_person_path(assigns(:auth_person))
  end

  test "should show auth_person" do
    get :show, id: @auth_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auth_person
    assert_response :success
  end

  test "should update auth_person" do
    put :update, id: @auth_person, auth_person: { email: @auth_person.email, fail_count: @auth_person.fail_count, last_login_ip: @auth_person.last_login_ip, login_count: @auth_person.login_count, pass: @auth_person.pass, salt: @auth_person.salt }
    assert_redirected_to auth_person_path(assigns(:auth_person))
  end

  test "should destroy auth_person" do
    assert_difference('Auth::Person.count', -1) do
      delete :destroy, id: @auth_person
    end

    assert_redirected_to auth_people_path
  end
end
