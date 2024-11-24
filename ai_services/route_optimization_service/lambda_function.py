from optimizer_service import OptimizeRoutes


def lambda_handler(event, context):
    # if __name__ == '__main__':
    print("Staring job")
    # print(event)
    obj = OptimizeRoutes()
    obj.optimize_route(c_id="C1")
