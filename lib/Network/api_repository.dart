import 'dart:convert';
import 'package:Alaswaq/Model/banner_model.dart';
import 'package:Alaswaq/Model/category_model.dart';
import 'package:Alaswaq/Model/product_list_model.dart';
import 'package:Alaswaq/Model/register_model.dart';
import 'package:Alaswaq/common/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class ApiRepository {
  UserRegistration userreg_model ;
  static ProductListModel productList;
  var registerError = "";
  static   Future<UserRegistration> resgisterUserApi (String email, String firstName, String lstName,String password) async {
    var url = baseUrl + 'rest/V1/customers';
    try {
      Map data =  {
        "customer": {
          "email": email,
          "firstname": firstName,
          "lastname": lstName,
          "store_id": 1,
          "website_id": 1,

        },
        "password": password
      };
      print(data);
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("registration response");
        print(responseJson);

        UserRegistration userData =   UserRegistration.fromJson(responseJson);
        debugPrint('after parsing');
        return userData;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<String> loginTokenApi (String email, String password) async {
    var url =baseUrl + 'rest/V1/integration/customer/token';
    try {
      Map data = {
        "username": email,
        "password": password
      };

      print(data);
      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("login response");
        print(responseJson);

        return responseJson;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<UserRegistration> loginUserApi (String token) async {
    var url =baseUrl + 'rest/V1/customers/me';
    try {
      String headerText = "Bearer " + token;
      var response = await http.get(Uri.parse(url),
          headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: headerText}
      );
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("login response");
        print(responseJson);

        UserRegistration userData =   UserRegistration.fromJson(responseJson);
        debugPrint('after parsing');
        return userData;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<BannerModel> loadBannerAPI () async {
    var url =baseUrl + 'rest/V1/cmsBlock/26';
    try {
      print(url);
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("banner response");
        print(responseJson);

        BannerModel bannerData =   BannerModel.fromJson(responseJson);
        print(bannerData);
        debugPrint('after parsing');
        return bannerData;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> loadProduct () async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[pageSize]=5& searchCriteria[filter_groups][0][filters][0][value]=81&searchCriteria[sortOrders][1][field]=position&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
//    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
//        print("product listing response");
//        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
//        debugPrint('after parsing');
        return productList;
      } else
      {
//        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<CategoryModel> loadCategoryList () async {
    var url =baseUrl + 'rest/V1/categories';
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("category listing response");
        print(responseJson);

        CategoryModel productList =   CategoryModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
//
  static   Future<ProductListModel> loadBestProduct () async {
    var url =baseUrl + 'rest/V1/products?searchCriteria[filterGroups][1][filters][0][field]=status& searchCriteria[filterGroups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][0][field]=created_at&searchCriteria[sortOrders][0][direction]=DESC&searchCriteria[pageSize]=9& searchCriteria[currentPage]=88&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    try {

      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("diary listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<ProductListModel> loadProductByCat (int id) async {
    var url =baseUrl + 'rest/V1/products?searchCriteria[sortOrders][0][field]=price&searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=15&searchCriteria[filter_groups][2][filters][0][field]=status&searchCriteria[filter_groups][2][filters][0][value]=1&searchCriteria[filter_groups][2][filters][0][condition_type]=eq&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    try {

      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("diary listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> loadhotSellingProduct (int id, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> loadMoreProduct (int id, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> sortOnPostion (int id, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=position&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<ProductListModel> sortOnName (int id, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> sortOnPriceForName (String keyword, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$keyword%&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=price&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<ProductListModel> sortOnPostionForName (String keyword, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$keyword%&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=position&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static   Future<ProductListModel> sortOnNameForName (String keyword, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=$keyword%&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> sortOnPrice (int id, int count) async {
    var url = baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id& searchCriteria[filter_groups][0][filters][0][value]=$id&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=price&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq';
    print("inside api respo");
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("meat listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  static   Future<ProductListModel> loadHomeSearch (String  keyword, int count) async {
    var url =baseUrl + 'rest/V1/products?searchCriteria[filter_groups][0][filters][1][field]=name&searchCriteria[filter_groups][0][filters][1][condition_type]=like&searchCriteria[filter_groups][0][filters][1][value]=%$keyword%&searchCriteria[filter_groups][1][filters][0][field]=status&searchCriteria[filter_groups][1][filters][0][value]=1&searchCriteria[filter_groups][1][filters][0][condition_type]=eq&searchCriteria[sortOrders][1][field]=name&searchCriteria[sortOrders][1][direction]=ASC&searchCriteria[pageSize]=$count&searchCriteria[filter_groups][3][filters][0][field]=visibility&searchCriteria[filter_groups][3][filters][0][value]=1&searchCriteria[filter_groups][3][filters][0][condition_type]=neq&&searchCriteria[filter_groups][0][filters][2][field]=short_description&searchCriteria[filter_groups][0][filters][2][value]=%$keyword%&searchCriteria[filter_groups][0][filters][2][condition_type]=like';
    try {

      var response = await http.get(Uri.parse(url),
        headers: {"Content-Type": "application/json"},

      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print("home search listing response");
        print(responseJson);

        ProductListModel productList =   ProductListModel.fromJson(responseJson);
        debugPrint('after parsing');
        return productList;
      } else
      {
        debugPrint('list ERROR');
        return null;
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}
