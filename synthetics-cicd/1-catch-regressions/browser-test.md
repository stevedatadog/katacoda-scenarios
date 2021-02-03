You now have API tests to monitor the availability, performance, and functionality of the Storedog discounts service. For the rest of this course, you'll work with Browser Tests to monitor Storedog's frontend to ensure a good user experience. 

Earlier in this lab you saw how the Storedog frontend displays the response from the discounts service in the upper-left corner of the home page:

![Coupon section detail of Storedog homepage](./assets/coupon_section_detail.png)

API tests make assertions about the raw content of HTTP responses, and browser tests make powerful assertions about the Document Object Model (DOM) as rendered by a browser.  For example, "This specific element is in the upper-left corner of the homepage," or "This heading is not empty and is displayed with the Helvetica font at 20 pixels."

The business requirements for the coupon block are:
1. It's displayed in the upper-right of the home page
2. It displays a non-empty heading
3. It contains a valid coupon code 
4. It contains the correct coupon value, formatted as USD currency

**Note**: *You will notice that the domain language for the discounts service is getting a little hazy. The Storedog frontend folks refer to discounts as "coupon codes," because that's how discounts are modeled for customers. This inconsistency will give you something to troubleshoot in the second half of this course!* 

Now you can turn these frontend business requirements into a browser test.

## Create a Simple Browser Test
