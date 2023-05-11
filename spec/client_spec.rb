require 'spec_helper'

describe "client" do
  let(:client) { SendGridWebApi::Client.new("apikey") }
  
  
  describe "#base", :vcr do
    it "should return api url" do
      expect(client.base_url).to eql "https://api.sendgrid.com/api/"
    end

    it "should return request url" do
      expect(client.make_request_url("blocks.get.json", {:data => 1})).
        to eql "blocks.get.json?data=1"
    end

    it "should convert hash to url params" do
      expect(client.to_query({:value_one => "foo_one", :value_two => "foo_two"})).
        to eql "value_one=foo_one&value_two=foo_two"
    end    
  end
  
  describe "#modules", :vcr do
    describe "#block" do
      it "should get block emails" do
        expect(client.blocks.get).to eql []
      end

      it "should try delete not existing block email" do
        expect(client.blocks.delete({email: "test@example.com"}) ).to eql ({"message"=>"Email does not exist"})
      end

      it "should get totals blocks" do
        expect(client.blocks.count).to eql({:count=>0})
      end
    end
    
    describe "#bounce", :vcr do
      it "should get bounce emails" do
        expect(client.bounces.get).to eql []
      end

      it "should get bounce emails using params" do
        expect(client.bounces.get({limit: 2, offset: 1}).count).to eql 2
      end

      it "should try delete not existing bounce email" do
        expect(client.bounces.delete({email: "test@example.com"})).to eql ({"message"=>"Email does not exist"})
      end
    end
    
    describe "#invalid_email", :vcr do
      it "should get invalid emails" do
        expect(client.invalid_emails.get).to eql []
      end

      it "should get invalid emails using params" do
        expect(client.invalid_emails.get({limit: 3, offset: 2}).count).to eql 3
      end

      it "should try delete not existing invalid emails" do
        expect(client.invalid_emails.delete(:email => "test@example.com")).to eql ({"message"=>"Email does not exist"})
      end
    end
    
    describe "#spam" do
      it "should get spam emails", :vcr do
        expect(client.spam.get).to eql []
      end

      it "should try delete not existing spam emails" do
        expect(client.spam.delete({:email => "test@example.com"})).to eql ({"message"=>"Email does not exist"})
      end
    end
    
    describe "#unsubscribe", :vcr do
      it "should add unsubscribe emails" do
        expect(client.unsubscribes.add({ recipient_emails: ["test@example.com"] })).
          to eql ({"message"=>"success"})
      end

      it "should get unsubscribe emails" do
        expect(client.unsubscribes.get).
          to eql [{"email"=>"test@example.com"}]
      end

      it "should delete unsubscribe email" do
        expect(client.unsubscribes.delete(:email => "test@example.com")).
          to eql ({"message"=>"success"})
      end

      it "should try delete not existing unsubscribe emails" do
        expect(client.unsubscribes.delete({email: "test@example.com"})).
          to eql ({"message"=>"Email does not exist"})
      end
    end

    describe "#parse_email", :vcr do      
      it "should set parse email" do
        expect(client.parse_email.set(:hostname => "www.example.com", :url => "www.mydomain.com/parse.php", :spam_check => "1")).
          to eql ({"message"=>"success"})
      end

      it "should get parse email", :vcr do
        expect(client.parse_email.get).
          to eql ({"parse"=>[{"hostname"=>"www.example.com", "url"=>"www.mydomain.com/parse.php", "spam_check"=>1}]})
      end

      it "should delete parse email", :vcr do
        expect(client.parse_email.delete(:hostname => "www.example.com")).
          to eql ({"message"=>"success"})
        expect(client.parse_email.get).
          to eql ({"parse" => []})
      end
    end
    
    describe "#event_notification", :vcr do      
      it "should set event notification url" do
        expect(client.event_notification.set(:url => "http://www.yourposturlhere.com")).
          to eql ({"message"=>"success"})
      end

      it "should get event notification url" do
        expect(client.event_notification.get).
          to eql ([{"url" => "http:\/\/www.yourposturlhere.com"}])
      end

      it "should delete event notification url" do
        expect(client.event_notification.delete).
          to eql ({"message"=>"success"})
      end
    end
    
    describe "#profile", :vcr do      
      it "should get profile" do
        expect(client.profile.get).
          to eql ([{"username"=>"user", "email"=>"user", "active"=>"true", "first_name"=>"Reseller", "last_name"=>"Customer", "address"=>"555 Any Street", "address2"=>"", "city"=>"City", "state"=>"State", "zip"=>"90000", "country"=>"US", "phone"=>"555-555-5555", "website"=>"http://Website", "website_access"=>"true"}])
      end

      it "should set first name" do
        expect(client.profile.set(:first_name => "test")).
          to eql ({"message" => "success"})
        expect(client.profile.get.first["first_name"]).
          to eql "test"
        expect(client.profile.set(:first_name => "Reseller")).
          to eql ({"message" => "success"})
      end
    end
  end
end

