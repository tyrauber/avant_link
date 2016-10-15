require 'spec_helper'

describe AvantLink::ProductContent, :vcr do


  let(:atts){
    {
      affiliate_id: '101',
      website_id: '77',
      merchant_id: '10060', 
      sku: 'CHT0004'
    }
  }

  describe "merchant_id" do
    
    let(:expectation){
      AvantLink::ProductContent.where(atts)
    }
  
    it "should not be empty" do
      ["Merchant_Id", "Merchant_Name", "Datafeed_Id", "Commission", "SKU", "Manufacturer_Id", "Brand_Name", "Product_Name", "Long_Description", "Short_Description", "Category", "SubCategory", "Product_Group", "Thumb_URL", "Image_URL", "Buy_Link", "Keywords", "Reviews", "Retail_Price", "Sale_Price", "Brand_Page_Link", "Brand_Logo_Image", "Medium_Image_URL", "Google_Categorization", "Extended_Xml_Attributes"].each do |key|
        expect(expectation).to have_key(key)
      end
    end
  end
  
  describe "required attributes" do
    it "sku" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(sku: nil)) }.to raise_error(ArgumentError)
    end
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