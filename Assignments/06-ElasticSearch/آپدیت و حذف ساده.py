def update_document(client, index_name, document_id, new_document):
    client.update(
        index=index_name,
        id=document_id,
        doc=new_document
    )

def delete_document_fields(client, index_name, document_id, field_names):
    script = " ".join([f"ctx._source.remove('{field}');" for field in field_names])
    client.update(
        index=index_name,
        id=document_id,
        script=script
    )

def delete_index(client, index_name):
    client.indices.delete(index=index_name)

def delete_document(client, index_name, document_id):
    client.delete(
        index=index_name,
        id=document_id
    )
