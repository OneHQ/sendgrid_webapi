require 'spec_helper'

describe "helper" do
  include SendGridWebApi::Helper

  let(:client) { SendGridWebApi::Client.new("user", "pass") }
  
  describe "#run_sendgrid_query" do    
    it "should run sendgrid request", :vcr do
      run_sendgrid_query("user", "pass") do
        @client.sub_user.apps.activate(:user => "test-1", :name => "clicktrack")
      end
    end

    it "should raise with unsucessfull request", :vcr do
      lambda do
        run_sendgrid_query("user", "pass") do
          @client.sub_user.apps.activate(:user => "test-1", :name => "badappname")
        end
      end.should raise_error
    end
  end
  
  describe "#create_sub_user_account", :vcr do
    before(:each) do
      user_hash = {:website => "someurl.com", :password => "somepass", :confirm_password => "somepass",
                   :first_name => "home", :last_name => "simpson", :address => "555 anystreet", :city =>  "any city",
                   :state => "CA" , :zip => "91234", :email => "email@email.com", :country => "US", :phone => "555-555"}
      
      apps = { :opentrack => {:name => "eventnotify", :processed => "0", :dropped => "1", :deferred => "1",
                              :delivered => "0", :bounce => "1", :click => "1", :open => "1", :unsubscribe => "1", :spamreport => "1", 
                              :url => "https://agencieshq.com/sendgrid/v1/listener"},
               :clicktrack => {:enable_text => "1"},
               :opentrack => {}
      }
  
      @users = {"test-4" => {:account => user_hash, :applications => apps, :assigned_ips => ["74.63.231.33"]}}
      
    end
    
    it "should create sub_user_account" do
      create_sub_user_account("user", "pass", @users)
      client.sub_user.auth.login(:user => "test-3", :password => "somepass").
        should == {"message" => "success"}
    end
  end
end