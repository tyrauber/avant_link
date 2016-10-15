require 'spec_helper'

describe AvantLink::ProductSearch, :vcr do
  
  let(:atts){
    {
      search_term: 'hiking backpack',
      affiliate_id: '101',
      website_id: '77'
    }
  }

  describe "success" do

    let(:expectation){
      AvantLink::ProductSearch.where(atts)
    }

    it "should not be empty" do
      expect(expectation).to_not be_empty
    end

    it "should have attributes" do
      ["Merchant_Id", "Merchant_Name", "Datafeed_Id", "Product_Id", "Subcategory_Id", "Category_Id", "Department_Id", "Subcategory_Name", "Category_Name", "Department_Name", "Product_SKU", "Product_Name", "Brand_Name", "Retail_Price", "Sale_Price", "Abbreviated_Description", "Short_Description", "Description", "Thumbnail_Image", "Medium_Image", "Large_Image", "Buy_URL", "Match_Score", "Commission", "Match_Precision", "Product_Content_Widget", "Match_Result", "Google_Categorization"].each do |k|
        expect(expectation.first).to include(k)
      end
    end
  end

  describe "required attributes" do
    it "search_term" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(search_term: nil)) }.to raise_error(ArgumentError)
    end
    it "website_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(website_id: nil)) }.to raise_error(ArgumentError)
    end
    it "affilate_id" do
      expect { AvantLink::WebsiteFeed.where(atts.merge!(affiliate_id: nil)) }.to raise_error(ArgumentError)
    end
  end
end