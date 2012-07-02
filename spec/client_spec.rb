require 'spec_helper'

describe "client" do
  let(:client) { SendGridWebApi::Client.new("user", "pass") }
  
  
  describe "#base", :vcr do
    it "should return api url" do
      client.base_url.should eql "https://sendgrid.com/api/"
    end
  
    it "should return request url" do
      client.make_request_url("blocks.get.json", {:data => 1}).
        should eql "blocks.get.json?data=1&api_user=user&api_key=pass"
    end
    
    it "should convert hash to url params" do
      client.to_query({:value_one => "foo_one", :value_two => "foo_two"}).
        should eql "value_one=foo_one&value_two=foo_two"
    end    
  end
  
  describe "#modules", :vcr do
    describe "#block" do
      it "should get block emails" do
        client.blocks.get.should eql []
      end
      it "should try delete not existing block email" do
        client.blocks.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#bounce", :vcr do
      it "should get bounce emails" do
        client.bounces.get.should eql []
      end
      it "should try delete not existing bounce email" do
        client.bounces.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#invalid_email", :vcr do
      it "should get invalid emails" do
        client.invalid_emails.get.should eql []
      end
      it "should try delete not existing invalid emails" do
        client.invalid_emails.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#spam" do
      it "should get spam emails", :vcr do
        client.spam.get.should eql []
      end
      it "should try delete not existing spam emails" do
        client.spam.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#unsubscribe", :vcr do
      it "should add unsubscribe emails" do
        client.unsubscribes.add(:email => "test@example.com").
          should == {"message"=>"success"}
      end
      it "should get unsubscribe emails" do
        client.unsubscribes.get.
          should eql [{"email"=>"test@example.com"}]
      end
      it "should delete unsubscribe email" do
        client.unsubscribes.delete(:email => "test@example.com").
          should == {"message"=>"success"}
      end
      it "should try delete not existing unsubscribe emails" do
        client.unsubscribes.delete(:email => "test@example.com").
          should == {"message"=>"Email does not exist"}
      end
    end
  
    describe "#parse_email", :vcr do      
      it "should set parse email" do
        client.parse_email.set(:hostname => "www.example.com", :url => "www.mydomain.com/parse.php", :spam_check => "1").
          should == {"message"=>"success"}
      end
      
      it "should get parse email", :vcr do
        client.parse_email.get.
          should == {"parse"=>[{"hostname"=>"www.example.com", "url"=>"www.mydomain.com/parse.php", "spam_check"=>1}]}
      end
    
      it "should delete parse email", :vcr do
        client.parse_email.delete(:hostname => "www.example.com").
          should == {"message"=>"success"}
        client.parse_email.get.
          should == {"parse" => []}          
      end
    end
    
    describe "#event_notification", :vcr do      
      it "should set event notification url" do
        client.event_notification.set(:url => "http://www.yourposturlhere.com").
          should == {"message"=>"success"}
      end
      
      it "should get event notification url" do
        client.event_notification.get.
          should == [{"url" => "http:\/\/www.yourposturlhere.com"}]
      end
    
      it "should delete event notification url" do
        client.event_notification.delete.
          should == {"message"=>"success"}
      end
    end
    
    describe "#profile", :vcr do      
      it "should get profile" do
        client.profile.get.
          should == [{"username"=>"app4238669@heroku.com", "email"=>"app4238669@heroku.com", "active"=>"true", "first_name"=>"Reseller", "last_name"=>"Customer", "address"=>"555 Any Street", "address2"=>"", "city"=>"City", "state"=>"State", "zip"=>"90000", "country"=>"US", "phone"=>"555-555-5555", "website"=>"http://Website", "website_access"=>"true"}]
      end
    
      it "should set first name" do
        client.profile.set(:first_name => "test").
          should == {"message" => "success"}
        client.profile.get.first["first_name"].
          should == "test"
        client.profile.set(:first_name => "Reseller").
          should == {"message" => "success"}
      end
    end
  end
end

