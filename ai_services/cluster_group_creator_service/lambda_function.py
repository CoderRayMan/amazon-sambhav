from create_clusters import CreateClusters


def lambda_handler(event, context):
    print("Staring job")
    print(event)
    obj = CreateClusters()
    obj.create_clusters(w_id="W11001")
