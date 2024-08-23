def remote_jobs(client):
    query = {
        "query": {
            "term": {
                "offers_remote": True
            }
        },
        "sort": [
            {"id": {"order": "desc"}}
        ]
    }
    result = client.search(index="quera", body=query)
    return extract_hits(result)

def front_end_jobs(client, from_=0, size=500):
    result = client.search(index='quera', query={
        "match": {
            "title": "front"
        }
    }, sort='id:desc', from_=from_, size=size)
    return extract_hits(result)

def quera_golden_jobs(client, from_=0, size=500):
    result = client.search(index='quera', query={
        'bool': {
            'must': [
                {
                    'match': {
                        'title': {
                            'query': 'AI',
                            'boost': 3.0
                        }
                    }
                },
                {
                    'range': {
                        'minimum_salary': {
                            'gte': 30_000_000,
                            'boost': 2.0
                        }
                    }
                },
                {
                    'term': {
                        'level': {
                            'value': 'senior',
                            'boost': 1.0
                        }
                    }
                },
            ],
            'minimum_should_match': 1
        }
    }, from_=from_, size=size)
    return extract_hits(result)

def extract_hits(result_set):
    return list(
        map(
            lambda row: row['_source'],
            result_set['hits']['hits'],
        )
    )
