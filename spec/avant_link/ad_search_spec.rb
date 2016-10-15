require 'spec_helper'

describe AvantLink::AdSearch, :vcr do

  let(:atts){
    {
      affiliate_id: '101',
      website_id: '77',
      merchant_id: '10060'
    }
  }
  
  describe "success" do
    
    let(:expectation){
      AvantLink::AdSearch.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation.length).to_not eq(0)
      ["Merchant_Name", "Merchant_Id", "Ad_Title", "Ad_Type", "Ad_Content", "Ad_Url", "Coupon", "Coupon_Code", "Ad_Start_Date", "Ad_Expiration_Date", "Ad_Last_Modified_Date", "Ad_Height", "Ad_Width", "Ad_Id", "Ad_Conversion_Rate"].each do |key|
        expect(expectation.first).to include(key)
      end
    end
  end
  
  describe "required attributes" do
    it "merchant_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(merchant_id: nil)) }.to raise_error(ArgumentError)
    end
    it "website_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(website_id: nil)) }.to raise_error(ArgumentError)
    end
    it "affilate_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(affiliate_id: nil)) }.to raise_error(ArgumentError)
    end
  end
end