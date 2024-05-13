//"API_ENDPOINT": "https://heronavi-dev.watermeru.com",

const CONFIG_DEV = {
  "API_ENDPOINT": "https://blog-back-end-2.onrender.com",
  "FLAVOR": "dev",
  "URL_SUBSCRIBE_PLAN": "/users/user-point-setting",
  "USER_PRO_PLAN_PRODUCT_ID": "",
  "PREFIX_CONFIG" : "ERpZlCJ1oJxq2Sg",
  "SOCKET_CONFIG" : "wss://ws-membersite.watermeru.com",
};
const CONFIG_STAGING = {
  "API_ENDPOINT": "",
  "FLAVOR": "staging",
  "URL_SUBSCRIBE_PLAN": "/users/user-point-setting",
  "USER_PRO_PLAN_PRODUCT_ID": "",
  "PREFIX_CONFIG" : "",
  "SOCKET_CONFIG" : "wss://s.on-grit.jp",
};

const CONFIG_PROD = {
  "API_ENDPOINT": "https://blog-back-end-2.onrender.com",
  // "API_ENDPOINT": "https://s.on-grit.jp",
  "FLAVOR": "prod",
  "URL_SUBSCRIBE_PLAN": "/users/user-point-setting",
  "USER_PRO_PLAN_PRODUCT_ID": "",
  "PREFIX_CONFIG" : "default",
  "SOCKET_CONFIG" : "wss://on-grit.jp",
};



class Config {
  String _apiEndpoint = "";
  String _flavor = "";
  String _urlSubscribePlan = "";
  String _userPlanProProductId = "";
  String _prefixConfig = "";
  String _socketConfig = "";

  String get apiEndpoint {
    return this._apiEndpoint;
  }

  String get flavor {
    return this._flavor;
  }

  String get urlSubscribePlan {
    return this._apiEndpoint + this._urlSubscribePlan;
  }

  String get userPlanProProductId {
    return this._userPlanProProductId;
  }

  String get prefixConfig {
    return this._prefixConfig;
  }

  String get socketConfig {
    return this._socketConfig;
  }
  @override
  String toString() {
    return "Config: _apiEndpoint: $_apiEndpoint";
  }

  static final Config _singleton = Config._internal();

  static void load(Map configValues) {
    _singleton._apiEndpoint = configValues['API_ENDPOINT']!;
    _singleton._flavor = configValues['FLAVOR']!;
    _singleton._urlSubscribePlan = configValues['URL_SUBSCRIBE_PLAN']!;
    _singleton._userPlanProProductId =
        configValues['USER_PRO_PLAN_PRODUCT_ID']!;
    print("loaded config $_singleton");
    _singleton._prefixConfig = configValues['PREFIX_CONFIG']!;
    _singleton._socketConfig = configValues['SOCKET_CONFIG']!;
  }

  static void setApiEndpoint(String endpoint) {
    if (endpoint.isEmpty) {
      print("setApiEndpoint cannot be empty");
      return;
    }
    _singleton._apiEndpoint = endpoint;
    print("setApiEndpoint ${_singleton._apiEndpoint}");
  }

  static void setSocketConfig(String socketConfig) {
    if (socketConfig.isEmpty) {
      print("setApiEndpoint cannot be empty");
      return;
    }
    _singleton._socketConfig = socketConfig;
    print("setApiEndpoint ${_singleton._socketConfig}");
  }



  factory Config.defaultInstance() {
    return _singleton;
  }

  Config._internal();
}
