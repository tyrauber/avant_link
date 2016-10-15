require 'spec_helper'

describe AvantLink::AssociationFeed, :vcr do

  let(:atts){
    {
      affiliate_id: ENV['AVANT_LINK_AFFILIATE_ID'],
      website_id: ENV['AVANT_LINK_WEBSITE_ID'],
      auth_key: ENV['AVANT_LINK_API_KEY']
    }
  }

  describe "success" do
    
    let(:expectation){
      AvantLink::AssociationFeed.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation.length).to_not eq(0)
      ["Merchant_Id", "Merchant_Name", "Merchant_Category_Id", "Merchant_Category_Name", "Association_Status", "Commission_Action", "Commission_Type", "Commission_Rate", "Referral_Days", "Reversal_Days", "Date_Joined", "Merchant_Logo", "Merchant_URL", "Available_Tools", "Default_Tracking_URL", "AvantLink_Exclusive", "Network_Conversion_Rate", "Network_Reversal_Rate", "Network_Average_Sale_Amount", "Earnings_Per_Click", "Sales_Volume", "Default_Program_Commission_Rate"].each do |key|
        expect(expectation.first).to include(key)
      end
    end
  end
  
  
  describe "required attributes" do
    it "auth_key" do
      expect { AvantLink::AssociationFeed.where(atts.merge!(auth_key: nil)) }.to raise_error(ArgumentError)
    end
    it "website_id" do
      expect { AvantLink::AssociationFeed.where(atts.merge!(website_id: nil)) }.to raise_error(ArgumentError)
    end
    it "affilate_id" do
      expect { AvantLink::AssociationFeed.where(atts.merge!(affiliate_id: nil)) }.to raise_error(ArgumentError)
    end
  end
end