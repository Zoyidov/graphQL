const getDataQuery = '''
    query Data() {
    ships{
        id
        model
        name
        image
        status
        roles
        year_built
        type
    }
  }
''';
