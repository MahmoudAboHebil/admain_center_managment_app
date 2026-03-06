abstract class LocalDbOperations<T> {
  Future<void> insertToLocalDB(T model);
  Future<void> deleteFromLocalDB(String modelId);
  Future<void> softDeleteFromLocalDB(String modelId);
  Future<void> updateWithinLocalDB(T model);
  Future<List<T>> getAllFromLocalDB();
  Future<T?> getItemFromLocalDB(String modelId);
  Future<void> insertAllStudyLevel(List<T> entities);
}
