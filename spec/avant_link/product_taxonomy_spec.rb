require 'spec_helper'

describe AvantLink::ProductTaxonomy, :vcr do

  let(:atts){
    {
      affiliate_id: '101',
      website_id: '77',
      merchant_id: '10060'
    }
  }

  describe "merchant_id" do
    
    let(:expectation){
      AvantLink::ProductTaxonomy.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation.length).to_not eq(0)
      ["Datafeed_Id", "Datafeed_Name", "Record_Type", "Category_Id", "SubCategory_Id", "Product_Group_Id", "Category_Name", "SubCategory_Name", "Product_Group_Name"].each do |key|
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