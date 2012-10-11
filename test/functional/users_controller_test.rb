require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic

  context "Logged in as Bob" do

    setup do
      login_as(:bob)
    end

    context "With users" do

      context "a GET to :index" do
        setup { get :index }
        should_render_template :index
        should_not_set_the_flash
      end

      context "a GET to :new" do
        setup { get :new }
        should_render_template :new
        should_not_set_the_flash
      end

      context "a POST to :create" do
        setup { i=0; post :create, :user => {:firstname => 'Ronald', :lastname => 'McDonald', :email => 'me@one.com', :password => "something", :password_confirmation => "something", :login => "uniq_#{i=i+1}" } }
        should_redirect_to("New user") { "/users/#{assigns(:user).id}" }
        should_assign_to :user
        should_set_the_flash_to(/created/i)
      end

      context "a POST to :create supplying an existing username" do
        setup { post :create, :user => {:firstname => 'Ronald', :lastname => 'McDonald', :password => "something", :password_confirmation => "something", :login => users(:bob).login } }
        should_render_template :new
      end

      context "a GET to :edit" do
        setup { get :edit, :id => users(:bob).id }
        should_render_template :edit
      end

      context "a GET to :show" do
        setup { get :show, :id => users(:bob).id }
        should_render_template :show
      end

      context "a POST to update (new email)" do
        setup do
          put :update, :id => users(:bob).id, :user =>{:password_confirmation=>"", :lastname=>"Foobar", :firstname=>"Bob",
           :operative_status=>"active", :password=>"", :login=>"bob", :email=>"new@emailaddress.com"}
        end
        should_redirect_to("New user") { "/users/#{users(:bob).id}" }
        should_set_the_flash_to(/successfully updated/i)

        should 'change Bob´s email to new@emailaddress.com' do
          assert_equal "new@emailaddress.com", users(:bob).reload.email
        end
      end

      context "a POST to update (providing an existing username)" do
        setup do
          put :update, :id => users(:bob).id, :user =>{:password_confirmation=>"", :lastname=>"Foobar", :firstname=>"Bob",
           :operative_status=>"active", :password=>"", :login=>"bill", :email=>"new@emailaddress.com"}
        end
        should_render_template :edit
        should "display Login has already been taken" do
          assert_select "li", "Login has already been taken"
        end
      end

      context "destroying Bob" do
        setup { post :destroy, :id => users(:bob).id}
        should_redirect_to("Index") { "/users" }
        should_set_the_flash_to(/error/i)
      end

      context "destroying Bill" do
        setup { post :destroy, :id => users(:bill).id}
        should_redirect_to("Index") { "/users" }
        should_set_the_flash_to('User was removed.')
      end
    end
  end
  
  context 'As bill on GET to :index' do
    setup { login_as(:bill); get :index }
    should_redirect_to("Time Entries") { user_time_entries_url(:user_id => users(:bill).id) }
  end

  context "Not logged in on GET to :index" do
    setup { get :index }
    should_redirect_to("Login page") { new_user_session_url }
  end
  
  context "When logged in as Bill" do
    
    setup { 
      login_as :bill
      @user = users(:bill) 
      }
    
    context "a GET request to UsersController :show with a different user id" do
      
      setup { get :show, :id => users(:bob).id.to_s }
      
      should_redirect_to("Time Entries index") { user_time_entries_url(@user) }
      should_set_the_flash_to "You do not have access to this page"
      
    end
    
    context "a GET request to UsersController :edit with a different user id" do
      
      setup { get :edit, :id => users(:bob).id.to_s }
      
      should_redirect_to("Time Entries index") { user_time_entries_url(@user) }
      should_set_the_flash_to "You do not have access to this page"
      
    end
    
    context "a PUT request to UsersController :update with a different user id" do
      
      setup { put :update, :id => users(:bob).id.to_s }
      
      should_redirect_to("Time Entries index") { user_time_entries_url(@user) }
      should_set_the_flash_to "You do not have access to this page"
      
    end
    
  end
      
  
end
