require 'spec_helper'

module AvantLink
  describe Configuration do

    context "attributes" do
      describe "#auth_key" do
        it "default value is nil" do
          expect(Configuration.new.auth_key).to be_nil
        end

        it "can set and change value" do
          config = Configuration.new(auth_key: "ABCD")
          expect(config.auth_key).to eq("ABCD")
          config.auth_key = "1234"
          expect(config.auth_key).to eq("1234")
        end
      end

      describe "#affiliate_id" do
        it "default value is nil" do
          expect(Configuration.new.affiliate_id).to be_nil
        end
  
        it "can set and change value" do
          config = Configuration.new(affiliate_id: "ABCD")
          expect(config.affiliate_id).to eq("ABCD")
          config.affiliate_id = "1234"
          expect(config.affiliate_id).to eq("1234")
        end
      end

      describe "#website_id" do
        it "default value is nil" do
          expect(Configuration.new.website_id).to be_nil
        end
  
        it "can set and change value" do
          config = Configuration.new(website_id: "ABCD")
          expect(config.website_id).to eq("ABCD")
          config.website_id = "1234"
          expect(config.website_id).to eq("1234")
        end
      end
    end
    context "configure" do
      before(:each) do
        AvantLink.configure do |config|
          config.auth_key = "1234"
          config.affiliate_id = "12345"
          config.website_id = "123456"
        end
      end
      
      it "should set globals" do
        expect(AvantLink.options[:auth_key]).to eq("1234")
        expect(AvantLink.options[:affiliate_id]).to eq("12345")
        expect(AvantLink.options[:website_id]).to eq("123456")
      end
      
      it "should be changeable" do
        AvantLink.configuration.affiliate_id = "ABCD"
        expect(AvantLink.options[:affiliate_id]).to eq("ABCD")
      end
    end
  end
end