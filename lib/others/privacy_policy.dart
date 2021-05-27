import 'package:Alaswaq/utils/constants.dart';
import 'package:Alaswaq/utils/style/color.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String text1 ='''Your privacy is important to us and this Privacy Policy sets out how the we collect, use and protect any personal information when you visit or make an order. By using our website or mobile version of our website (from here on referred to as “Platform”), you agree to the collection and use of information according to this Policy.

The Website Policies and Terms & Conditions may be changed or updated occasionally to meet the requirements and standards. Therefore, the Customers’ are encouraged to frequently visit these sections to be updated about the changes on the website. Modifications will be effective on the day they are posted.


INFORMATION WE COLLECT
Information you provide to us or allow others to provide to us
At various points in the Platform experience, you may provide us with information about yourself. For example, when you create an account with our Platform, you provide us with personal information like your name, email address, and zip code. And if you place an order with our Platform, we collect information including your address, phone number and the details of your order.

If you log into the Platform service through a third-party, we may receive some information about you through them. For example, if you choose to log into our Platform with your Facebook account, we may receive information about your contacts. We may also offer social sharing tools (such as the Facebook Like button) that let you share actions on our Platform with other sites and vice versa. You should check the privacy policies of these services and your settings there for more information.

Technical information about usage of our Platform
When you use the Platform services, either through a browser or mobile app, we automatically receive some technical information about the hardware and software that is being used.


COOKIES AND OTHER TRACKING TECHNOLOGIES
We and our partners use various technologies to collect information, including cookies and device identifiers. Cookies are small text files that are sent by your computer when you access our services through a browser. We may use session cookies (which expire when you close your browser), persistent cookies (which expire when you choose to clear them from your browser), and other identifiers to collect information from your browser or device that helps us personalize your experience and remember things like your current zip code or that you have already logged in to the Platform.


