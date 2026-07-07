abstract class AdminLocalDataSource {
  Future<Map<String, dynamic>> getLastAdminStats();
  Future<void> cacheAdminStats(Map<String, dynamic> statsToCache);
}

class AdminLocalDataSourceImpl implements AdminLocalDataSource {
  const AdminLocalDataSourceImpl();

  @override
  Future<Map<String, dynamic>> getLastAdminStats() async {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheAdminStats(Map<String, dynamic> statsToCache) async {
    throw UnimplementedError();
  }
}
