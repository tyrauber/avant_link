# avant_link
AvantLink Ruby Gem

Utilizes the AvantLink Api: (http://classic.avantlink.com/api.php)[http://classic.avantlink.com/api.php]

A an affiliate_id and website_id is required for all requests.  An valid affiliate auth_key is required for a few authenticated api endpoints.

This gem currrently implements the following AvantLink Api Endpoints

* (AdSearch)[http://classic.avantlink.com/api.php?help=1&module=AdSearch]
* (AssociationFeed)[http://classic.avantlink.com/api.php?help=1&module=AssociationFeed]
* (CustomLink)[http://classic.avantlink.com/api.php?help=1&module=CustomLink]
* (DotdFeed)[http://classic.avantlink.com/api.php?help=1&module=DotdFeed]
* (ProductContent)[http://classic.avantlink.com/api.php?help=1&module=ProductContent]
* (ProductPriceCheck)[http://classic.avantlink.com/api.php?help=1&module=ProductPriceCheck]
* (ProductSearch)[http://classic.avantlink.com/api.php?help=1&module=ProductSearch]
* (ProductTaxonomy)[http://classic.avantlink.com/api.php?help=1&module=ProductTaxonomy]
* (SubscriptionFeed)[http://classic.avantlink.com/api.php?help=1&module=SubscriptionSearch]
* (WebsiteFeed)[http://classic.avantlink.com/api.php?help=1&module=WebsiteFeed]

This gem is not Officical, and is in no way approved or affiliated, with AvantLink.

This is a v.0.0.1. Pull requests welcome.

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'avant_link'
```

## Usage

### Initializer

For global configuration, generate the initializer:

```ruby
rails generate avant_link_:install
```

Modify the AvantLink initializer in your app config/initialzers directory.

```ruby
AvantLink.configure do |config|
  config.auth_key = "API_KEY_GOES_HERE"
  config.affiliate_id = "AFFILIATE_ID_GOES_HERE"
  config.website_id  = "WEBSITE_ID_GOES_HERE"
end
```

You will only need affiliate_id and website_id for the open api endpoints. For the authenticated endpoints, you will need a valid auth_key for the affiliate_id.

#### Inline

Alternatively, you may pass any of these configuration options to any of the endpoints:

```ruby
AvantLink::ProductSearch({search_term: "hiking boots", affiliate_id: '101', website_id: '77'})
```

## Open API Endpoints

The following endpoints do not require an auth_key.

### AdSearch

Parameters:  affiliate_id, website_id, merchant_id

```ruby
AvantLink::AdSearch.where({
  affiliate_id: '101',
  website_id: '77',
  merchant_id: '10060'
})
```

Returns an array of hashes with the followering attributes: "Merchant_Name", "Merchant_Id", "Ad_Title", "Ad_Type", "Ad_Content", "Ad_Url", "Coupon", "Coupon_Code", "Ad_Start_Date", "Ad_Expiration_Date", "Ad_Last_Modified_Date", "Ad_Height", "Ad_Width", "Ad_Id", "Ad_Conversion_Rate"

### CustomLink

Parameters:  affiliate_id, website_id, merchant_id

```ruby
AvantLink::CustomLink.where({
  affiliate_id: '101',
  website_id: '77',
  merchant_id: '10060'
})
```

Returns a URL.

### DotdFeed

```ruby
AvantLink::DotdFeed.where({
  affiliate_id: '101',
  website_id: '77'
})
```

Returns an array of hashes including the following attributes: "SKU", "Manufacturer_Id", "Product_Name", "Brand", "Retail_Price", "Sale_Price", "Short_Description", "Long_Description", "Keywords", "Small_Image_URL", "Large_Image_URL", "Buy_URL", "Percent_Off", "Price_Difference", "Merchant_Id", "Merchant_20Id", "Merchant_Name", "Medium_Image_URL", "Quantity_On_Hand", "Deal_Last_Modified", "Variants"

### ProductContent

```ruby
AvantLink::ProductContent.where({
  affiliate_id: '101',
  website_id: '77',
  merchant_id: '10060', 
  sku: 'CHT0004'
})
```

Returns a hash with the followering attributes: "Merchant_Id", "Merchant_Name", "Datafeed_Id", "Commission", "SKU", "Manufacturer_Id", "Brand_Name", "Product_Name", "Long_Description", "Short_Description", "Category", "SubCategory", "Product_Group", "Thumb_URL", "Image_URL", "Buy_Link", "Keywords", "Reviews", "Retail_Price", "Sale_Price", "Brand_Page_Link", "Brand_Logo_Image", "Medium_Image_URL", "Google_Categorization", "Extended_Xml_Attributes"

### ProductPriceCheck

```ruby
AvantLink::ProductContent.where({
  affiliate_id: '101',
  website_id: '77',
  merchant_id: '10060', 
  sku: 'CHT0004'
})
```

Returns a hash with "Product_Price".

### ProductSearch

```ruby
AvantLink::ProductSearch({search_term: "hiking boots"})
```

Returns an array of hashes with the following attributes: "Merchant_Id", "Merchant_Name", "Datafeed_Id", "Product_Id", "Subcategory_Id", "Category_Id", "Department_Id", "Subcategory_Name", "Category_Name", "Department_Name", "Product_SKU", "Product_Name", "Brand_Name", "Retail_Price", "Sale_Price", "Abbreviated_Description", "Short_Description", "Description", "Thumbnail_Image", "Medium_Image", "Large_Image", "Buy_URL", "Match_Score", "Commission", "Match_Precision", "Product_Content_Widget", "Match_Result", "Google_Categorization"

#### Options:
* search_term (string) *Required
A word or phrase to search for.
* app_id (integer)
The AvantLink assigned identifier for an App Market application. When specified, this will trigger the construction of customized click-through URLs that track back to the particular app for any resulting sales.
* custom_tracking_code (string)
A custom string to be appended to AvantLink click-through URLs, for use with your own personal tracking mechanisms.
* datafeed_ids (string)
A pipe-delimited list of AvantLink assigned datafeed identifiers, e.g. "123|456".
* merchant_category_ids (string)
A pipe-delimited list of AvantLink assigned merchant category identifiers, e.g. "2|11"
* merchant_group_ids (string)
A pipe-delimited list of custom merchant grouping identifiers, e.g. "74|101"
* merchant_ids (string)
A pipe-delimited list of AvantLink assigned merchant identifiers, e.g. "123|456".
* output (string) Default: 'json'
The specific output format you wish to receive results in. Possible values include: csv (comma-separated text), html, js (javascript document.write	statements), rss, tab (tab-delimited text), and xml (the default). Individual modules may not support all output methods.
* search_advanced_syntax(boolean)
Enables the use of advanced search syntax, causing special treatment in the following circumstances: preceding a word with "+" will restrict the search to ONLY products that mention that word, preceding a word with "-" will restrict the search to exclude any products that mention that word, and the keyword " OR " can be used to perform multiple simultaneous searches (in place of OR you can use the pipe character "|" to separate multiple search terms).
* search_brand (string)
A product brand to which search results should be restricted (strict filter only; does not allow wildcards).
* search_category (string)
A product category to which search results should be restricted.
* search_department (string)
A department to which search results should be restricted.
* search_input_fields (string)
A pipe-delimited list of fields to examine for a given search term; by default all available fields are considered.
* search_on_sale_level (integer)
A numeric value representing how deeply discounted a product must be for inclusion in the product search results. Leave empty or 0 to include all products, regardless of whether they are on sale or not. Specify a value of 100 to restrict to only on-sale products, or 100 + discount to filter further, i.e. 110 includes only products with at least a 10% sale price discount.
* search_on_sale_only (boolean)
Whether or not to restrict to just products that are on sale (1 = yes, 0 = no).
* search_price_maximum (float)
The maximum product price (using current price, i.e. sale price where applicable) to allow into the search results; only products priced lower than this value will be included.
* search_price_minimum (float)
The minimum product price (using current price, i.e. sale price where applicable) to allow into the search results; only products priced higher than this value will be included.
* search_results_base (integer)
The base record to start with for results; default is 0.
* search_results_count (integer)
How many records to show in the results; the default is 10.
* search_results_fields (string)
Pipe-delimited list of fields to include in results, e.g. "Product Name|Retail Price|Description". It is possible to include all default fields plus a non-default field, e.g. "*|Variants XML". It is also possible to include formatted layout "templates" in the list of result fields, similar to advanced layouts in the Product Display Builder tool. To use this functionality, incorporate bracketed field names into HTML in your list of fields, for example: <div><a href="[Buy URL]">[Product Name]</a><br />[Description]</div>
* search_results_layout (string)
How to format search results: "list", or "grid". For "grid" output an additional numeric value can be appended to indicate how many columns should be used in the layout, e.g. "grid2", "grid3", etc.
* search_results_merchant_limit (integer)
The maximum number of results to return for each merchant.
* search_results_options (string)
Miscellaneous search result display options. For HTML or JavaScript output, "nofollow" will cause links to be output with the rel="nofollow" attribute; "noheader" will suppress field/column headings from output. If multiple merchants/datafeeds are used for the search, and the number of records to return is specified (see "search_results_count"), then "interleave" will attempt to distribute the results evenly across each available merchant. The "precise" option will restrict your search results to just the most precise matches, i.e. those matching the greatest number of keywords from your original search term. The "sortearly" option controls sorting and record count limitation. By default the result is limited to the top N matches before sorting is applied; "sortearly" will reverse that so that sorting is performed first, and then the top N records are returned.
* search_results_pagination_base (string)
The base URL to use for paginating search results, i.e. the URL that all page requests should go to. Usually, this will just be the full URL of the page that you are making your API request from.
* search_results_sort_order (string)
A pipe-delimited list of information about how to sort the results, e.g. "Merchant Name|desc". The first part of the string should be the field to sort by, and the second should be the order (asc = ascending, desc = descending).
* search_subcategory (string)
A product sub-category to which search results should be restricted.

(Documentation)[http://classic.avantlink.com/api.php?help=1&module=ProductSearch]

### ProductTaxonomy

```ruby
AvantLink::ProductTaxonomy.where({
  affiliate_id: '101',
  website_id: '77',
  merchant_id: '10060'
})
```

Returns an array of hashes with the following attributes: "Datafeed_Id", "Datafeed_Name", "Record_Type", "Category_Id", "SubCategory_Id", "Product_Group_Id", "Category_Name", "SubCategory_Name", "Product_Group_Name"
      

## Authenticated Endpoints

The following endoints require a valid auth_key for the supplied affiliate_id.

### AssociationFeed

Parameters:  affiliate_id, website_id, merchant_id

```ruby
AvantLink::AssociationFeed.where({
  affiliate_id: ENV['AVANT_LINK_AFFILIATE_ID'],
  website_id: ENV['AVANT_LINK_WEBSITE_ID'],
  auth_key: ENV['AVANT_LINK_API_KEY']
})
```

Returns an array of hashes with the followering attributes: "Merchant_Id", "Merchant_Name", "Merchant_Category_Id", "Merchant_Category_Name", "Association_Status", "Commission_Action", "Commission_Type", "Commission_Rate", "Referral_Days", "Reversal_Days", "Date_Joined", "Merchant_Logo", "Merchant_URL", "Available_Tools", "Default_Tracking_URL", "AvantLink_Exclusive", "Network_Conversion_Rate", "Network_Reversal_Rate", "Network_Average_Sale_Amount", "Earnings_Per_Click", "Sales_Volume", "Default_Program_Commission_Rate"

### WebsiteFeed

Parameters:  affiliate_id, website_id, merchant_id

```ruby
AvantLink::WebsiteFeed.where({
  affiliate_id: ENV['AVANT_LINK_AFFILIATE_ID'],
  website_id: ENV['AVANT_LINK_WEBSITE_ID'],
  auth_key: ENV['AVANT_LINK_API_KEY']
})
```

Returns an array of hashes with the followering attributes: "Merchant_Id", "Merchant_Name", "Merchant_Category_Id", "Merchant_Category_Name", "Association_Status", "Commission_Action", "Commission_Type", "Commission_Rate", "Referral_Days", "Reversal_Days", "Date_Joined", "Merchant_Logo", "Merchant_URL", "Available_Tools", "Default_Tracking_URL", "AvantLink_Exclusive", "Network_Conversion_Rate", "Network_Reversal_Rate", "Network_Average_Sale_Amount", "Earnings_Per_Click", "Sales_Volume", "Default_Program_Commission_Rate"
      