LOG INFORMATION
When you use the Platform, our servers will record information about your usage of the service and information that is sent by your browser or device. Logs information can include things like the IP address of your device, information about the browser, operating system and/or app you are using, unique device identifiers, pages that you navigate to and links that you click, searches that you run on the Platform, and other ways you interact with the service. If you are logged into the Platform service, this information is stored with your account information. All credit/debit cards’ details and personally identifiable information will NOT be stored, sold, shared, rented or leased to any third parties. www.aswaqrak.ae will not pass any debit/credit card details to third parties. www.aswaqrak.ae takes appropriate steps to ensure data privacy and security including through various hardware and software methodologies. However, (https://aswaqrak.ae) cannot guarantee the security of any information that is disclosed online.

Some of the advertisements you see on the Site are selected and delivered by third parties, such as ad networks, advertising agencies, advertisers, and audience segment providers. These third parties may collect information about you and your online activities, either on the Site or on other websites, through cookies, web beacons, and other technologies in an effort to understand your interests and deliver to your advertisements that are tailored to your interests. Please remember that we do not have access to, or control over, the information these third parties may collect. The information practices of these third parties are not covered by this privacy policy.


HOW WE USE YOUR INFORMATION
We may use the information we collect for various purposes, including to:

Provide the Platform service to you and to improve the quality of the service we’re able to offer
Allow your Personal Shopper (which includes those that shop for and deliver the order on your behalf) to choose your items at a retailer site, deliver your items to you, and call or text you with any updates or problems
Charge you for the purchase and service costs through one or more payment processing partners
Offer you customized content (including advertising and promotions), such as prominently displaying items you purchase frequently.
Understand how users interact with our service as a whole in order to test new features and improve the Platform for everyone
Provide customer service, respond to your communications and requests, and contact you about your use of our Platform (Note: You can opt-out of receiving promotional communications from the Platform by using the settings on the Account Info page)

WHAT WE SHARE
Our website or mobile version of the website is a platform that may connects users with Personal Shoppers who shop for and deliver the goods that you want from retailers. In order to make this work, we need to share information about you and your order with the other parties who help enable the service. This includes, for example, the Personal Shopper(s) who pick and deliver your order.

We also share information under the following principles
With your consent or at your direction We will share your information with entities outside of the Platform when we have your consent to do so or it is done at your direction. For example:
If you enter loyalty card information from a particular retailer, we share that information with the retailer you chose along with your order so that information can update your loyalty card account.
If you invite friends to use our Platform through our referral program Platform Friend, we will share some information with the friends you invite like your name and phone number.
For external processing We sometimes employ third parties outside of the Platform to process information on our behalf in compliance with this Privacy Policy and using other appropriate security and confidentiality measures
For legal purposes We share your information when we believe that the disclosure is reasonably necessary to (a) comply with applicable laws, regulations, legal process, or requests from law enforcement or regulatory authorities, (b) prevent, detect, or otherwise handle fraud, security, or technical issues, and (c) protect the safety, rights, or property of any person, the public, or the Platform.
On a non-personal or aggregate basis, we share information with retailers and advertisers on both a non-personally identifying basis (including order and delivery details but not including credit card information) and an aggregate basis.
For business purposes We may share your information in connection with, or during negotiations of, any merger, sale of company assets, financing or acquisition of all or a portion of our business by another company. We may also share your information between and among the Platform, and its current and future parents, affiliates, subsidiaries, and other companies under common control and ownership.

GDPR COMPLIANCE
As per the recent changes in the EU’s Data Protection act, we extend the right to personal information management to all our users, not only EU citizens. You are free to refuse our request for your personal information at any time, with the understanding that we may be unable to provide you with some or in some cases any of our Platform services.

Your continued use of our website will be regarded as a vote of trust of our practices around privacy and a continued acceptance of handling your personal information. If you have any questions about how we handle user data and personal information, feel free to contact us. You have the right to demand access to all your personal data available in our system and you also have the right to ask us to remove that data from our system at any time.

  

CONTACT INFORMATION
If you have any questions or comments about our Privacy Policy or Customer Service inquiries, please refer below contact details:

Office Address: Al Aswaq RAK National Markets, Al Jazeera, Ras Al Khaimah, U.A.E.

Email Address: customerservice@aswaqrak.ae

Contact Number: +971 600 500202''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // hides leading widget
//        flexibleSpace: Container(),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
              size: 30,
            ),
          ),
          title:
          Text(
            'Privacy Policy',
            style: TextStyle( fontFamily: 'montserrat',
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
//          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(10,20,10,20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                verticalSpace(),
                Text(
                  "   Your privacy is important to us and this Privacy Policy sets out how the we collect, use and protect any personal information when you visit or make an order. By using our website or mobile version of our website (from here on referred to as “Platform”), you agree to the collection and use of information according to this Policy.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "   The Website Policies and Terms & Conditions may be changed or updated occasionally to meet the requirements and standards. Therefore, the Customers’ are encouraged to frequently visit these sections to be updated about the changes on the website. Modifications will be effective on the day they are posted.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  'INFORMATION WE COLLECT',
                  style: TextStyle( fontFamily: 'montserrat',
                    color: HexColor("302c98"),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,),
                  textAlign: TextAlign.justify,
                ),
                Text(
                    "Information you provide to us or allow others to provide to us",
                    style: TextStyle( fontFamily: 'montserrat',
                        color: HexColor("302c98"),
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                verticalSpace(),
                Text(
                  "   At various points in the Platform experience, you may provide us with information about yourself. For example, when you create an account with our Platform, you provide us with personal information like your name, email address, and zip code. And if you place an order with our Platform, we collect information including your address, phone number and the details of your order.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "   If you log into the Platform service through a third-party, we may receive some information about you through them. For example, if you choose to log into our Platform with your Facebook account, we may receive information about your contacts. We may also offer social sharing tools (such as the Facebook Like button) that let you share actions on our Platform with other sites and vice versa. You should check the privacy policies of these services and your settings there for more information.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "Technical information about usage of our Platform",
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "   When you use the Platform services, either through a browser or mobile app, we automatically receive some technical information about the hardware and software that is being used.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  'COOKIES AND OTHER TRACKING TECHNOLOGIES',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                Text(
                  "   We and our partners use various technologies to collect information, including cookies and device identifiers. Cookies are small text files that are sent by your computer when you access our services through a browser. We may use session cookies (which expire when you close your browser), persistent cookies (which expire when you choose to clear them from your browser), and other identifiers to collect information from your browser or device that helps us personalize your experience and remember things like your current zip code or that you have already logged in to the Platform.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),


                verticalSpace(),
                Text(
                  'LOG INFORMATION',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   When you use the Platform, our servers will record information about your usage of the service and information that is sent by your browser or device. Logs information can include things like the IP address of your device, information about the browser, operating system and/or app you are using, unique device identifiers, pages that you navigate to and links that you click, searches that you run on the Platform, and other ways you interact with the service. If you are logged into the Platform service, this information is stored with your account information. All credit/debit cards’ details and personally identifiable information will NOT be stored, sold, shared, rented or leased to any third parties. www.aswaqrak.ae will not pass any debit/credit card details to third parties. www.aswaqrak.ae takes appropriate steps to ensure data privacy and security including through various hardware and software methodologies. However, (https://aswaqrak.ae) cannot guarantee the security of any information that is disclosed online.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,

                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "   Some of the advertisements you see on the Site are selected and delivered by third parties, such as ad networks, advertising agencies, advertisers, and audience segment providers. These third parties may collect information about you and your online activities, either on the Site or on other websites, through cookies, web beacons, and other technologies in an effort to understand your interests and deliver to your advertisements that are tailored to your interests. Please remember that we do not have access to, or control over, the information these third parties may collect. The information practices of these third parties are not covered by this privacy policy.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  'HOW WE USE YOUR INFORMATION',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   We may use the information we collect for various purposes, including to:",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  ". Provide the Platform service to you and to improve the quality of the service we’re able to offer " + "\n" + "\n" +
                      ". Allow your Personal Shopper (which includes those that shop for and deliver the order on your behalf) to choose your items at a retailer site, deliver your items to you, and call or text you with any updates or problems" + "\n"+"\n" +
                      ". Charge you for the purchase and service costs through one or more payment processing partners" + "\n" + "Offer you customized content (including advertising and promotions), such as prominently displaying items you purchase frequently." + "\n" +"\n" +
                      ". Understand how users interact with our service as a whole in order to test new features and improve the Platform for everyone" + "\n" +"\n" +
                      ". Provide customer service, respond to your communications and requests, and contact you about your use of our Platform (Note: You can opt-out of receiving promotional communications from the Platform by using the settings on the Account Info page)'" ,
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),verticalSpace(),
                Text(
                  'WHAT WE SHARE',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   Our website or mobile version of the website is a platform that may connects users with Personal Shoppers who shop for and deliver the goods that you want from retailers. In order to make this work, we need to share information about you and your order with the other parties who help enable the service. This includes, for example, the Personal Shopper(s) who pick and deliver your order."
                  ,
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),verticalSpace(),
                Text(
                  'We also share information under the following principles',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),

                verticalSpace(),
                Text(
                  ". With your consent or at your direction We will share your information with entities outside of the Platform when we have your consent to do so or it is done at your direction. For example: " + "\n" + "\n" +
                      ". If you enter loyalty card information from a particular retailer, we share that information with the retailer you chose along with your order so that information can update your loyalty card account." + "\n"+"\n" +
                      ". If you invite friends to use our Platform through our referral program Platform Friend, we will share some information with the friends you invite like your name and phone number." + "\n" + ".  For external processing We sometimes employ third parties outside of the Platform to process information on our behalf in compliance with this Privacy Policy and using other appropriate security and confidentiality measures" + "\n" +"\n" +
                      ". For legal purposes We share your information when we believe that the disclosure is reasonably necessary to (a) comply with applicable laws, regulations, legal process, or requests from law enforcement or regulatory authorities, (b) prevent, detect, or otherwise handle fraud, security, or technical issues, and (c) protect the safety, rights, or property of any person, the public, or the Platform." + "\n" +"\n" +
                      ". On a non-personal or aggregate basis, we share information with retailers and advertisers on both a non-personally identifying basis (including order and delivery details but not including credit card information) and an aggregate basis." + "\n"+"\n" +
                      ". For business purposes We may share your information in connection with, or during negotiations of, any merger, sale of company assets, financing or acquisition of all or a portion of our business by another company. We may also share your information between and among the Platform, and its current and future parents, affiliates, subsidiaries, and other companies under common control and ownership."
                  ,
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),verticalSpace(),

                Text(
                  'GDPR COMPLIANCE',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   As per the recent changes in the EU’s Data Protection act, we extend the right to personal information management to all our users, not only EU citizens. You are free to refuse our request for your personal information at any time, with the understanding that we may be unable to provide you with some or in some cases any of our Platform services.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "  Your continued use of our website will be regarded as a vote of trust of our practices around privacy and a continued acceptance of handling your personal information. If you have any questions about how we handle user data and personal information, feel free to contact us. You have the right to demand access to all your personal data available in our system and you also have the right to ask us to remove that data from our system at any time.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                verticalSpace(),
                Text(
                  'CONTACT INFORMATION',
                  style: TextStyle( fontFamily: 'montserrat',
                      color: HexColor("302c98"),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(),
                Text(
                  "   If you have any questions or comments about our Privacy Policy or Customer Service inquiries, please refer below contact details:",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "  Office Address: Al Aswaq RAK National Markets, Al Jazeera, Ras Al Khaimah, U.A.E.",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                Text(
                  "  Contact Number: +971 600 500202",
                  style: TextStyle( fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  textAlign: TextAlign.justify,),
                verticalSpace(),
                verticalSpace(),
              ],

            )
            ,

          ),
        )
    );
  }
}

