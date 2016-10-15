require 'spec_helper'

describe AvantLink::ProductPriceCheck, :vcr do

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
      AvantLink::ProductPriceCheck.where(atts)
    }
  
    it "should not be empty" do
      expect(expectation).to have_key("Product_Price")
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