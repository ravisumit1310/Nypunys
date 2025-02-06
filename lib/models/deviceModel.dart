class DeviceInfo {
  String? deviceName;
  String? deviceVersion;
  String? identifier;
  String? source;
  String? currentBuildVersion;
  String? appName, packageName, version, buildNumber;

  DeviceInfo(
      {this.deviceName,
      this.deviceVersion,
      this.identifier,
      this.source,
      this.appName,
      this.packageName,
      this.buildNumber,
      this.currentBuildVersion,
      this.version});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceName = json['deviceName'];
    deviceVersion = json['deviceVersion'];
    identifier = json['identifier'];
    source = json['source'];
    currentBuildVersion = json['currentBuildVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceName'] = this.deviceName;
    data['deviceVersion'] = this.deviceVersion;
    data['identifier'] = this.identifier;
    data['source'] = this.source;
    data['currentBuildVersion'] = this.currentBuildVersion;
    data['appName'] = this.appName;
    data['packageName'] = this.packageName;
    data['version'] = this.version;
    data['buildNumber'] = this.buildNumber;

    return data;
  }
}
