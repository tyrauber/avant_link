require 'spec_helper'

describe AvantLink::WebsiteFeed, :vcr do

  let(:atts){
    {
      affiliate_id: ENV['AVANT_LINK_AFFILIATE_ID'],
      website_id: ENV['AVANT_LINK_WEBSITE_ID'],
      auth_key: ENV['AVANT_LINK_API_KEY']
    }
  }

  describe "success" do
    
    let(:expectation){
      AvantLink::WebsiteFeed.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation.length).to_not eq(0)
      ["Website_Id"].each do |key|
        expect(expectation.first).to include(key)
      end
    end
  end
  
  describe "required attributes" do
    it "auth_key" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(auth_key: nil)) }.to raise_error(ArgumentError)
    end
    it "website_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(website_id: nil)) }.to raise_error(ArgumentError)
    end
    it "affilate_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(affiliate_id: nil)) }.to raise_error(ArgumentError)
    end
  end
end