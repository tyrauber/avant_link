require 'spec_helper'

describe AvantLink::DotdFeed, :vcr do

  let(:atts){
    {
      affiliate_id: '101',
      website_id: '77'
    }
  }

  describe "affiliate_id" do
    
    let(:expectation){
      AvantLink::DotdFeed.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation).to_not be_empty
    end
    
    it "should have attributes" do
      ["SKU", "Manufacturer_Id", "Product_Name", "Brand", "Retail_Price", "Sale_Price", "Short_Description", "Long_Description", "Keywords", "Small_Image_URL", "Large_Image_URL", "Buy_URL", "Percent_Off", "Price_Difference", "Merchant_Id", "Merchant_20Id", "Merchant_Name", "Medium_Image_URL", "Quantity_On_Hand", "Deal_Last_Modified", "Variants"].each do |k|
        expect(expectation.first).to include(k)
      end
    end
  end
  
  describe "required attributes" do
    it "website_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(website_id: nil)) }.to raise_error(ArgumentError)
    end
    it "affilate_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(affiliate_id: nil)) }.to raise_error(ArgumentError)
    end
  end
end