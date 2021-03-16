require 'spec_helper'

describe "sub_user" do
  let(:client) { SendGridWebApi::Client.new("pass") }
  
  describe "#management", :vcr do
    it  "should add new subuser" do
      client.sub_user.management.add(:username => "sendgrid_testuser3", :website => "example.com", :password => "somepass", :confirm_password => "somepass",
                :first_name => "homero", :last_name => "simpson", :address => "555 anystreet", :city => "any city",
                :state => "CA", :zip => "91234", :email => "sendgrid_testuser3@example.com", :country => "US", :phone => "555-555").
        should == {"message"=>"success"}
    end

    it  "should disable sub_user for send email" do
      client.sub_user.management.disable(:user => "sendgrid_testuser3").
        should == {"message" => "success"}
    end    
    
    it  "should enable sub_user for send email" do
      client.sub_user.management.enable(:user => "sendgrid_testuser3").
        should == {"message" => "success"}
    end    
  
    it  "should enable sub_user for access to website" do
      client.sub_user.management.website_enable(:user => "sendgrid_testuser3").
        should == {"message" => "success"}
    end    
    
    it "should update sub_user" do
      client.sub_user.management.update(:user => "sendgrid_testuser3", :first_name => "change_named").
        should == {"message" => "success"}
    end
  end
  
  describe "#bounces", :vcr do
    it "should returns bounce emails" do
      client.sub_user.bounces.get(:user => "sendgrid_testuser3").
        should == []
    end
  
    it "should tries to delete unexisting bounce emails" do
      client.sub_user.bounces.delete(:user => "sendgrid_testuser3", :email => "test@email.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#unsubscribes", :vcr do
    it "should add bounce email" do
      client.sub_user.unsubscribes.add(:user => "sendgrid_testuser3", :email => "test@email.com").
        should == {"message"=>"success"}
    end
    
    it "should returns bounce emails" do
      client.sub_user.unsubscribes.get(:user => "sendgrid_testuser3").
        should == [{"email"=>"test@email.com"}]
    end
  
    it "should delete existing bounce email" do
      client.sub_user.unsubscribes.delete(:user => "sendgrid_testuser3", :email => "test@email.com").
        should == {"message"=>"success"}
    end
  
    it "should delete unexisting bounce email" do
      client.sub_user.unsubscribes.delete(:user => "sendgrid_testuser3", :email => "test@email.com").
        should == {"message"=>"Email does not exist"}
    end
  
  end
  
  describe "#spam", :vcr do
    it "should return spam mails" do
      client.sub_user.spam.get(:user => "sendgrid_testuser3").
        should == []
    end
  
    it "should tries to delete unexisting spam mail" do
      client.sub_user.spam.delete(:user => "sendgrid_testuser3", :email => "test@email.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#invalid_emails", :vcr do
    it "should return invalid emails" do
      client.sub_user.invalid_emails.get(:user => "sendgrid_testuser3").
        should == []
    end
  
    it "should tries to delete unexisting invalid mail" do
      client.sub_user.invalid_emails.delete(:user => "sendgrid_testuser3", :email => "test@testr.com").
        should == {"message"=>"Email does not exist"}
    end
  end
  
  describe "#event_notification", :vcr do
    it "should add event notification url" do
      client.sub_user.event_notification.set(:user => "sendgrid_testuser3", :url => "www.example.com/notification").
        should == {"message"=>"success"}
    end
  
    it "should get event notification url" do
      client.sub_user.event_notification.get(:user => "sendgrid_testuser3").
        should == [{"url"=>"www.example.com/notification"}]
    end
  
    it "should delete event notification url" do
      client.sub_user.event_notification.delete(:user => "sendgrid_testuser3", :url => "www.example.com/noti.php").
        should == {"message"=>"success"}
    end
  end
  
  describe "#limits", :vcr do
    it "should set total credits" do
      client.sub_user.limits.set_credits(:user => "sendgrid_testuser3", :credits=> "200", :period=> "daily").
        should == {"message"=>"success"}
    end
    
    it "should returns limits for a sub user" do
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == [{"credit"=>"0", "credit_remain"=>"200", "last_reset"=>"2014-01-16"}]
    end
  
    it "should reset all limits for a sub user" do
      client.sub_user.limits.reset(:user => "sendgrid_testuser3", :credits=> "400", :period=> "daily").
        should ==  {"message"=>"success"}
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == [{"credit"=>"400", "credit_remain"=>"400", "last_reset"=>"2014-01-16"}]
    end
  
    it "should list the limits for a sub user" do
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == [{"credit"=>"400", "credit_remain"=>"400", "last_reset"=>"2014-01-16"}]
    end
  
    it "should increments credits for a sub user" do
      client.sub_user.limits.increment_credits(:user => "sendgrid_testuser3", :credits=> "400").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == [{"credit"=>"0", "credit_remain"=>"800", "last_reset"=>"2014-01-16"}]
    end
  
    it "should decrements credits for a sub user" do
      client.sub_user.limits.decrement_credits(:user => "sendgrid_testuser3", :credits=> "400").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == [{"credit"=>"0", "credit_remain"=>"400", "last_reset"=>"2014-01-16"}]
    end
    
    it "should delete all limits for a sub user" do
      client.sub_user.limits.delete(:user => "sendgrid_testuser3").
        should == {"message"=>"success"}
      client.sub_user.limits.get(:user => "sendgrid_testuser3").
        should == []        
    end
  end
  
  describe "#ip_management", :vcr do
    it "should return all ips available" do
      client.sub_user.ip_management.get(:user => "sendgrid_testuser3").
        should == [{"ip"=>"192.254.126.178"}]
    end
  
    it "should show ip subuser" do
      client.sub_user.ip_management.usage_ip(:user => "sendgrid_testuser3").
        should == {"success"=>"success", "outboundcluster"=>"SendGrid MTA", "ips"=>[]}
    end  
  end
  
  describe "#monitor_records", :vcr do
    it "should create a new monitor record" do
      client.sub_user.monitor_records.create(:name => "testmonitor", :frequency => 10000, :email => "test@email.com").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@email.com", "frequency"=>"10000", "users"=>[]}]
    end
  
    it "should edit a monitor record" do
      client.sub_user.monitor_records.edit(:name => "testmonitor", :new_frequency => 10).
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@email.com", "frequency"=>"10", "users"=>[]}]
    end
  
    it "should add existing sub_user to monitor record" do
      client.sub_user.monitor_records.add_user(:user => "sendgrid_testuser3", :name => "testmonitor").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@email.com", "frequency"=>"10", "users"=>["sendgrid_testuser3"]}]
    end
  
    it "should remove existing sub_user from monitor record" do
      client.sub_user.monitor_records.remove_user(:user => "sendgrid_testuser3", :name => "testmonitor").
        should == {"message"=>"success"}
      client.sub_user.monitor_records.get.
        should == [{"name"=>"testmonitor", "email"=>"test@email.com", "frequency"=>"10", "users"=>[]}]
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
      client.sub_user.auth.login(:user => "sendgrid_testuser3", :password => "somepass").
        should == {"message"=>"success"}
    end
  
    it "should return error with a bad sub_user" do
      client.sub_user.auth.login(:user => "sendgrid_testuser3", :password => "badpass").
        should == {"message"=>"error", "errors"=>["Invalid username and/or password"]}
    end
  end
  
  describe "#parse_email", :vcr do
    it "should set parse email" do
      client.sub_user.parse_email.set(:user => "sendgrid_testuser3", :hostname => "www.example.com", :url => "www.mydomain.com/parse.php", :spam_check => "1").
        should == {"message"=>"success"}
    end
    
    it "should get parse email" do
      client.sub_user.parse_email.get(:user => "sendgrid_testuser3").
        should == {"parse"=>[{"hostname"=>"www.example.com", "url"=>"www.mydomain.com/parse.php", "spam_check"=>1}]}
    end
  
    it "should delete parse email" do
      client.sub_user.parse_email.delete(:user => "sendgrid_testuser3", :hostname => "www.example.com").
        should == {"message"=>"success"}
      client.sub_user.parse_email.get(:user => "sendgrid_testuser3").
        should == {"parse" => []}          
    end
  end
  
  describe "#apps", :vcr do
    it "should return available apps" do
      client.sub_user.apps.list(:user => "sendgrid_testuser3").
        should == [{"name"=>"gravatar", "title"=>"Gravatar", "description"=>"Appends your gravatar to each HTML email.", "activated"=>false}, {"name"=>"clicktrack", "title"=>"Click Tracking", "description"=>"Overwrites every link to track every click in emails.", "activated"=>false}, {"name"=>"subscriptiontrack", "title"=>"Subscription Tracking", "description"=>"Adds unsubscribe links to the bottom of the text and HTML emails.  Future emails won't be delivered to unsubscribed users.", "activated"=>false}, {"name"=>"opentrack", "title"=>"Open Tracking", "description"=>"Appends an invisible image to HTML emails to track emails that have been opened.", "activated"=>false}, {"name"=>"footer", "title"=>"Footer", "description"=>"Allows you to add a custom footer to outgoing email.", "activated"=>false}, {"name"=>"spamcheck", "title"=>"Spam Checker", "description"=>"Check outbound messages for spam content.", "activated"=>false}, {"name"=>"ganalytics", "title"=>"Google Analytics", "description"=>"Track your conversion rates and ROI with Google Analytics.", "activated"=>false}, {"name"=>"template", "title"=>"Email Template", "description"=>"Allows you to customize your outgoing HTML emails.", "activated"=>false}, {"name"=>"domainkeys", "title"=>"Domain Keys", "description"=>"Allows email to be signed with DomainKeys.", "activated"=>false}, {"name"=>"bcc", "title"=>"BCC", "description"=>"Automatically BCC an address for every e-mail sent.", "activated"=>false}, {"name"=>"eventnotify", "title"=>"Event Notification", "description"=>"Controls notifications for events, such as bounces, clicks, and opens.", "activated"=>false}, {"name"=>"seedlist", "title"=>"Return Path Seedlist", "description"=>"For Return Path customers, with your seedlist for delivery monitoring.", "activated"=>false}, {"name"=>"forwardspam", "title"=>"Forward Spam", "description"=>"Allows for a copy of spam reports to be forwarded to an email address.", "activated"=>false}, {"name"=>"addresswhitelist", "title"=>"Address Whitelist", "description"=>"Address / domains that should never have email suppressed.", "activated"=>false}, {"name"=>"dkim", "title"=>"DKIM", "description"=>"Allows email to be signed with DKIM. Cannot be disabled.", "activated"=>true}, {"name"=>"newrelic", "title"=>"SendGrid for New Relic", "description"=>"Integrate SendGrid with your New Relic account to access your email statistics via the <a target=\"blank\" href=\"https://newrelic.com/sendgrid\">New Relic</a> Dashboard.", "activated"=>false}]
    end
    
    it "should activate app" do
      client.sub_user.apps.activate(:user => "sendgrid_testuser3", :name => "opentrack").
        should == {"message"=>"success"}
    end
    
    it "should deactivate app" do
      client.sub_user.apps.deactivate(:user => "sendgrid_testuser3", :name => "opentrack").
        should == {"message"=>"success"}
    end
    
    it "should get current setting from one app" do
      client.sub_user.apps.current_settings(:user => "sendgrid_testuser3", :name => "eventnotify").
        should == {"settings"=>{"processed"=>"", "dropped"=>"", "deferred"=>"", "delivered"=>"", "bounce"=>"", "click"=>"", "open"=>"", "unsubscribe"=>"", "subscribe"=>"", "spamreport"=>"", "url"=>"", "batch"=>"", "version"=>"1"}}
    end
    
    it "should set current app" do
      client.sub_user.apps.customize(:user => "sendgrid_testuser3", :name => "eventnotify", :processed => "1", :dropped => "1", :deferred => "1",
          :delivered => "1", :delivered => "1", :bounce => "1", :click => "1", :open => "1", :unsubscribe => "1", :spamreport => "1", :url => "http://yourdomain.com/event.php").
        should == {"message"=>"success"}
      client.sub_user.apps.current_settings(:user => "sendgrid_testuser3", :name => "eventnotify").
        should == {"settings"=>{"processed"=>"1", "dropped"=>"1", "deferred"=>"1", "delivered"=>"1", "bounce"=>"1", "click"=>"1", "open"=>"1", "unsubscribe"=>"1", "subscribe"=>"", "spamreport"=>"1", "url"=>"http://yourdomain.com/event.php", "batch"=>"", "version"=>"3"}}
    end
  end
end