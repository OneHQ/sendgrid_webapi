require 'spec_helper'

describe SendGridWebApi::Client do
  let(:client) { SendGridWebApi::Client.new("app5254374@heroku.com", "qmrsn14y") }
    
  describe "#base" do
    it "should return api url" do
      client.base_url.should eql "https://sendgrid.com/api/"
    end
  
    it "should return request url" do
      client.make_request_url("blocks.get.json", {:data => 1}).
        should eql "blocks.get.json?data=1&api_user=app5254374%40heroku.com&api_key=qmrsn14y"
    end
    
    it "should convert hash to url params" do
      client.to_query({:value_one => "foo_one", :value_two => "foo_two"}).
        should eql "value_one=foo_one&value_two=foo_two"
    end    
  end

  describe "#modules" do
    describe "#block" do
      it "should get block emails" do
        client.blocks.get.should eql []
      end
      it "should try delete not existing block email" do
        client.blocks.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#bounce" do
      it "should get bounce emails" do
        client.bounces.get.should eql []
      end
      it "should try delete not existing bounce email" do
        client.bounces.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#invalid_email" do
      it "should get invalid emails" do
        client.invalid_emails.get.should eql []
      end
      it "should try delete not existing invalid emails" do
        client.invalid_emails.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#spam" do
      it "should get spam emails" do
        client.spam.get.should eql []
      end
      it "should try delete not existing spam emails" do
        client.spam.delete(:email => "test@example.com").should == {"message"=>"Email does not exist"}
      end
    end
    
    describe "#unsubscribe" do
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

    describe "#parse_email" do      
      it "should set parse email" do
        client.parse_email.delete(:hostname => "www.example.com")
        client.parse_email.set(:hostname => "www.example.com", :url => "www.mydomain.com/parse.php", :spam_check => "1").
          should == {"message"=>"success"}
      end
      
      it "should get parse email" do
        client.parse_email.get.
          should == {"parse"=>[{"hostname"=>"www.example.com", "url"=>"www.mydomain.com/parse.php", "spam_check"=>1}]}
      end
    
      it "should delete parse email" do
        client.parse_email.delete(:hostname => "www.example.com").
          should == {"message"=>"success"}
        client.parse_email.get.
          should == {"parse" => []}          
      end
    end
    
    describe "#event_notification" do      
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
    
    describe "#stats" do      
      it "should get stats" do
        client.stats.get.
          should == [{"delivered"=>0, "unsubscribes"=>0, "invalid_email"=>0, "bounces"=>0, "repeat_unsubscribes"=>0, "unique_clicks"=>0, "blocked"=>0, "spam_drop"=>0, "repeat_bounces"=>0, "repeat_spamreports"=>0, "date"=>"#{Time.now.strftime('%Y-%m-%d')}", "requests"=>0, "spamreports"=>0, "clicks"=>0, "opens"=>0, "unique_opens"=>0}]
      end
    end
    
    describe "#profile" do      
      it "should get profile" do
        client.profile.get.
          should == [{"username"=>"app5254374@heroku.com", "email"=>"app5254374@heroku.com", "active"=>"true", "first_name"=>"Reseller", "last_name"=>"Customer", "address"=>"555 Any Street", "address2"=>"", "city"=>"City", "state"=>"State", "zip"=>"90000", "country"=>"US", "phone"=>"555-555-5555", "website"=>"http://Website", "website_access"=>"true"}]
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

