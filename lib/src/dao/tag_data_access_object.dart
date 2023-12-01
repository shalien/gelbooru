part of '../data_access_object.dart';

/// The order parameter.
typedef Order = String;

/// The order ascending parameter.
const Order orderAscending = 'asc';

/// The order descending parameter.
const Order orderDescending = 'desc';

/// The order by parameter.
typedef OrderBy = String;

/// The order by id parameter.
const OrderBy orderById = 'date';

/// The order by date parameter.
const OrderBy orderByDate = 'count';

/// The order by count parameter.
const OrderBy orderByCount = 'name';

/// A data access object for [Tag]s.
final class TagDataAccessObject extends DataAccessObject<Tag> {
  /// Create a [TagDataAccessObject].
  TagDataAccessObject(client) : super(client, 'tag');

  /// Return a list of [Tag]s.
  ///
  /// [id] The tag's id in the database. This is useful to grab a specific tag if you already know this value.
  /// [limit] How many tags you want to retrieve. There is a default limit of 100 per request.
  /// [afterId] Grab tags whose ID is greater than this value.
  /// [name] Find tag information based on this value.
  /// [names] Separated by spaces, get multiple results to tags you specify if it exists. (schoolgirl moon cat)
  /// [namePattern] A wildcard search for your query using LIKE. Use _ for single character wildcards or % for multi-character wildcards. (%choolgirl% would act as *choolgirl* wildcard search.)
  /// [Order] by field specified (ASC or DESC)
  /// [OrderBy] a field.
  @override
  Future<List<Tag>> index(
      {int limit = 100,
      int? id,
      int? afterId,
      String? name,
      List<String>? names,
      String? namePattern,
      Order? order,
      OrderBy? orderBy}) async {
    limit = limit.clamp(1, 100);

    Uri uri = Uri.https(super.host, 'index.php', {
      'page': 'dapi',
      's': _endpoint,
      'q': 'index',
      'limit': limit.toString(),
      ...(id != null ? {'id': id.toString()} : {}),
      ...(afterId != null ? {'after_id': afterId.toString()} : {}),
      ...(name != null ? {'name': name} : {}),
      ...(names != null ? {'names': names.join(' ')} : {}),
      ...(namePattern != null ? {'name_pattern': namePattern} : {}),
      ...(order != null ? {'order': order} : {}),
      ...(orderBy != null ? {'order_by': orderBy} : {}),
    });

    Response response;

    try {
      response = await super.client.get(uri);
    } on ClientException {
      rethrow;
    }

    if (response.statusCode != 200) {
      throw BooruException.fromResponse(response);
    }

    XmlDocument document;

    try {
      document = XmlDocument.parse(response.body);
    } on XmlParserException {
      rethrow;
    } on XmlTagException {
      rethrow;
    }

    List<Tag> tags = [];

    for (var element in document.findAllElements('tag')) {
      Map<String, dynamic> map;

      if (element.attributes.isNotEmpty) {
        map = {
          'id': element.getAttribute('id') == null
              ? null
              : int.parse(element.getAttribute('id')!),
          'name': element.getAttribute('name') ?? '',
          'count': element.getAttribute('count') == null
              ? null
              : int.parse(element.getAttribute('count')!),
          'type': element.getAttribute('type') == null
              ? null
              : int.parse(element.getAttribute('type')!),
          'ambiguous': element.getAttribute('ambiguous') == null
              ? null
              : element.getAttribute('ambiguous') == 'true'
                  ? true
                  : false,
        };
      } else if (element.children.isNotEmpty) {
        map = {
          'id': int.parse(element.getElement('id')!.innerText),
          'name': element.getElement('name')?.value,
          'count': int.parse(element.getElement('count')!.innerText),
          'type': int.tryParse(element.getElement('type')!.innerText),
          'ambiguous': element.getElement('ambiguous')!.innerText == 'true'
              ? true
              : false,
        };
      } else {
        throw Exception('Tag element is empty');
      }
      tags.add(Tag.fromMap(map));
    }

    return tags;
  }
}
