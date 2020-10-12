import 'package:test/test.dart';
import 'package:postgrest/postgrest.dart';

void main() {
  var rootUrl = 'http://localhost:3000';
  PostgrestClient postgrest;

  setUp(() {
    postgrest = PostgrestClient(rootUrl);
  });

  test('embedded select', () async {
    var res = await postgrest.from('users').select('messages(*)').end();
    expect(res.data[0]['messages'].length, 2);
    expect(res.data[1]['messages'].length, 0);
  });

  test('embedded eq', () async {
    var res =
        await postgrest.from('users').select('messages(*)').eq('messages.channel_id', 1).end();
    expect(res.data[0]['messages'].length, 1);
    expect(res.data[1]['messages'].length, 0);
    expect(res.data[2]['messages'].length, 0);
    expect(res.data[3]['messages'].length, 0);
  });

  test('embedded order', () async {
    var res = await postgrest
        .from('users')
        .select('messages(*)')
        .order('channel_id', foreignTable: 'messages', ascending: false).end();
    expect(res.data[0]['messages'].length, 2);
    expect(res.data[1]['messages'].length, 0);
    expect(res.data[2]['messages'].length, 0);
    expect(res.data[3]['messages'].length, 0);
  });

  test('embedded limit', () async {
    var res = await postgrest
        .from('users')
        .select('messages(*)')
        .limit(1, foreignTable: 'messages').end();
    expect(res.data[0]['messages'].length, 1);
    expect(res.data[1]['messages'].length, 0);
    expect(res.data[2]['messages'].length, 0);
    expect(res.data[3]['messages'].length, 0);
  });

  test('embedded range', () async {
    var res = await postgrest
        .from('users')
        .select('messages(*)')
        .range(1, 1, foreignTable: 'messages').end();
    expect(res.data[0]['messages'].length, 1);
    expect(res.data[1]['messages'].length, 0);
    expect(res.data[2]['messages'].length, 0);
    expect(res.data[3]['messages'].length, 0);
  });
}
