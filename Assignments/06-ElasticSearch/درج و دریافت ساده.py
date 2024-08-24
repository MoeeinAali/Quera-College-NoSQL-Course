def create_index(client, name):
    client.indices.create(index=name)


def index_document(client, index_name, document):
    return client.index(index=index_name, document=document)['_id']


def find_document_by_id(client, index_name, id):
    return client.get(index=index_name, id=id)
