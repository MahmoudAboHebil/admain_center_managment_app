/*

class RemoteRoomService extends Database {
  const RemoteRoomService(this.client);
  final SupabaseClient client;
  @override
  Future<List<RoomModel>> getAll(CenterId centerId) async {
    try {
      final centerIdVal = centerId.getOrCrash();
      final data = await client
          .from('room')
          .select()
          .eq('center_id', centerIdVal)
          .order('created_at', ascending: false);
      final rooms = data.map((e) => RoomModel.fromJson(e)).toList();
      return rooms;
    } on PostgrestException catch (e) {
      throw ServerFailure(message: e.message);
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } on TimeoutException {
      throw const NetworkFailure(message: 'Connection timeout');
    }
  }

  Future<RoomModel> insert(RoomModel roomModel) async {
    try {
      final data = await client
          .from('room')
          .insert(RoomModel.toJson(roomModel))
          .select()
          .single();
      final model = RoomModel.fromJson(data);
      return model;
    } on PostgrestException catch (e) {
      throw ServerFailure(message: e.message);
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } on TimeoutException {
      throw const NetworkFailure(message: 'Connection timeout');
    }
  }

  ///todo: hard deleted from server
  Future<void> delete(RoomModel roomModel) async {
    try {
      await client.from('room').delete().eq('id', roomModel.serverId!);
    } on PostgrestException catch (e) {
      throw ServerFailure(message: e.message);
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } on TimeoutException {
      throw const NetworkFailure(message: 'Connection timeout');
    }
  }

  Future<RoomModel> updateRoomToServer(RoomModel roomModel) async {
    try {
      final data = await client
          .from('room')
          .update(RoomModel.toJson(roomModel))
          .eq('center_id', roomModel.centerId)
          .eq('id', roomModel.serverId!)
          .select()
          .single();
      final model = RoomModel.fromJson(data);
      return model;
    } on PostgrestException catch (e) {
      throw ServerFailure(message: e.message);
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    } on TimeoutException {
      throw const NetworkFailure(message: 'Connection timeout');
    }
  }
}

 */
