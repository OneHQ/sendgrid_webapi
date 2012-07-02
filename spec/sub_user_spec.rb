require 'spec_helper'

describe "sub_user" do
  let(:client) { SendGridWebApi::Client.new("user", "pass") }
  
  describe "#management", :vcr do
    it  "should add new subuser" do
      client.sub_user.management.add(:username => "chebyte3", :website => "example.com", :password => "somepass", :confirm_password => "somepass",
                :first_name => "homero", :last_name => "simpson", :address => "555 anystreet", :city => "any city",
                :state => "CA", :zip => "91234", :email => "chebyte3@example.com", :country => "US", :phone => "555-555").
        should == {"message"=>"success"}
    end
  
    it  "should get all subusers" do
      client.sub_user.management.get.
        should == [{"username"=>"chebyte", "email"=>"chebyte@example.com", "active"=>"true", "first_name"=>"change_named", "last_name"=>"simpson", "address"=>"555 anystreet", "address2"=>"", "city"=>"any city", "state"=>"CA", "zip"=>"91234", "country"=>"US", "phone"=>"555-555", "website"=>"http://example.com", "website_access"=>"true"}, {"username"=>"chebyte2", "email"=>"chebyte@example.com", "active"=>"true", "first_name"=>"test", "last_name"=>"test", "address"=>"test address", "address2"=>"", "city"=>"kansas", "state"=>"CA", "zip"=>"91234", "country"=>"US", "phone"=>"111 1111111", "website"=>"http://notengo.com", "website_access"=>"true"}, {"username"=>"boris", "email"=>"boris@example.com", "active"=>"true", "first_name"=>"homero", "last_name"=>"simpson", "address"=>"555 anystreet", "address2"=>"", "city"=>"any city", "state"=>"CA", "zip"=>"91234", "country"=>"US", "phone"=>"555-555", "website"=>"http://example.com", "website_access"=>"true"}, {"username"=>"chebyte3", "email"=>"chebyte3@example.com", "active"=>"true", "first_name"=>"homero", "last_name"=>"simpson", "address"=>"555 anystreet", "address2"=>"", "city"=>"any city", "state"=>"CA", "zip"=>"91234", "country"=>"US", "phone"=>"555-555", "website"=>"http://example.com", "website_access"=>"true"}]
    end
  
    it  "should disable sub_user for send email" do
      client.sub_user.management.disable(:user => "chebyte3").
        should == {"message" => "success"}
    end    
    
    it  "should enable sub_user for send email" do
      client.sub_user.management.enable(:user => "chebyte3").
        should == {"message" => "success"}
    end    
  
    it  "should enable sub_user for access to website" do
      client.sub_user.management.website_enable(:user => "chebyte3").
        should == {"message" => "success"}
    end    
    
    it "should update sub_user" do
      client.sub_user.management.update(:user => "chebyte3", :first_name => "change_named").
        should == {"message" => "success"}
    end
  end
  
  describe "#bounces", :vcr do
    it "should returns bounce emails" do
      client.sub_user.bounces.get(:user => "chebyte3").
        should == []
    end
  
    it "should tries to delete unexisting bounce emails" do
      client.sub_user.bounces.delete(:user => "chebyte3", :email => "test@test.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#unsubscribes", :vcr do
    it "should add bounce email" do
      client.sub_user.unsubscribes.add(:user => "chebyte3", :email => "test@test.com").
        should == {"message"=>"success"}
    end
    
    it "should returns bounce emails" do
      client.sub_user.unsubscribes.get(:user => "chebyte3").
        should == [{"email"=>"test@test.com"}]
    end
  
    it "should delete existing bounce email" do
      client.sub_user.unsubscribes.delete(:user => "chebyte3", :email => "test@test.com").
        should == {"message"=>"success"}
    end
  
    it "should delete unexisting bounce email" do
      client.sub_user.unsubscribes.delete(:user => "chebyte3", :email => "test@test.com").
        should == {"message"=>"Email does not exist"}
    end
  
  end
  
  describe "#spam", :vcr do
    it "should return spam mails" do
      client.sub_user.spam.get(:user => "chebyte3").
        should == []
    end
  
    it "should tries to delete unexisting spam mail" do
      client.sub_user.spam.delete(:user => "chebyte3", :email => "test@test.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#invalid_emails", :vcr do
    it "should return invalid emails" do
      client.sub_user.invalid_emails.get(:user => "chebyte3").
        should == []
    end
  
    it "should tries to delete unexisting invalid mail" do
      client.sub_user.invalid_emails.delete(:user => "chebyte3", :email => "test@testr.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#event_notification", :vcr do
    it "should add event notification url" do
      client.sub_user.event_notification.set(:user => "chebyte3", :url => "www.example.com/notification").
        should == {"message"=>"success"}
    end
  
    it "should get event notification url" do
      client.sub_user.event_notification.get(:user => "chebyte3").
        should == [{"url"=>"www.example.com/notification"}]
    end
  
    it "should delete event notification url" do
      client.sub_user.event_notification.delete(:user => "chebyte3", :url => "www.example.com/noti.php").
        should == {"message"=>"success"}
    end
  end
  
  describe "#limits", :vcr do
    it "should set total credits" do
      client.sub_user.limits.set_credits(:user => "chebyte3", :credits=> "200", :period=> "daily").
        should == {"message"=>"success"}
    end
    
    it "should returns limits for a sub user" do
      client.sub_user.limits.get(:user => "chebyte3").
        should == [{"credit"=>"0", "credit_remain"=>"200", "last_reset"=>"2012-07-02"}]
    end
  
    it "should reset all limits for a sub user" do
      client.sub_user.limits.reset(:user => "chebyte3", :credits=> "400", :period=> "daily").
        should ==  {"message"=>"success"}
      client.sub_user.limits.get(:user => "chebyte3").
        should == [{"credit"=>"400", "credit_remain"=>"400", "last_reset"=>"2012-07-02"}]
    end
  
    it "should list the limits for a sub user" do
      client.sub_user.limits.get(:user => "chebyte3").
        should == [{"credit"=>"400", "credit_remain"=>"400", "last_reset"=>"2012-07-02"}]
    end
  
    it "should increments credits for a sub user" do
      client.sub_user.limits.increment_credits(:user => "chebyte3", :credits=> "400").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "chebyte3").
        should == [{"credit"=>"0", "credit_remain"=>"800", "last_reset"=>"2012-07-02"}]
    end
  
    it "should decrements credits for a sub user" do
      client.sub_user.limits.decrement_credits(:user => "chebyte3", :credits=> "400").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "chebyte3").
        should == [{"credit"=>"0", "credit_remain"=>"400", "last_reset"=>"2012-07-02"}]
    end
    
    it "should delete all limits for a sub user" do
      client.sub_user.limits.delete(:user => "chebyte3").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "chebyte3").
        should == []        
    end
  end
  
  describe "#ip_management", :vcr do
    it "should return all ips available" do
      client.sub_user.ip_management.get(:user => "chebyte3").
        should == [{"ip"=>"74.63.231.33"}]
    end
  
    it "should show ip subuser" do
      client.sub_user.ip_management.usage_ip(:user => "chebyte3").
        should == {"success"=>"success", "outboundcluster"=>"SendGrid MTA", "ips"=>[]}
    end  
  end
  
  describe "#monitor_records", :vcr do
    it "should create a new monitor record" do
      client.sub_user.monitor_records.create(:name => "testmonitor", :frequency => 10000, :email => "test@test.com").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@test.com", "frequency"=>"10000", "users"=>[]}]
    end
  
    it "should edit a monitor record" do
      client.sub_user.monitor_records.edit(:name => "testmonitor", :new_frequency => 10).
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@test.com", "frequency"=>"10", "users"=>[]}]
    end
  
    it "should add existing sub_user to monitor record" do
      client.sub_user.monitor_records.add_user(:user => "chebyte3", :name => "testmonitor").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@test.com", "frequency"=>"10", "users"=>["chebyte3"]}]
    end
  
    it "should remove existing sub_user from monitor record" do
      client.sub_user.monitor_records.remove_user(:user => "chebyte3", :name => "testmonitor").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@test.com", "frequency"=>"10", "users"=>[]}]
    end
  
    it "should delete a monitor record" do
      client.sub_user.monitor_records.delete(:name => "testmonitor").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == []
    end
  end
  
  describe "#authentication", :vcr do
    it "should auth a sub_user" do
      client.sub_user.auth.login(:user => "chebyte3", :password => "somepass").
        should == {"message"=>"success"}
    end
  
    it "should return error with a bad sub_user" do
      client.sub_user.auth.login(:user => "chebyte3", :password => "badpass").
        should == {"message"=>"error", "errors"=>["Invalid username and/or password"]}
    end
  end
  
  describe "#parse_email", :vcr do
    it "should set parse email" do
      client.sub_user.parse_email.set(:user => "chebyte3", :hostname => "www.example.com", :url => "www.mydomain.com/parse.php", :spam_check => "1").
        should == {"message"=>"success"}
    end
    
    it "should get parse email" do
      client.sub_user.parse_email.get(:user => "chebyte3").
        should == {"parse"=>[{"hostname"=>"www.example.com", "url"=>"www.mydomain.com/parse.php", "spam_check"=>1}]}
    end
  
    it "should delete parse email" do
      client.sub_user.parse_email.delete(:user => "chebyte3", :hostname => "www.example.com").
        should == {"message"=>"success"}
      client.sub_user.parse_email.get(:user => "chebyte3").
        should == {"parse" => []}          
    end
  end
  
  describe "#apps", :vcr do
    it "should return available apps" do
      client.sub_user.apps.list(:user => "chebyte3").
        should == [{"name"=>"gravatar", "title"=>"Gravatar", "description"=>"Appends your gravatar to each HTML email.", "activated"=>false}, {"name"=>"clicktrack", "title"=>"Click Tracking", "description"=>"Overwrites every link to track every click in emails.", "activated"=>false}, {"name"=>"subscriptiontrack", "title"=>"Subscription Tracking", "description"=>"Adds unsubscribe links to the bottom of the text and HTML emails.  Future emails won't be delivered to unsubscribed users.", "activated"=>false}, {"name"=>"opentrack", "title"=>"Open Tracking", "description"=>"Appends an invisible image to HTML emails to track emails that have been opened.", "activated"=>false}, {"name"=>"footer", "title"=>"Footer", "description"=>"Allows you to add a custom footer to outgoing email.", "activated"=>false}, {"name"=>"spamcheck", "title"=>"Spam Checker", "description"=>"Check outbound messages for spam content.", "activated"=>false}, {"name"=>"ganalytics", "title"=>"Google Analytics", "description"=>"Track your conversion rates and ROI with Google Analytics.", "activated"=>false}, {"name"=>"template", "title"=>"Email Template", "description"=>"Allows you to customize your outgoing HTML emails.", "activated"=>false}, {"name"=>"domainkeys", "title"=>"Domain Keys", "description"=>"Allows email to be signed with DomainKeys.", "activated"=>false}, {"name"=>"bcc", "title"=>"BCC", "description"=>"Automatically BCC an address for every e-mail sent.", "activated"=>false}, {"name"=>"eventnotify", "title"=>"Event Notification", "description"=>"Controls notifications for events, such as bounces, clicks, and opens.", "activated"=>false}, {"name"=>"seedlist", "title"=>"Return Path Seedlist", "description"=>"For Return Path customers, with your seedlist for delivery monitoring.", "activated"=>false}, {"name"=>"forwardspam", "title"=>"Forward Spam", "description"=>"Allows for a copy of spam reports to be forwarded to an email address.", "activated"=>false}, {"name"=>"addresswhitelist", "title"=>"Address Whitelist", "description"=>"Address / domains that should never have email suppressed.", "activated"=>false}, {"name"=>"dkim", "title"=>"DKIM", "description"=>"Allows email to be signed with DKIM. Cannot be disabled.", "activated"=>true}]
    end
    
    it "should activate app" do
      client.sub_user.apps.activate(:user => "chebyte3", :name => "opentrack").
        should == {"message"=>"success"}
    end
    
    it "should deactivate app" do
      client.sub_user.apps.deactivate(:user => "chebyte3", :name => "opentrack").
        should == {"message"=>"success"}
    end
    
    it "should get current setting from one app" do
      client.sub_user.apps.current_settings(:user => "chebyte3", :name => "eventnotify").
        should == {"settings"=>{"processed"=>"", "dropped"=>"", "deferred"=>"", "delivered"=>"", "bounce"=>"", "click"=>"", "open"=>"", "unsubscribe"=>"", "spamreport"=>"", "url"=>""}}
    end
    
    it "should set current app" do
      client.sub_user.apps.customize(:user => "chebyte3", :name => "eventnotify", :processed => "1", :dropped => "1", :deferred => "1",
          :delivered => "1", :delivered => "1", :bounce => "1", :click => "1", :open => "1", :unsubscribe => "1", :spamreport => "1", :url => "http://yourdomain.com/event.php").
        should == {"message"=>"success"}
      client.sub_user.apps.current_settings(:user => "chebyte3", :name => "eventnotify").
        should == {"settings"=>{"processed"=>"1", "dropped"=>"1", "deferred"=>"1", "delivered"=>"1", "bounce"=>"1", "click"=>"1", "open"=>"1", "unsubscribe"=>"1", "spamreport"=>"1", "url"=>"http://yourdomain.com/event.php"}}
    end
  end
end